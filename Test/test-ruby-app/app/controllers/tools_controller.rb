class ToolsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  $functions = [] 
  def index
    @yeison = [5,3,2,1]
    #$functions.push("Exp(x)").push("sin(x)").push("cos(x)").push("tan(x)")
  end
  
  def add
    $functions.push(params[:fun])
    # params[:fun]
    redirect_to tools_index_path
  end
    
end
