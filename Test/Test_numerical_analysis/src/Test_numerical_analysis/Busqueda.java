/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Test_numerical_analysis;

import org.boris.expr.Expr;
import org.boris.expr.ExprEvaluatable;
import org.boris.expr.IEvaluationContext;
import org.boris.expr.parser.ExprParser;
import org.boris.expr.util.Exprs;
import org.boris.expr.util.SimpleEvaluationContext;

/**
 *
 * @author Jrincon
 */
public class Busqueda {
    Funcion funcion;
    Intervalo intervalo;
    String nuevafun;
    float inc;
    float valor;
    float ant;
    float act;
    float anterior;
    float actual;
    
    public Busqueda(Funcion fun, Intervalo intervalo, float inc){
        this.funcion=fun;
        this.intervalo= intervalo;
        this.inc=inc;
    }

    void buscar() {
        Intervalo inter = this.intervalo;
        String nfun = reemplazarX(inter.getA());
        this.actual = this.anterior = evaluar(nfun);
        this.act = this.ant = inter.getA();
        while(inter.getA() <= inter.getB()){
            nfun = reemplazarX(inter.getA());
            this.anterior = this.actual;
            this.ant = this.act;
            this.actual=evaluar(nfun);            
            this.act=inter.getA();
            if ((this.anterior > 0 && this.actual < 0)) {
                System.out.println("["+this.ant+","+this.act+"]");
            }else{
                if(this.anterior < 0 && this.actual > 0){
                    System.out.println("["+this.ant+","+this.act+"]");
                }
            }
            inter.setA(inter.getA()+this.inc);
        }
        
    }
    
    String reemplazarX(float x){
        this.nuevafun = this.funcion.getFuncion();
        this.nuevafun = this.nuevafun.toUpperCase();
        this.nuevafun = this.nuevafun.replace("(X)",("("+Float.toString(x)+")") );//cambiar algún (X) por (valor)
        
        
        this.nuevafun = this.nuevafun.replace("0X",("0*("+Float.toString(x)+")") );//cambiar algún (X) por (valor)
        this.nuevafun = this.nuevafun.replace("1X",("1*("+Float.toString(x)+")") );//cambiar algún (X) por (valor)
        this.nuevafun = this.nuevafun.replace("2X",("2*("+Float.toString(x)+")") );//cambiar algún (X) por (valor)
        this.nuevafun = this.nuevafun.replace("3X",("3*("+Float.toString(x)+")") );//cambiar algún (X) por (valor)
        this.nuevafun = this.nuevafun.replace("4X",("4*("+Float.toString(x)+")") );//cambiar algún (X) por (valor)
        this.nuevafun = this.nuevafun.replace("5X",("5*("+Float.toString(x)+")") );//cambiar algún (X) por (valor)
        this.nuevafun = this.nuevafun.replace("6X",("6*("+Float.toString(x)+")") );//cambiar algún (X) por (valor)
        this.nuevafun = this.nuevafun.replace("7X",("7*("+Float.toString(x)+")") );//cambiar algún (X) por (valor)
        this.nuevafun = this.nuevafun.replace("8X",("8*("+Float.toString(x)+")") );//cambiar algún (X) por (valor)
        this.nuevafun = this.nuevafun.replace("9X",("9*("+Float.toString(x)+")") );//cambiar algún (X) por (valor)
        
        
        this.nuevafun = this.nuevafun.replace("X^",("("+Float.toString(x)+")^") );//cambiar algún X^ por (valor)^
        this.nuevafun = this.nuevafun.replace("-X",("-("+Float.toString(x)+")") );//cambiar algún -x por -(valor)
        this.nuevafun = this.nuevafun.replace("+X",("+("+Float.toString(x)+")") );//cambiar algún +x por +(valor)
        this.nuevafun = this.nuevafun.replace("X+",("("+Float.toString(x)+")+") );//cambiar algún x+ por (valor)+
        this.nuevafun = this.nuevafun.replace("X-",("("+Float.toString(x)+")-") );//cambiar algún x- por (valor)-
        this.nuevafun = this.nuevafun.replace("*X",("*("+Float.toString(x)+")") );//cambiar algún *x por *(valor)
        this.nuevafun = this.nuevafun.replace("X*",("("+Float.toString(x)+")*") );//cambiar algún x* por(valor)*
        System.out.println(nuevafun);
        return nuevafun;
    }   

    private float evaluar(String nfun) /*throws Exception*/ {
        SimpleEvaluationContext context = new SimpleEvaluationContext();
        float r = 0;
        try {
        Expr e = ExprParser.parse(nfun);
                Exprs.toUpperCase(e);
                if (e instanceof ExprEvaluatable) {
                    e = ((ExprEvaluatable) e).evaluate(context);
                }
                //System.out.println(e);
                 r = Float.parseFloat(e.toString());
                return r;
        }catch (Exception ex){
                ex.printStackTrace();
            }
        return r;
    }
    
}
