class Methods::InterpolationController < ApplicationController
skip_before_filter :verify_authenticity_token
require './app/assets/ruby/Utilities'
$utilities = Utilities.new()
$metodo = []
  def lagrange
  end
  def lagrange2
     $metodo.clear
     $x = $utilities.strToArray(params[:x])
     $y = $utilities.strToArray(params[:y])
     $valor = params[:valor].to_f
     valor=$valor
     x=$x
     y=$y
     puntos=$x.size
     resultado = 0
     pol = "P(x): "
     k = 0
     while k<puntos
        productoria=1
        termino = " "
        i = 0
        while i < puntos 
         if i!=k
             productoria=productoria*(valor-x[i])/(x[k]-x[i])
             termino = termino + ("[(x-"+x[i].to_s+")/("+x[k].to_s+"-"+x[i].to_s+")]")
         end
         i=i+1
        end
        l= "L"+k.to_s+"(x):"+termino.to_s
        l= l.gsub("--","+")
        $iteracion = [l]
        $metodo.push($iteracion)
        
        if y[k]>0
            pol+="+" + y[k].to_s+"*"+termino.to_s+"\n"
        else
            pol +="" + y[k].to_s+"*"+termino.to_s+"\n"
        end
        resultado += productoria * y[k];
        k=k+1
     end
    
    #puts("\nPolinomio interpolante:")
    pol= (pol.gsub("--","+"))
    #puts("Resultado:")
    re=("f("+valor.to_s+") = "+ resultado.to_s)
    res= re.gsub("--","+")
    $iteracion = [pol]
    $metodo.push($iteracion)
     $iteracion = [res]
    $metodo.push($iteracion)
    redirect_to "/methods/interpolation/lagrange.html"
  end
  def newton
  end

  def linear
  end

  def cubic
  end

  def reduction
  end
end
