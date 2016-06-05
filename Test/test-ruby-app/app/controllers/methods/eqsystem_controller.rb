class Methods::EqsystemController < ApplicationController
  skip_before_filter :verify_authenticity_token
require './app/assets/ruby/Utilities'
$utilities = Utilities.new()
$metodo = []
$n = 0
$w = 0
#$a = [[7,-2,1], [-8,42,-15], [3,12,-30]]
#$b = [-2,3,70] 
#$x0 = [-100,0,10]
$a = []
$b = []
$x0 = []
$xs = []#x sustitución regresiva
  def gaussseidel
  end

  def richardson
  end

  def sor
  end
  
  def jacobi
  end
  
  def jac
    $metodo.clear
    $iteraciones = params[:iterations].to_f
    $delta = params[:delta].to_f
    $tol = params[:tol].to_f
    
    
    
    $b = $utilities.strToArray(params[:b])
    $n = $b.size
    $a = $utilities.strToMatrix(params[:A],$n)
    $x0 = $utilities.strToArray(params[:x0])
    jacobi2($a,$b,$x0)
    
    redirect_to "/methods/eqsystem/jacobi.html"
  end
  
  def ric
    $metodo.clear
    $iteraciones = params[:iterations].to_f
    $delta = params[:delta].to_f
    $tol = params[:tol].to_f
    
    
    
    $b = $utilities.strToArray(params[:b])
    $n = $b.size
    $a = $utilities.strToMatrix(params[:A],$n)
    $x0 = $utilities.strToArray(params[:x0])
    richardson2($a,$b,$x0)
    redirect_to "/methods/eqsystem/richardson.html"
  end
  
  def gas
    $metodo.clear
    $iteraciones = params[:iterations].to_f
    $delta = params[:delta].to_f
    $tol = params[:tol].to_f
    
    
    
    $b = $utilities.strToArray(params[:b])
    $n = $b.size
    $a = $utilities.strToMatrix(params[:A],$n)
    $x0 = $utilities.strToArray(params[:x0])
    gaussseidel2($a,$b,$x0)
    redirect_to "/methods/eqsystem/gaussseidel.html"
  end
  
  def sor3
    $metodo.clear
    $iteraciones = params[:iterations].to_f
    $delta = params[:delta].to_f
    $tol = params[:tol].to_f
    
    
    $w = params[:w].to_f
    $b = $utilities.strToArray(params[:b])
    $n = $b.size
    $a = $utilities.strToMatrix(params[:A],$n)
    $x0 = $utilities.strToArray(params[:x0])
    sor2($a,$b,$x0,$w)
    redirect_to "/methods/eqsystem/sor.html"
  end
  
  def txc(t,x0,c,a,b)
    cont = 0;
    puts "Iter. \t x \t \t \t fx  \t \t error"
    error = fx = 1000
    iteracion = []
    $metodo.clear
    while (cont <= $iteraciones && error > $tol && fx > $delta )
      if cont == 0
        error = "N/A"
      end
      cont += 1;
      ax = $utilities.multMatrices(a,x0)
      axb = $utilities.restMatrices(ax,b)
      axb = $utilities.strToArray(axb.to_s)
      fx = $utilities.magnitud(axb)
      #puts "#{cont} \t #{x0} \t \t \t #{fx} \t \t #{error}"
      x0 = $utilities.strToArray(x0.to_s)
      iteracion = [cont]
      x0.each do |e|
        iteracion.push(e)
      end
      iteracion.push(fx)
      iteracion.push(error)
      $metodo.push(iteracion)
      x = $utilities.strToArray(x0.to_s)
      
      tx = $utilities.multMatrices(t,x0)
      x0 = $utilities.sumMatrices(tx,c)
      xs = $utilities.strToArray(x0.to_s)
      
      error = $utilities.error(xs,x)
    end
  end
  
  def richardson2(a,b,x0)
    n = b.size
    d,l,u = $utilities.dlu(a)
    l,u = $utilities.cambiarSigno(l,u)
    i = $utilities.identidad(n)
    t = $utilities.sumMatrices(a,i)
    c = $utilities.multMatrices(b,-1)
    txc(t,x0,c,a,b)
  end
  
  def jacobi2(a,b,x0)
    d,l,u = $utilities.dlu(a)
    l,u = $utilities.cambiarSigno(l,u)
    d1 = $utilities.inversa(d)
    lu = $utilities.sumMatrices(l,u)
    t = $utilities.multMatrices(d1,lu)
    c = $utilities.multMatrices(d1,b)
    
    txc(t,x0,c,a,b)
  end
  
  def sor2(a,b,x0,w)
    d,l,u = $utilities.dlu(a)
    l,u = $utilities.cambiarSigno(l,u)
    wl = $utilities.multMatrices(w,l)
    dwl = $utilities.restMatrices(d,wl)
    dwl1 = $utilities.inversa(dwl)
    
    ow = 1-w
    owd = $utilities.multMatrices(ow,d)
    wu = $utilities.multMatrices(w,u)
    owdwu = $utilities.sumMatrices(owd,wu)
    t = $utilities.multMatrices(dwl1,owdwu)
    wdwl1 = $utilities.multMatrices(w,dwl1)
    c= $utilities.multMatrices(wdwl1,b)
    
    txc(t,x0,c,a,b)
  end
  
  def gaussseidel2(a,b,x0)
    sor2(a,b,x0,1)
  end
  
  def gausselimination
  end
  
  def gausselimination2
    $b = $utilities.strToArray(params[:b])
    $n = $b.size
    $a = $utilities.strToMatrix(params[:A],$n)
    $a2 =$a
    $b2 = $b
    $a, $b = $utilities.elim($a,$b)
    $xs = $utilities.sustitucionReg($a,$b)
    redirect_to "/methods/eqsystem/gausselimination.html"
  end
  
  def lu
  end
end