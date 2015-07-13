# Create a deck with 52 cards. 4 suits of 13 cards each. 
# Deck = {1 => {"Suit" => "spades", "Card" => 1, "Points" => [1,11]}}
# Give count score to all cards. J Q K gets 10. A gets 1 or 11.
# Get player name (and bet amount?)
# Give 2 cards to player and count total
# Give 2 cards to computer (show one hide one?) and count total
# Player turns. Ask player to hit or stay
## If hit give one more card and count score
# If over 21, automatically bust
# Computer turn. Computer automatically gets cards if below 17
# Automatically busy over 21, else stay between 17 and 21
# Compare computer vs player to show who wins or tie
# (bet amount deducted if player lost, doubled if player won, 1.5 if player got blackjack and won)
# Play again

def create_deck
  # create 52 cards in a deck
  deck = {}
  (1..52).each do |card|
    deck[card] = ""
  end

  # create_suite & then create 13 cards inside suite
  # then match each card to 52 cards in deck created above
  i = 0 
  ["Spades","Hearts","Clubs","Diamonds"].each do |suite|
    (1..13).each do |num| 
      i += 1
      deck[i] = {"suite" => "#{suite}", "card" => "#{num}" }
    end
  end
  puts deck
end

pick_deck = create_deck

puts "Lets play blackjack!"
puts "What is your name?"
player = gets.chomp
total_amount = 100
puts " "
puts "Hello #{player}. You have Rs #{total_amount} that you can bet."

begin
  puts " "
  puts "How much would you like to bet?"
  puts "(Bet amount has to be more than 0 but less than or equal to #{total_amount})"
  bet_amount = gets.chomp.to_i
end until bet_amount <= total_amount && bet_amount > 0 

