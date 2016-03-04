/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Test_numerical_analysis;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import org.boris.expr.Expr;
import org.boris.expr.ExprEvaluatable;
import org.boris.expr.parser.ExprParser;
import org.boris.expr.util.Exprs;
import org.boris.expr.util.SimpleEvaluationContext;


/**
 *
 * @author Jrincon
 */
public class EnsayoYeison {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) throws Exception {
        // TODO code application logic here
        SimpleEvaluationContext context = new SimpleEvaluationContext();
        System.out.println("evaluar expresion");
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        while (true){
            try{
                System.out.print(">");
                String line = br.readLine();
                if (line == null) 
                    break;
                Funcion fun = new Funcion(line);
                Intervalo intervalo = new Intervalo(-100,100);
                float inc = 1;
                Busqueda bus = new Busqueda(fun,intervalo,inc);
                bus.buscar();
                /*
                Expr e = ExprParser.parse(line);
                Exprs.toUpperCase(e);
                if (e instanceof ExprEvaluatable) {
                    e = ((ExprEvaluatable) e).evaluate(context);
                }
                System.out.println(e);*/
                
            }catch (Exception e){
                e.printStackTrace();
            }
        }
    }
    
}
