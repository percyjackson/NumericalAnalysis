class Methods::EqsystemController < ApplicationController
  skip_before_filter :verify_authenticity_token
require './app/assets/ruby/Utilities'
$utilities = Utilities.new()
$iteraciones = 10
$metodo = []
$n = 0
$w = 0
#$a = [[7,-2,1], [-8,42,-15], [3,12,-30]]
#$b = [-2,3,70] 
#$x0 = [-100,0,10]
$a = []
$z = []
$b = []
$x0 = []
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
    error = "N/A"
    iteracion = []
    $metodo.clear
    while (cont < $iteraciones)
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
    
    $a, $b = $utilities.elim($a,$b)
    redirect_to "/methods/eqsystem/gausselimination.html"
  end
  
  def lu
  end
  def lu2
    $b = $utilities.strToArray(params[:b])
    $met = $utilities.strToArray(params[:met])
    $n = $b.size
    $a = $utilities.strToMatrix(params[:A],$n)
    
    n=$n
    a=$a
    b=$b
    z=[n]
    x=[n]
    l=Array.new(n,0) { Array.new(n,0) }
    u=Array.new(n,0) { Array.new(n,0) }
    if $met ==1
       
    
      s=0
      while s<n
        u[s][s]=1
        s=s+1
      end
      
      i=1
      while i<=n
        j=i
        while j<=n
          acum=0
          k=2
          while k<=i
            acum=acum+u[k-2][i-1]*l[j-1][k-2]/u[i-1][i-1]
            
            k=k+1
          end
          aux2=a[i-1][j-1]-acum/u[i-1][i-1]
          l[i-1][j-1]=aux2
          j=j+1
        end
        j=i
        while j<=n-1
          acum1=0
          k=2
          while k<=i
            acum1=acum1+u[k-2][j]*l[i-1][k-2]
            k=k+1
          end
          acum3 = (a[j][i-1] - acum1) / l[i-1][i-1]
          u[j][i-1]=acum3
          j=j+1
        end   
        i=i+1
      end
     
      
    else
       s=0
      while s<n
        l[s][s]=1
        s=s+1
      end
      
      i=1
      while i<=n
        j=i
        while j<=n
          acum=0
          k=2
          while k<=i
            acum=acum+u[k-2][j-1]*l[i-1][k-2]
            
            k=k+1
          end
          aux2=a[i-1][j-1]-acum/l[i-1][i-1]
          u[i-1][j-1]=aux2
          j=j+1
        end
        j=i
        while j<=n-1
          acum1=0
          k=2
          while k<=i
            acum1=acum1+l[j][k-2]*u[k-2][i-1]
            k=k+1
          end
          acum3 = (a[j][i-1] - acum1) / u[i-1][i-1]
          l[j][i-1]=acum3
          j=j+1
        end   
        i=i+1
      end
    end
    $z = $utilities.sustitucionProgresiva(l,$b,$n);
    $b = $utilities.sustitucionRegresiva(u,$z,$n);
    
    redirect_to "/methods/eqsystem/lu.html"
  end
  

end