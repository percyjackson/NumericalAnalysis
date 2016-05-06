class ToolsController < ApplicationController
  require './app//assets/ruby/Utilities'
  require './app//assets/ruby/interval'
  skip_before_filter :verify_authenticity_token
  $interval = Interval.new(0,0)
  $functions = [] 
  $intervals = []
  #$funcion ="exp(3*x)-4*(x^2)+3-x^3+sin(x)"
  $funcion ="sin(x)"
  $funcion.downcase!
  puts $funcion
  $interA = 0
  $interB = 0
  $inc = 0
  $utilities = Utilities.new()
  def index
    @yeison = [5,3,2,1]
    
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
    $intervals.clear
    $interA = params[:a].to_f
    $interB = params[:b].to_f
    $inc = params[:i].to_f
    puts "a=#{$interA}, b=#{$interB}, i=#{$inc}"
    $funcion.downcase!
    nuevafun = $utilities.reemplazarX($funcion,$interA)
    actual = anterior = $utilities.evaluar(nuevafun)
    act = ant = $interA
    inicio = Time.now
    while ($interA <= $interB) do
      nuevafun = $utilities.reemplazarX($funcion,$interA)
      anterior = actual
      ant = act
      actual = $utilities.evaluar(nuevafun)
      act = $interA
      puts $interA
      if (anterior > 0.0 && actual < 0.0)
        puts "[#{ant}, #{act}]"
        interval = Interval.new(ant, act)
        $intervals.push(interval)
      elsif (anterior < 0.0 &&  actual > 0.0)
        puts "[#{ant}, #{act}]"
        interval = Interval.new(ant, act)
        $intervals.push(interval)
      end
      $interA = $interA + $inc
    end
    puts "Tiempo"
    puts Time.now-inicio
    puts $intervals
    puts $intervals.count
    $intervals.each {|inter| 
      puts "[#{inter.a}, #{inter.b}]"
    }
    #redirect_to tools_index_path
    redirect_to "/tools/index#fixed-tab-3"
  end
  
  def interval
    puts "HOla"
    puts params[:inter]
    $interval = $intervals[params[:inter].to_i]
    redirect_to tools_index_path
  end
end
