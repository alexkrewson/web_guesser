require 'sinatra'
require 'sinatra/reloader'

cheat_flag = 0


class Feedback
  
  attr_accessor :rando, :this_counter
  
  def initialize 
    @@counter = 5
    @rando = rand(100)
    @this_counter = @@counter
  end
  
  def feedback(guess,number)
    
    if @@counter > 0
      if guess > number * 2
        output = "Way too high!"
        # output = "guess: #{@@counter}"
      elsif guess < number / 2
        output = "Way too low!"
        # output = "guess: #{@@counter}"
      elsif guess > number
        output = "Too high!"
        # output = "guess: #{@@counter}"
      elsif guess < number
        output = "Too low!"
        # output = "guess: #{@@counter}"
      else
        output = "You got it right!"
        # output = "you're cheating!"
      end
    else
      output = "GAME OVER (generating new number)"
    end
    @@counter = @@counter - 1
    @this_counter = @@counter
    output
    # if @@counter == 0
    #   output = "GAME OVER"
    # end
    
  end
  
  def feedback_color(guess,number)
    if guess > number * 2 || guess < number / 2
      output = "red"
      # output = "guess: #{guess}"
    elsif guess == number
      output = "green"
      # output = "guess: #{guess}"
    else
      output = "rgb(239, 164, 164)"
      # output = "guess: #{guess}"
    end
  end
end


feedback_color = "white"
c = 0
output = ""
something = Feedback.new
number = something.rando 

get '/' do
  
  if something.this_counter < 5 && something.this_counter > 1
    output = something.feedback(params["guess"].to_i,number)
    feedback_color = something.feedback_color(params["guess"].to_i,number)
  elsif something.this_counter == 5
    something.this_counter = 4
    output = "Please guess!"
    feedback_color = "white"

  elsif something.this_counter == 1
    something = Feedback.new
    number = something.rando
    output = "GAME OVER (regenerating secret number)"
    feedback_color = "white"
  end

  if params["cheat"] != "true"
    # output = "You're cheating!"
    shown_number = ""
  elsif params["cheat"] == "true"
    shown_number = number
  end

  erb :index, :locals => {:shown_number => shown_number, :output => output, :feedback_color => feedback_color, :cheat_flag => cheat_flag}

end