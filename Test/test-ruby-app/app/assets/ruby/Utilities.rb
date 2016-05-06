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

  
end