require 'sinatra'
require 'sinatra/reloader'

number = rand(100)
guess = 0
output = ""
c = 0

get '/' do
  # throw params.inspect

  erb :index, :locals => {:number => number, :output => output}
  if c > 0
    output = feedback(params["guess"].to_i,number)
  end
  c += 1
  erb :index, :locals => {:number => number, :output => output}

  

end

def feedback(guess, number)
  if guess > number
    output = "Too high!"
  elsif guess < number
      output = "Too low!"
  else
      output = "You got it right!"
  end
end

  