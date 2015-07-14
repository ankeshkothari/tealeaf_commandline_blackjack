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

def hit(user,user_points,from_deck,from_cards_left)
  # get new card
  new_card = from_cards_left.sample

  # remove new card from cards left var outside method
  cards_left = from_cards_left.delete(new_card)

  # show player which card he got
  puts "#{user} got #{from_deck[new_card].values_at("number")[0].to_i} of #{from_deck[new_card].values_at("suite")[0].to_s}"

  # count new card points
  # Find if new card is ace, 2-9, j q k
  new_card_number = from_deck[new_card].values_at("number")[0].to_i
  if new_card_number == 1
    new_points = 1
  elsif new_card_number > 1 && new_card_number < 10
    new_points = new_card_number
  else
    new_points = 10
  end 

  # add new card points to existing user points
  user_points = user_points + new_points

  # show player's points
  puts "#{user} has #{user_points} points"
  puts " "

  # return value and exit
  user_points
end

def check_bust(points,player_name)
  if points > 21
    puts "#{player_name} is busted!"
    puts " "
    return "yes"
  end
end

def computer_hit_decide(p_bust,c_bust,p_points,c_points)
  if p_bust == "yes"
    return "no"
  elsif c_bust == "yes"
    return "no"
  elsif c_points > p_points
    return "no"
  elsif c_points > 17
    return "no"     
  end
end

# Create deck. Initially cards_left == complete deck
deck = create_deck
cards_left = deck.keys

puts "Lets play blackjack!"
puts "What is your name?"
player_name = gets.chomp

puts " "
total_amount = 100.00

#loop for play again
begin

  puts "#{player_name}: You have Rs #{total_amount} that you can bet."

  begin
    puts " "
    puts "How much would you like to bet?"
    puts "(Bet amount has to be more than 0 but less than or equal to #{total_amount})"
    bet_amount = gets.chomp.to_f
  end until bet_amount <= total_amount && bet_amount > 0 

  puts "#{player_name} has bet Rs #{bet_amount}"
  puts " "

  player_points = 0
  computer_points = 0

  # start game
  # player's first hit
  player_points = hit(player_name,player_points,deck,cards_left)

  # computers first hit
  computer_points = hit("Computer",computer_points,deck,cards_left)

  # player's second hit
  player_points = hit(player_name,player_points,deck,cards_left)

  puts "Computer's second card is hidden"
  puts " "

  # ask player to hit or stay until they bust or stay
  player_bust = ""
  begin
    puts "Enter S to Stay or H to Hit a new card"
    player_command = gets.chomp.capitalize
    break if player_command == "S"
    
    # hit a new card for player
    player_points = hit(player_name,player_points,deck,cards_left)

    # check if new card busted the player or not
    player_bust = check_bust(player_points,player_name)
  end until player_command == "S" || player_bust == "yes"

  puts " "

  # computer hits or stays or busts
  computer_hit = ""
  computer_bust = ""
  begin
    computer_hit = computer_hit_decide(player_bust,computer_bust,player_points,computer_points)
    break if computer_hit == "no"

    # hit a new card for computer
    computer_points = hit("Computer",computer_points,deck,cards_left)

    # check if new card busted the computer or not
    computer_bust = check_bust(computer_points,"Computer")  
  end until computer_hit == "no" || computer_bust == "yes"

  puts " "

  # Decide who wins and show message
  if player_bust == "yes"
    puts "#{player_name} lost :("
    player_game = "lost"
  elsif computer_bust == "yes"
    puts "#{player_name} won :)"
    player_game = "won"
  elsif player_points == computer_points
    puts "Its a tie!"
    player_game = "tie"
  elsif player_points > computer_points && player_points == 21
    puts "#{player_name} won with a BLACKJACK!"
    player_game = "blackjack"
  elsif player_points > computer_points
    puts "#{player_name} won :)"
    player_game = "won"
  elsif computer_points > player_points
    puts "#{player_name} lost :("
    player_game = "lost"
  end

  # Calculate player's total amount
  if player_game == "lost"
    puts "#{player_name} lost Rs #{bet_amount}"
    total_amount = total_amount - bet_amount
  elsif player_game == "won"
    puts "#{player_name} earns Rs #{bet_amount}"
    total_amount = total_amount + bet_amount
  elsif player_game == "tie"
    total_amount = total_amount + bet_amount
  elsif player_game == "blackjack"
    blackjack_amount = bet_amount*1.5
    puts "#{player_name} earns Rs #{blackjack_amount}"
    total_amount = total_amount + blackjack_amount
  end

  puts " "
  puts "Press P if you want to play again. Press any other key to exit."
  play_again = gets.chomp.capitalize

end while play_again == "P" 

puts "Thank you #{player_name} for playing. You are leaving the table with Rs #{total_amount}."
