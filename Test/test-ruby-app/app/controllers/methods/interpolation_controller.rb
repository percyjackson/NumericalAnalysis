class Methods::InterpolationController < ApplicationController
skip_before_filter :verify_authenticity_token
require './app/assets/ruby/Utilities'
$utilities = Utilities.new()
$metodo = []
$eq = []
$nat = []
$x = []
$y = []
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
  def newton2
     $metodo.clear
     $x = $utilities.strToArray(params[:x])
     $y = $utilities.strToArray(params[:y])
     $valor = params[:valor].to_f
     valor=$valor
     x=$x
     y=$y
     puntos=$x.size
     tabla = Array.new(puntos) { Array.new(puntos) }
    
     i=0
     while i < puntos
       tabla [i][0]=y[i]
       i=i+1
     end
     s = 0
     while s < puntos
      j=1
      while j<=s
        tabla[s][j] = (tabla[s][j-1] - tabla[s-1][j-1])/(x[s] - x[s-j])
        j=j+1
      end
      s=s+1
     end
    
     pol = "P(x): "+(tabla[0][0].to_s)
     temp= ""
     resultado= tabla[0][0]
     aux = 1 
    
     i=1
     while i<puntos
      temp = temp + "(x"+"-"+(x[i-1]).to_s+")"
       if tabla [i][i]>0.0
         pol= pol+"\n"+"+"+(tabla[i][i].to_s+"*"+temp.to_s)
       else
         pol= pol+"\n"+""+(tabla[i][i].to_s+"*"+temp.to_s)
       end
      aux = aux * (valor-x[i-1]);
      resultado = resultado + tabla[i][i]*aux;
      i=i+1
     end
     
    
     res=("f("+valor.to_s+") = "+ resultado.to_s)
     $iteracion = [pol]
     $metodo.push($iteracion)
     $iteracion = [res]
     $metodo.push($iteracion)
     redirect_to "/methods/interpolation/newton.html"
  end
  

  def linear
  end
  def linear2
     $metodo.clear
     $x = $utilities.strToArray(params[:x])
     $y = $utilities.strToArray(params[:y])
     $valor = params[:valor].to_f
     #valor=$valor
     x=$x
     y=$y
     puntos=$x.size
     i=0
     while i<puntos-1
        m =(y[i+1]-y[i])/(x[i+1]-x[i])
        pol = + ("[" + m.to_s + "*(x-" + (x[i]).to_s + ")]+" + (y[i]).to_s)
        a= pol.gsub("--","+") 
        a1= x[i].to_s+"<=x<="+x[i+1].to_s
        $iteracion = [a,a1]
        $metodo.push($iteracion)
        i=i+1
     end
     redirect_to "/methods/interpolation/linear.html"
  end

  def cubic
  end

  def cubic2
    $metodo.clear
    $x = $utilities.strToArray(params[:x])
    $y = $utilities.strToArray(params[:y])
    $eq, $nat = $utilities.cubic($x,$y)
    redirect_to "/methods/interpolation/cubic.html"
  end
  def reduction
  end
end
