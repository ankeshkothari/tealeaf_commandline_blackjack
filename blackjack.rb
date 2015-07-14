# Create a deck with 52 cards. 4 suits of 13 cards each. /
# Deck = {1 => {"Suit" => "spades", "Card" => 1, "Points" => [1,11]}} / 
# Give count score to all cards. J Q K gets 10. A gets 1 or 11.
# Get player name (and bet amount?) /
# Give 2 cards to player and count total /
# Give 2 cards to computer (show one hide one?) and count total /
# Player turns. Ask player to hit or stay /
## If hit give one more card and count score /
# If over 21, automatically bust
# Computer turn. Computer automatically gets cards if below 17
# Automatically busy over 21, else stay between 17 and 21
# Compare computer vs player to show who wins or tie
# (bet amount deducted if player lost, doubled if player won, 1.5 if player got blackjack and won)
# Play again

require 'pry'

def create_deck
  # create 52 cards in a deck
  deck = {}
  (1..52).each do |card|
    deck[card] = ""
  end

  # create 4 suites & then create 13 cards inside each suite
  # then inside match each card to 52 cards in deck created above
  i = 0 
  ["Spades","Hearts","Clubs","Diamonds"].each do |suite|
    (1..13).each do |num| 
      i += 1
      deck[i] = {"suite" => "#{suite}", "number" => "#{num}" }
    end
  end
  deck
end

deck = create_deck
cards_left = deck.keys

def get_card(cards_left)
  current_card = cards_left.sample
  cards_left.delete(current_card)
  current_card
end

def card_describe(deck,card)
  card_num = deck[card].values_at("number")[0].to_i
  card_suite = deck[card].values_at("suite")[0].to_s
  return "#{card_num} of #{card_suite}"
end

def calculate_points(deck,card) 
  card_number = deck[card].values_at("number")[0].to_i
  if card_number == 1
    points = 1
  elsif card_number > 1 && card_number < 10
    points = card_number
  else
    points = 10
  end 
end

def check_bust(points,player_name)
  if points > 21
    puts "#{player_name} is busted!"
    return "yes"
  end
end


# def new_card(player_or_computer,cards_left,deck,player_points_in,computer_points_in,player_name)
#   puts " "
#   card = get_card(cards_left)
#   card_number_with_suite = card_describe(deck,card)
#   card_points = calculate_points(deck,card)
#   if player_or_computer == "player"
#     player_points_in = player_points_in + card_points
#     puts "#{player_name} got #{card_number_with_suite}"
#     puts "#{player_name} has #{player_points_in} points"
#     player_points_in
#   elsif player_or_computer == "computer"
#     computer_points_in = computer_points_in + card_points
#     puts "Computer got #{card_number_with_suite}"
#     puts "Computer has #{computer_points_in} points"
#     computer_points_in
#   end    
# end

puts "Lets play blackjack!"
puts "What is your name?"
player_name = gets.chomp
total_amount = 100.00

puts " "
puts "#{player_name}: You have Rs #{total_amount} that you can bet."

begin
  puts " "
  puts "How much would you like to bet?"
  puts "(Bet amount has to be more than 0 but less than or equal to #{total_amount})"
  bet_amount = gets.chomp.to_f
end until bet_amount <= total_amount && bet_amount > 0 

puts "#{player_name} has bet #{bet_amount}"

player_points = 0
computer_points = 0
player = "player"
computer = "computer"

# Start game
# Player gets first card
puts " "
card = get_card(cards_left)
card_number_with_suite = card_describe(deck,card)
card_points = calculate_points(deck,card)
player_points = player_points + card_points
puts "#{player_name} got #{card_number_with_suite}"
puts "#{player_name} has #{player_points} points"

#new_card(computer,cards_left,deck,player_points,computer_points,player_name)
# Computer gets first card
puts " "
card = get_card(cards_left)
card_number_with_suite = card_describe(deck,card)
card_points = calculate_points(deck,card)
computer_points = computer_points + card_points
puts "Computer got #{card_number_with_suite}"
puts "Computer has #{computer_points} points"

# Player gets second card
puts " "
card = get_card(cards_left)
card_number_with_suite = card_describe(deck,card)
card_points = calculate_points(deck,card)
player_points = player_points + card_points
puts "#{player_name} got #{card_number_with_suite}"
puts "#{player_name} has #{player_points} points"

puts " "
puts "Computer's second card is hidden"

begin
  puts "Enter S to Stay or H to Hit a new card"
  player_command = gets.chomp.capitalize
  break if player_command == "S"
  puts " "
  card = get_card(cards_left)
  card_number_with_suite = card_describe(deck,card)
  card_points = calculate_points(deck,card)
  player_points = player_points + card_points
  puts "#{player_name} got #{card_number_with_suite}"
  puts "#{player_name} has #{player_points} points"
  player_bust = check_bust(player_points,player_name)
end until player_command == "S" || player_bust == "yes"





# number of aces count will be needed. Count 1 for each ace. Add 10 if points < 12 && at least one ace

# puts " "
# card = get_card(cards_left)
# card_with_suite = card_describe(deck,card)
# card_points = calculate_points(deck,card)
# computer_points = computer_points + card_points
# puts "Computer got #{card_with_suite}"
# puts "Computer has #{computer_points} points"

# puts " "
# card = get_card(cards_left)
# card_number_with_suite = card_describe(deck,card)
# card_points = calculate_points(deck,card)
# player_points = player_points + card_points
# puts "#{player}: Your card is #{card_with_suite}"
# puts "You have #{player_points} points"

# cards_left = deck.keys
# puts cards_left
# current_card = cards_left.sample
# puts current_card
# cards_left.delete(current_card)
# puts cards_left

# cards left = deck.keys minus card selected by deck.keys.sample