import java.io.*;
import java.util.*;

class stackMachine
{
    Stack<Integer> s = new Stack<Integer>();

    void push(int x)
    {
        s.push(x);
    }

    void pop()
    {
        if(s.isEmpty()!=true)
        {
            System.out.print(s.peek());
            System.out.println();
            s.pop();
        }
    }

    void dup()
    {
        if(!s.isEmpty())
        {
            int x = s.peek();
            s.push(x);
        }
    } 

    void add()
    {
        if(!s.isEmpty())
        {
            int x = s.peek();
            s.pop();
            if(!s.isEmpty())
            {
                int y = s.peek();
                s.pop();

                int t = x+y;
                s.push(t);
            }
            else
            {
                s.push(x);
            }
        }
    }

    void sub()
    {
        if(!s.isEmpty())
        {
            int x = s.peek();
            s.pop();
            if(!s.isEmpty())
            {
                int y = s.peek();
                s.pop();

                int t = x-y;
                s.push(t);
            }
            else
            {
                s.push(x);
            }
        }
    }

    void mul()
    {
        if(!s.isEmpty())
        {
            int x = s.peek();
            s.pop();
            if(!s.isEmpty())
            {
                int y = s.peek();
                s.pop();

                int t = x*y;
                s.push(t);
            }
            else
            {
                s.push(x);
            }
        }
    }

    void div()
    {
        if(!s.isEmpty())
        {
            int x = s.peek();
            s.pop();
            if(!s.isEmpty())
            {
                int y = s.peek();
                s.pop();

                int t = x/y;
                s.push(t);
            }
            else
            {
                s.push(x);
            }
        }
    }

}



class Calc
{
    public static void main(String[] args)
    {
        stackMachine S = new stackMachine();

        String opcode;
        
        //while !eof inputs opcode
        for(int i=0;i<Code.code.length;i++)
        {
            opcode = (Code.code)[i];
            if(opcode=="push")
            {
                int x;
                x = Integer.parseInt(Code.code[++i]);
                S.push(x);
            }
            else if(opcode=="pop")
            {
                S.pop();
            }      
            else if(opcode=="dup")
            {
                S.dup();
            }
            else if(opcode=="add")
            {
                S.add();
            }
            else if(opcode=="sub")
            {
                S.sub();
            }
            else if(opcode=="mul")
            {
                S.mul();
            }
            else if(opcode=="div")
            {
                S.div();
            }     
        }
        
    }
}