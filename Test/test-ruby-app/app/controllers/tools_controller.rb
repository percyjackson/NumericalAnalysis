class ToolsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  $functions = [] 
  $funcion ="exp(3*x)-4*(x^2)+3-x^3+sin(x)"
  $funcion.downcase!
  puts $funcion
  $a=-100
  $b=100
  $i=1
  def index
    @yeison = [5,3,2,1]
    #$functions.push("Exp(x)").push("sin(x)").push("cos(x)").push("tan(x)")
    uri = URI('http://api.mathjs.org/v1/')
    parametros = { :expr => "sin(34)", :precision => 5 }
    uri.query = URI.encode_www_form(parametros)
    res = Net::HTTP.get_response(uri)
    puts res.body
  end
  
  def add
    $functions.push(params[:fun])
    # params[:fun]
    redirect_to tools_index_path
  end
  
  def funct
    @function = params[:options]
    redirect_to tools_index_path
  end
  
  def incremental
    $funcion.downcase!
    nuevafun = $funcion
    nuevafun = reemplazarX(nuevafun)
  end
  
  def reemplazarX(fun)
    
  end
  
    
end
