class Methods::OneVariableController < ApplicationController
skip_before_filter :verify_authenticity_token
require './app/assets/ruby/Utilities'
$utilities = Utilities.new()
$metodo = []
$iteracion = []
$gx = $funcion
$gx = $gx.downcase
$a = 0
$b = 0

  def bisection
  end
  def bisection2
    $iteraciones = params[:iterations].to_f
    $delta = params[:delta].to_f
    $tol = params[:tol].to_f
    $a= $interval.a
    $b= $interval.b
    $gx = $funcion
    
    $gx = $gx.downcase
    $metodo.clear
    
    fa = $utilities.reemplazarX($gx,$a)
    fb = $utilities.reemplazarX($gx,$b)

    fa = $utilities.evaluar(fa)
    fb = $utilities.evaluar(fb)
    c = (($b+$a)/2.0).round(15).to_f
   
    fc=$utilities.reemplazarX($gx,c)
    fc=$utilities.evaluar(fc)
    error = c.abs.round(15).to_f
    cont = 1
    #puts "Iter. \t a \t \t b \t \t Xs \t Error"
    #puts "#{cont} \t #{a} \t #{b} \t #{c} \t #{fc}\t #{error}"
    $iteracion = [0,$a,$b,c,fc,"N/A"]
    $metodo.push($iteracion)
    puts $gx
    puts c
    puts fc

    while (fc != 0.0 &&  error > $tol && $iteraciones>cont )

      if (fa * fc < 0.0)
        $b=c
      else
        $a=c
      end
      tmp=c
      fa = $utilities.reemplazarX($gx,$a)
      fb = $utilities.reemplazarX($gx,$b)
      fa = $utilities.evaluar(fa)
      fb = $utilities.evaluar(fb)
      c = (($a+$b)/2.0).round(15).to_f
      fc=$utilities.reemplazarX($gx,c)
      fc=$utilities.evaluar(fc)
      error = (c - tmp).abs.round(15).to_f
      
      $iteracion = [cont,$a,$b,c,fc,error]
      $metodo.push($iteracion)
      #puts "#{cont} \t #{a} \t #{b} \t #{c} \t #{fc}\t #{error}"
      cont +=1
    end
    redirect_to "/methods/one_variable/bisection.html"
  end

  def false_rule
  end
  def reglaFalsa
    $iteraciones = params[:iterations].to_f
    $delta = params[:delta].to_f
    $tol = params[:tol].to_f
    $a= $interval.a
    $b= $interval.b
    $gx = $funcion
    
    $gx = $gx.downcase
    $metodo.clear
    
    fa = $utilities.reemplazarX($gx,$a)
    fb = $utilities.reemplazarX($gx,$b)

    fa = $utilities.evaluar(fa)
    fb = $utilities.evaluar(fb)
    c = ($b - (($b - $a) / (fb - fa))*fb).round(15).to_f
   
    fc=$utilities.reemplazarX($gx,c)
    fc=$utilities.evaluar(fc)
    error = c.abs.round(15).to_f
    cont = 1
    #puts "Iter. \t a \t \t b \t \t Xs \t Error"
    #puts "#{cont} \t #{a} \t #{b} \t #{c} \t #{fc}\t #{error}"
    $iteracion = [0,$a,$b,c,fc,"N/A"]
    $metodo.push($iteracion)
    puts $gx
    puts c
    puts fc

    while (fc != 0.0 &&  error > $tol && $iteraciones>cont )

      if (fa * fc < 0.0)
        $b=c
      else
        $a=c
      end
      tmp=c
      fa = $utilities.reemplazarX($gx,$a)
      fb = $utilities.reemplazarX($gx,$b)
      fa = $utilities.evaluar(fa)
      fb = $utilities.evaluar(fb)
      c = ($b - (($b - $a) / (fb - fa))*fb).round(15).to_f
      fc=$utilities.reemplazarX($gx,c)
      fc=$utilities.evaluar(fc)
      error = (c - tmp).abs.round(15).to_f
      
      $iteracion = [cont,$a,$b,c,fc,error]
      $metodo.push($iteracion)
      #puts "#{cont} \t #{a} \t #{b} \t #{c} \t #{fc}\t #{error}"
      cont +=1
    end
    redirect_to "/methods/one_variable/false_rule.html"
  end
  def fixed_point
    $gx = $funcion
    $gx = $gx.downcase
    $x = ($interval.a + $interval.b)/2
  end
  
  def punto_fijo
    $iteraciones = params[:iterations].to_f
    $delta = params[:delta].to_f
    $tol = params[:tol].to_f
    $gx = params[:gx].to_s
    $x = params[:x].to_f
    
    $gx = $gx.downcase
    $metodo.clear
    $gx2 = $utilities.reemplazarX($gx,$x)
    
    $gx2 = $utilities.evaluar($gx2)
    error = 1000
    
    cont = 1
    $iteracion = [0,$x,$gx2,"N/A"]
    $metodo.push($iteracion)
    while (cont <= $iteraciones && error > $tol && $gx2.abs > $delta ) do
      x0 = $gx2
      $gx2 = $utilities.reemplazarX($gx,x0)
      $gx2 = $utilities.evaluar($gx2)
      
      error = ($gx2 - x0).abs.round(15)
      $iteracion = [cont,x0,$gx2,error]
      $metodo.push($iteracion)
      cont +=1
    end
    redirect_to "/methods/one_variable/fixed_point.html"
  end

  def secant
  end
  
  def secante
    $iteraciones = params[:iterations].to_f
    $delta = params[:delta].to_f
    $tol = params[:tol].to_f
    $a = params[:a].to_f
    $b = params[:b].to_f
    $metodo.clear
    iteracion = []
    fun = $funcion
    utilities = $utilities
    a = $a
    b = $b
    fa = utilities.reemplazarX(fun,a)
    fb = utilities.reemplazarX(fun,b)
    
    fa = utilities.evaluar(fa)
    fb = utilities.evaluar(fb)
    
    xs = (b - ((b - a) / (fb - fa))*fb).round(15)
    error = (b - a).abs.round(15).to_f
    cont = 1
    iteracion = [cont,a,b,xs,error]
    $metodo.push(iteracion)
    while (fa != fb) && (error > $tol) && (cont <= $iteraciones) && ((fb).abs > $delta) do
      b = a
      a = xs
      fa = utilities.reemplazarX(fun,a)
      fb = utilities.reemplazarX(fun,b)
      fa = utilities.evaluar(fa)
      fb = utilities.evaluar(fb)
      xs = (b - ((b - a) / (fb - fa))*fb).round(15)
      error = (b - a).abs.round(15).to_f
      cont +=1
      iteracion = [cont,a,b,xs,error]
      $metodo.push(iteracion)
    end
    p $metodo
    redirect_to "/methods/one_variable/secant.html"
  end

  def newton_raphson
    $gx = $funcion
    $gx = $gx.downcase
    $metodo.clear
    $x = ($interval.a + $interval.b)/2
  end

  def newtonRaphson
    $iteraciones = params[:iterations].to_f
    $delta = params[:delta].to_f
    $tol = params[:tol].to_f
    $gx = params[:ddx].to_s #ddx
    $x = params[:x].to_f
    
    $gx = $gx.downcase
    $metodo.clear
    $funcion = $funcion.downcase
    
    fx2 = $utilities.reemplazarX($funcion,$x)
    ddx2 = $utilities.reemplazarX($gx,$x)
    
    
    fx2 = $utilities.evaluar(fx2)
    ddx2 = $utilities.evaluar(ddx2)
    xs = ($x - (fx2)/(ddx2)).round(15)
    error = 1000
    
    cont = 1
    puts "Iter. \t x \t \t \t f(x) \t \t \t f'(x) \t \t \t Error"
    puts "0 \t #{$x} \t \t \t #{fx2} \t #{ddx2} \t N/A"
    $iteracion = [0,$x,fx2,ddx2,"N/A"]
    $metodo.push($iteracion)
    while ((cont <= $iteraciones) && (error > $tol) && (fx2.abs > $delta) ) do
      fx2 = $utilities.reemplazarX($funcion,$x)
      ddx2 = $utilities.reemplazarX($gx,$x)
    
      fx2 = $utilities.evaluar(fx2)
      ddx2 = $utilities.evaluar(ddx2)
      
      xs = ($x - (fx2)/(ddx2)).round(15)
      error = ($x - xs).abs.round(15)
      $x = xs
      puts "#{cont} \t #{xs} \t #{fx2} \t #{ddx2} \t #{error}"
      $iteracion = [cont,xs,fx2,ddx2,error]
      $metodo.push($iteracion)
      cont +=1
    end
    redirect_to "/methods/one_variable/newton_raphson.html"
  end
  def newton2
    
  end
  def newtonModificado
    $iteraciones = params[:iterations].to_f
    $delta = params[:delta].to_f
    $tol = params[:tol].to_f
    $dx = params[:ddx].to_s #dx
    $d2x = params[:d2x].to_s #d2x
    $x = params[:x].to_f
    
    $dx = $dx.downcase
    $d2x = $d2x.downcase
    $metodo.clear
    $fx = $funcion.downcase
    #fx = "x^3-5*x^2+7*x-3"
    #dx = "3*x^2-10*x+7"
    #d2x = "6*x-10"

    fx = $utilities.reemplazarX($fx,$x)
    dx = $utilities.reemplazarX($dx,$x)
    d2x = $utilities.reemplazarX($d2x,$x)

    fx = $utilities.evaluar(fx)
    dx = $utilities.evaluar(dx)
    d2x = $utilities.evaluar(d2x)

    xs = ($x-((dx*fx)/((dx*dx)-d2x*fx))).round(15)
    error = 1000
    $iteracion = [0,$x,fx,"N/A",dx,d2x]
    $metodo.push($iteracion)
    cont = 1
    #puts "Iter. \t x \t \t \t f(x) \t \t \t f'(x) \t \t \t Error"
    #puts "0 \t #{x} \t \t \t #{fx} \t #{dx} \t #{d2x} \t N/A"
    while (cont <= $iteraciones && error > $tol && fx.abs > $delta ) do
  
  
      fx = $utilities.reemplazarX($fx,xs)
      dx = $utilities.reemplazarX($dx,xs)
      d2x = $utilities.reemplazarX($d2x,xs)

      fx = $utilities.evaluar(fx)
      dx = $utilities.evaluar(dx)
      d2x = $utilities.evaluar(d2x)
      tmp = xs
      xs = (xs-((dx*fx)/((dx*dx)-d2x*fx))).round(15)
      error = (xs - tmp).abs.round(15)
      $iteracion = [cont,xs,fx,error,dx,d2x]
      $metodo.push($iteracion)
      #puts "#{cont} \t #{xs} \t #{fx} \t #{dx} \t #{d2x} \t #{error}"
      cont +=1
    end
    redirect_to "/methods/one_variable/newton2.html"
  end
end
