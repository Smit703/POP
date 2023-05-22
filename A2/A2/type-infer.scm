(load "recscm.scm")
(load "records.scm")
(load "tree.scm")

(define empty-env
	'())

(define apply-env
	(lambda (env id)
	(if (or (null? env) (null? id))
	null
	(let ((key (mcar (car env)))
	(val (mcdr (car env)))
	(env-prime (cdr env)))
	(if (eq? id key) (if (promise? val) (force val) val) (apply-env env-prime id))))))


(define extend-env
	(lambda (id val env)
	(cons (mcons id val) env)))

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

(define extend-env-list
	(lambda (ids vals env)
		(if (null? ids)
		env
		(extend-env-list
		(cdr ids)
		(cdr vals)
		(extend-env (car ids) (car vals) env)))))

(define (change-env env id exp)
	(if(eq? (mcar (car env)) (cadr id))
	(set-mcdr! (car env) (eval-Expression exp env))
	(change-env (cdr env) id exp)))

(define eval-Expression
	(lambda (Expression env) 
		(record-case Expression (IntegerLiteral (Token) 
			'Int)
		(TrueLiteral (Token) 'Bool)
		(FalseLiteral (Token) 'Bool)
		(PlusExpression (Token1 Token2 Expression1 Expression2 Token3)
			(if(equal? 'Int (eval-Expression Expression1 env))
			(if(equal? 'Int (eval-Expression Expression2 env))
			'Int
			"Type Error")
			"Type Error"))
		(IfExpression (Token1 Token2 Expression1 Expression2 Expression3 Token3)
			(if(equal? 'Bool (eval-Expression Expression1 env))
			(if(equal?  (eval-Expression Expression2 env) (eval-Expression Expression3 env))
			(eval-Expression Expression2 env)
			"Type Error")
			"Type Error"))
		(LetExpression (Token1 Token2 Token3 List Token4 Expression Token5)
			(let*  ((ids (get-ids List))
					(exps (get-exprs List))
					(vals (map (lambda (Expression) (eval-Expression Expression env)) exps))
					(new-env (extend-env-list ids vals env)))	
			(eval-Expression Expression new-env)))
		(Identifier (Token) (apply-env env Token))
		(Assignment (Token1 Token2 Identifier Expression Token3)
	 		(change-env env Identifier Expression))

		(else "Type Error"))
	)
)

(define run
(lambda ()
	(record-case root
		(Goal (Expression Token)
		  (eval-Expression Expression empty-env))
		 (else (error 'run "Goal not found")))))
(run)