require 'net/http'
class Utilities
  
  def evaluar(fun)
    uri = URI('http://api.mathjs.org/v1/')
    parametros = { :expr => fun, :precision => 15 }
    uri.query = URI.encode_www_form(parametros)
    res = Net::HTTP.get_response(uri)
    #puts res.body
    return res.body.to_f
  end
  
  def reemplazarX(funcion,value)
    #puts "funcion: #{$funcion}"
    func = funcion
    func = func.gsub("(x)","(#{value})")
    
    func = func.gsub("0x","0*(#{value})")
    func = func.gsub("1x","1*(#{value})")
    func = func.gsub("2x","2*(#{value})")
    func = func.gsub("3x","3*(#{value})")
    func = func.gsub("4x","4*(#{value})")
    func = func.gsub("5x","5*(#{value})")
    func = func.gsub("6x","6*(#{value})")
    func = func.gsub("7x","7*(#{value})")
    func = func.gsub("8x","8*(#{value})")
    func = func.gsub("9x","9*(#{value})")
    
    func = func.gsub("x^","(#{value})^")
    func = func.gsub("-x","-(#{value})")
    func = func.gsub("+x","+(#{value})")
    func = func.gsub("*x","*(#{value})")
    func = func.gsub("x-","(#{value})-")
    func = func.gsub("x+","(#{value})+")
    func = func.gsub("x*","(#{value})*")
    #puts "despues: #{func}"
    return func
  end
  
  def inversa(a)
    uri = URI('http://api.mathjs.org/v1/')
    matriz = "inv(#{a})"
    parametros = { :expr => matriz}
    uri.query = URI.encode_www_form(parametros)
    res = Net::HTTP.get_response(uri)
    #puts res.body
    return res.body
  end
  
  def identidad(a)
    uri = URI('http://api.mathjs.org/v1/')
    matriz = "eye(#{a})"
    parametros = { :expr => matriz}
    uri.query = URI.encode_www_form(parametros)
    res = Net::HTTP.get_response(uri)
    #puts res.body
    return res.body
  end
  
  def sumMatrices(a,b)
    uri = URI('http://api.mathjs.org/v1/')
    matriz = "add(#{a},#{b})"
    parametros = { :expr => matriz}
    uri.query = URI.encode_www_form(parametros)
    res = Net::HTTP.get_response(uri)
    #puts res.body
    return res.body
  end
  
  def multMatrices(a,b)
    uri = URI('http://api.mathjs.org/v1/')
    matriz = "multiply(#{a},#{b})"
    parametros = { :expr => matriz}
    uri.query = URI.encode_www_form(parametros)
    res = Net::HTTP.get_response(uri)
    #puts res.body
    return res.body
  end
  
  def restMatrices(a,b)
    uri = URI('http://api.mathjs.org/v1/')
    matriz = "subtract(#{a},#{b})"
    parametros = { :expr => matriz}
    uri.query = URI.encode_www_form(parametros)
    res = Net::HTTP.get_response(uri)
    #puts res.body
    return res.body
  end
  
  def dlu(a)
    tam = a.size
    d = []
    l = []
    u = []
    a.each do |e|
      d << e.clone
      l << e.clone
      u << e.clone
    end
    i=0
    while i<tam
      j=0
      while j<tam
        if j>i
          l[i][j] = d[i][j] = 0
        elsif j<i
          u[i][j] = d[i][j] = 0
        else
          l[i][j] = u[i][j] = 0
        end
        j=j+1
      end
      i=i+1
    end
    
    return d,l,u
  end
  
  def cambiarSigno(l,u)
    tam = l.size
    l = l
    u = u
    i=0
    while i<tam
      j=0
      while j<tam
        
        l[i][j] *= -1
        u[i][j] *= -1
        j=j+1
      end
      i=i+1
    end
    return l,u
  end
  
  def error(a,b)
    n = a.size
    r = 0.to_f
    cont =  0
    while cont < n
      r += ((a[cont].to_f)-(b[cont].to_f))**2
      cont += 1
    end
    return Math.sqrt(r)
  end
  
  def magnitud(a)
    n = a.size
    r = 0.to_f
    cont =  0
    while cont < n
      r += (a[cont].to_f)**2
      cont += 1
    end
    return Math.sqrt(r)
  end
  
  def strToArray(a)
    x = a.to_s
    x = x.gsub("[","")
    x = x.gsub("]","")
    x = x.split(",").map { |s| s.to_f }
    return x
  end
  
  def strToMatrix(x,n)
    x = x.gsub("[","")
    x = x.gsub("]","")
    x = x.split(",").map { |s| s.to_f }
    i = 0
    cont = 0
    a = Array.new(n)
    while i < n
      j = 0
      b = Array.new(n)
      while j < n
        b[j]=(x[cont])
        cont += 1
        j+=1
      end
      a[i]=b
      i+=1
    end
    return a
  end
  
  def signos(str)
    str.gsub("--","+")
  end
  
  def sustitucionProgresiva(l,b,n)
    z=Array.new(n,0)
    m=Array.new(n) { Array.new(n+1) }
   
    s=1
    while s<=n
      j=1
      while j<=s
        tmp=l[s-1][j-1]
        m[s-1][j-1]= tmp
        j=j+1
      end
      s=s+1
    end
    i=1
    while i<=n
      tmp2= b[i-1]
      m[i-1][n]=tmp2
      i=i+1
    end
    i=1
    while i<=n
       acum1=0
       j=1
       while j<=i
         acum1=acum1+z[j-1]*m[i-1][j-1]
         j=j+1
       end
       tmp3 = b[i-1] - acum1 
       z[i-1]=tmp3/ m[i-1][i-1]
       i=i+1
    end
    return z
  end
  
  def sustitucionRegresiva(u,z,n)
    x=Array.new(n,0)
    m=Array.new(n) { Array.new(n+1) }
   
    s=1
    while s<=n
      j=1
      while j<=n
        tmp=u[s-1][j-1]
        m[s-1][j-1]= tmp
        j=j+1
      end
      s=s+1
    end
    i=1
    while i<=n
      tmp2= z[i-1]
      m[i-1][n]=tmp2
      i=i+1
    end
    i=n
    while i>=1
       acum1=0
       j=i
       while j<=n-1
         acum1=acum1+x[j]*m[i-1][j]
         j=j+1
       end
       tmp3 = m[i-1][n] - acum1 
       x[i-1]=tmp3/ m[i-1][i-1]
       i=i-1
    end
    return x
  end
  
  def elim(a,b)
    n = b.size
    i = 0
    while i < (n-1)
      j = i + 1
      while j   < n 
        #puts a[j][i]
        #puts a[i][i]
        numerador = a[j][i].to_f
        denominador = a[i][i].to_f
        div = (numerador/denominador)*(-1)
        r1 = b[i]
        r2 = b[j]
        mul = div * r1
        sum = mul + r2
        b[j] = sum
        #puts "r1 = #{b[i]}"
        #puts "r2 = #{b[j]}"
        k = i
        while k < n
          #puts a[j][k] #r2
          #puts a[i][k] #r1
          r1 = a[i][k] #r1
          r2 = a[j][k] #r2
          mul = div * r1
          sum = mul + r2
          a[j][k] = sum
          k += 1
        end
        j += 1
      end
      i += 1
    end
    return a,b
  end
end