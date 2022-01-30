require 'json'

def create_word_list
  begin
    word_list_file = File.open("word_list.json")
  rescue
    require './lib/word_list_builder.rb'
    word_list_file = File.open("word_list.json")
  end
  puts "Word list created!"
  JSON.parse(word_list_file.read)
end

def display_correct_guesses
  display = []
  WORD.split('').map do |char|
    if $correct_guesses.include?(char)
      display.push(char)
    else
      display.push('_')
    end
  end
   
  "Correct guesses: '#{display.join(' ')}.'"
end

def display_incorrect_guesses
  "Incorrect guesses: '#{$incorrect_guesses.join(', ')}.'"
end

def word_guessed?
  WORD.chars.all? { |char| $correct_guesses.include?(char)}
end

word_list = create_word_list
WORD = word_list.sample
puts "The word for this game is '#{WORD}'."

$correct_guesses = []

$incorrect_guesses = []

until word_guessed? || $incorrect_guesses.length == 6
  puts "Guesses remaining: #{6 - $incorrect_guesses.length}."
  puts "Please enter a letter:"
  guess = gets.chomp.downcase
  
  if WORD.include?(guess)
    $correct_guesses.push(guess)
  else
    $incorrect_guesses.push(guess)
  end
  
  puts display_correct_guesses
  puts display_incorrect_guesses
  p word_guessed?
end

