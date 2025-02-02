require "sinatra"
require "sinatra/reloader"
require "better_errors"
require "binding_of_caller"
  
# Need this configuration for better_errors
use(BetterErrors::Middleware)
BetterErrors.application_root = __dir__
BetterErrors::Middleware.allow_ip!('0.0.0.0/0.0.0.0')

get("/") do
  erb(:rule)
end

def get_computer_choice
  choices = ["rock", "paper", "scissors"]
  choices[rand(3)]
end

def determine_winner(player_choice, computer_choice)
  if player_choice == computer_choice
    "We tied!"
  elsif (player_choice == "rock" && computer_choice == "scissors") ||
        (player_choice == "paper" && computer_choice == "rock") ||
        (player_choice == "scissors" && computer_choice == "paper")
    "We win!"
  else
    "We lost!"
  end
end

get("/:choice") do
  player_choice = params[:choice]
  computer_choice = get_computer_choice
  @player = "We played #{player_choice}!"
  @computer = "They played #{computer_choice}!"
  @result = determine_winner(player_choice, computer_choice) 
  erb(:game_template)
end
