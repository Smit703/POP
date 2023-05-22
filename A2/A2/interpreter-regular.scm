(load "recscm.scm")
(load "records.scm")
(load "tree.scm")

(require rnrs/mutable-pairs-6)

(define-record closure (formals body env))
(define-record normal-env (ids vals env))
(define-record rec-env (recdecl-list env))

(define empty-env
	'())

(define extend-env
	(lambda (id val env)
	(cons (mcons id val) env)))

(define apply-env
	(lambda (env id)
	(if (or (null? env) (null? id))
	null
	(let ((key (mcar (car env)))
	(val (mcdr (car env)))
	(env-prime (cdr env)))
	(if (eq? id key) val (apply-env env-prime id))))))

(define extend-env-list
	(lambda (ids vals env)
		(if (null? ids)
		env
		(extend-env-list
		(cdr ids)
		(cdr vals)
		(extend-env (car ids) (car vals) env)))))

(define (get-ids list)
	(if(null? list)
	'()
	(record-case (car list)
	(Declaration (Token1 Identifier Expression Token2)
	(cons (cadr Identifier) (get-ids (cdr list))))
	(RecDeclaration (Token1 Identifier ProcedureExp Token2)
    (cons (cadr Identifier) (get-ids (cdr list)))))))

(define (get-exprs list) 
	(if(null? list)
	'()
	(record-case (car list)
	(Declaration (Token1 Identifier Expression Token2)
	(cons Expression (get-exprs (cdr list))))
	(RecDeclaration (Token1 Identifier ProcedureExp Token2)
	(cons ProcedureExp (get-exprs (cdr list)))))))

(define (get-formals closure)
	(if(null? closure)
	'()
	(record-case closure
	(closure (formals body env)
	(define (get formals)
	(if(null? formals)
	'()
	(cons (car (cdr (car formals))) (get (cdr formals)))))
	(get formals)))))

(define (get-body closure)
	(if(null? closure)
	'()
	(record-case closure
	(closure (formals body env)
	body))))

(define (get-closure-env closure)
	(if(null? closure)
	'()
	(record-case closure
	(closure (formals body env)
	env))))

(define (change-env env id exp)
	(if(eq? (mcar (car env)) (cadr id))
	(set-mcdr! (car env) (eval-Expression exp env))
	(change-env (cdr env) id exp)))

(define eval-Expression
	(lambda (Expression env) 
		(record-case Expression (IntegerLiteral (Token) 
			(string->number Token))
		(TrueLiteral (Token) #t)
		(FalseLiteral (Token) #f)
		(PlusExpression (Token1 Token2 Expression1 Expression2 Token3)
			(+ (eval-Expression Expression1 env) (eval-Expression Expression2 env)))
		(IfExpression (Token1 Token2 Expression1 Expression2 Expression3 Token3)
			(if (eval-Expression Expression1 env) (eval-Expression Expression2 env) (eval-Expression Expression3 env)))
		(LetExpression (Token1 Token2 Token3 List Token4 Expression Token5)
			(let*  ((ids (get-ids List))
					(exps (get-exprs List))
					(vals (map (lambda (Expression) (eval-Expression Expression env)) exps))
					(new-env (extend-env-list ids vals env)))	
			(eval-Expression Expression new-env)))
		(Identifier (Token) (apply-env env Token))
		(Assignment (Token1 Token2 Identifier Expression Token3)
	 		(change-env env Identifier Expression))
		(ProcedureExp (Token1 Token2 Token3 List Token4 Expression Token5)
            (make-closure List Expression env))
		(Application (Token1 Expression List Token2)
			(let*  ((clos (eval-Expression Expression env))
					(ids (get-formals clos))
					(vals (map (lambda (Exp) (eval-Expression Exp env)) List))
					(static-env (get-closure-env clos))
					(new-env (extend-env-list ids vals static-env))
					(body (get-body clos)))	
			(eval-Expression body new-env)))
		(RecExpression (Token1 Token2 Token3 List Token4 Expression Token5)
			(let*  ((ids (get-ids List))
					(exps (get-exprs List))
					(vals (map (lambda (Expression) (eval-Expression Expression env)) exps))
					(new-env (extend-env-list ids vals env)))
			(eval-Expression Expression new-env)))

		(else (error 'eval-Expression "Expression not found")))
	)
)


(define run
(lambda ()
	(record-case root
		(Goal (Expression Token)
		  (eval-Expression Expression empty-env))
		 (else (error 'run "Goal not found")))))
(run)