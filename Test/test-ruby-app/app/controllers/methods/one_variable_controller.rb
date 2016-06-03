class Methods::OneVariableController < ApplicationController
skip_before_filter :verify_authenticity_token
require './app/assets/ruby/Utilities'
$utilities = Utilities.new()
$metodo = []
$iteracion = []
$gx = $funcion
$gx = $gx.downcase


  def bisection
  end

  def false_rule
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
end
