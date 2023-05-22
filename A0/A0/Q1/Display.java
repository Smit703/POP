import java.io.*;
import java.util.*;

public class Display
{
    static void print(char[][] mat,int n,int m,int l)
    {
        for(int i=0;i<n;i++)
        {
            for(int j=0;j<m*l+l;j++)
            {
                System.out.print(mat[i][j]);
            }
            System.out.println(); 
        }
    }

    static void a(char[][] mat,int offset,int m,int n,char c)
    {
        for(int i=0;i<n;i++)
        {
            for(int j=offset;j<m+offset;j++)
            {
                if(i==0 || i==n/2)
                {
                    mat[i][j]=c;
                    if(i==0 && j==offset)
                    {
                        mat[i][j]=' ';
                    }
                    if(i==0 && j==m+offset-1)
                    {
                        mat[i][j]=' ';
                    }
                }
                else if(j==offset || j==m+offset-1)
                {
                    mat[i][j]=c;
                }
            }
        }
    }

    static void e(char[][] mat,int offset,int m,int n,char c)
    {
        for(int i=0;i<n;i++)
        {
            for(int j=offset;j<m+offset;j++)
            {
                if(i==0 || i==n/2 || i==n-1)
                {
                    mat[i][j]=c;
                    if(i==n/2 && j==m+offset-1)
                    {
                        mat[i][j]=' ';
                    }
                }
                else if(j==offset)
                {
                    mat[i][j]=c;
                }
            }
        }

    }

    static void i(char[][] mat,int offset,int m,int n,char c)
    {
        for(int i=0;i<n;i++)
        {
            for(int j=offset;j<m+offset;j++)
            {
                if(i==0 || i==n-1)
                {
                    mat[i][j]=c;
                }
                else if(j==(m/2+offset))
                {
                    mat[i][j]=c;
                }
            }
        }   
    }

    static void o(char[][] mat,int offset,int m,int n,char c)
    {
        for(int i=0;i<n;i++)
        {
            for(int j=offset;j<m+offset;j++)
            {
                if(i==0 || i==n-1 || j==offset || j==m+offset-1)
                {
                    mat[i][j]=c;
                }
            }
        }
        
        mat[n-1][offset]=' ';
        mat[n-1][m+offset-1]=' ';
        mat[0][offset]=' ';
        mat[0][m+offset-1]=' ';
    }

    static void u(char[][] mat,int offset,int m,int n,char c)
    {
        for(int i=0;i<n;i++)
        {
            for(int j=offset;j<m+offset;j++)
            {
                if(i==n-1)
                {
                    mat[i][j]=c;
                }
                else if(j==offset || j==m+offset-1)
                {
                    mat[i][j]=c;
                }
            }
        }
        
        mat[n-1][offset]=' ';
        mat[n-1][m+offset-1]=' ';
        
    }

    static void b(char[][] mat,int offset,int m,int n,char c)
    {
        for(int i=0;i<n;i++)
        {
            for(int j=offset;j<m+offset;j++)
            {
                if(i==0 || i==n/2 || i==n-1)
                {
                    mat[i][j]=c;
                    if(j==m+offset-1)
                    {
                        mat[i][j]=' ';
                    }
                }
                else if(j==offset || j==m+offset-1)
                {
                    mat[i][j]=c;
                }
            }
        }    
    }

    static void c(char[][] mat,int offset,int m,int n,char c)
    {
        for(int i=0;i<n;i++)
        {
            for(int j=offset;j<m+offset;j++)
            {
                if(i==0 || i==n-1 || j==offset)
                {
                    mat[i][j]=c;
                }
            }
        }
        mat[0][offset]=' ';
        mat[n-1][offset]=' '; 
    }

    static void d(char[][] mat,int offset,int m,int n,char c)
    {
        for(int i=0;i<n;i++)
        {
            for(int j=offset;j<m+offset;j++)
            {
                if(i==0 || i==n-1 || j==offset || j==m+offset-1)
                {
                    mat[i][j]=c;
                    if((i==0 || i==n-1) && j==m+offset-1)
                    {
                        mat[i][j]=' ';
                    }
                }
            }
        }
    }

    static void f(char[][] mat,int offset,int m,int n,char c)
    {
        for(int i=0;i<n;i++)
        {
            for(int j=offset;j<m+offset;j++)
            {
                if(i==0 || i==n/2 || j==offset)
                {
                    mat[i][j]=c;
                    if(i==n/2 && j==m+offset-1)
                    {
                        mat[i][j]=' ';
                    }
                }
            }
        }  
    }


    public static void main(String[] args)
    {
        int m=6; 
        int n=6;
        char c = '#';

        //String s="aeioubcdf";
        //input s

        String s = args[args.length-1];

        //input m,n,c and change there values accordingly
        for(int i=0;i<args.length-1;i++)
        {
            if(args[i].equals("-m"))
            {
                m=Integer.valueOf(args[i+1]);
            }
            if(args[i].equals("-n"))
            {
                n=Integer.valueOf(args[i+1]);
            }
            if(args[i].equals("-c"))
            {
                c=args[i+1].charAt(0);
            }
        }

        char[][] mat = new char[n][m*s.length()+s.length()];
        for(int i=0;i<n;i++)
        {
            for(int j=0;j<m*s.length()+s.length();j++)
            {
                mat[i][j]=' ';
            }
        }

        int offset = 0;
        for(int i=0;i<s.length();i++)
        {
            char opcode = s.charAt(i);

            switch(opcode)
            {
                case 'a': a(mat,offset,m,n,c);
                          break;
                
                case 'e': e(mat,offset,m,n,c);
                          break;

                case 'i': i(mat,offset,m,n,c);
                          break;

                case 'o': o(mat,offset,m,n,c);
                          break;

                case 'u': u(mat,offset,m,n,c);
                          break;

                case 'b': b(mat,offset,m,n,c);
                          break;

                case 'c': c(mat,offset,m,n,c);
                          break;

                case 'd': d(mat,offset,m,n,c);
                          break;

                case 'f': f(mat,offset,m,n,c);
                          break;
            }
            offset=offset+m+1;
        }
        print(mat,n,m,s.length());

    }
}