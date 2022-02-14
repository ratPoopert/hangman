require 'json'
require './lib/word_list.rb'
require './lib/save_manager.rb'

class Hangman
  attr_reader :word, :correct_guesses, :incorrect_guesses

  def initialize
    
    @correct_guesses = []
    @incorrect_guesses = []
    puts "Enter a number (0-9) to load a saved game. Otherwise, press enter to start a new game."
    response = gets.chomp
      if response.match?(/\A[0-9]\Z/)
        SaveManager.load_game(response, self)
      else
        @word = WordList.select_word
      end
    play_game
  end

  def display_correct_guesses
    display = []
    @word.split('').map do |char|
      if @correct_guesses.include?(char)
        display.push(char)
      else
        display.push('_')
      end
    end
    
    "Correct guesses: #{display.join(' ')}"
  end

  def display_incorrect_guesses
    "Incorrect guesses: #{@incorrect_guesses.join(', ')}"
  end
  
  def word_guessed?
    @word.chars.all? { |char| @correct_guesses.include?(char)}
  end

  def load_game(saved_game)
    @word = saved_game["word"]
    @correct_guesses = saved_game["correct_guesses"]
    @incorrect_guesses = saved_game["incorrect_guesses"]
  end

  def game_over?
    if word_guessed?
      puts "You won!"
      return true
    elsif @incorrect_guesses.length == 6
      puts "You lost!"
      return true
    else
      return false
    end
  end

  def play_again
    puts "Would you like to play again?"
    if gets.chomp.downcase == 'y'
      initialize
    else
      system 'exit'
    end
  end

  def play_game
    until game_over?
      system 'clear'
      puts display_correct_guesses
      puts display_incorrect_guesses
      puts "Guesses remaining: #{6 - @incorrect_guesses.length}."
      puts "Please enter a letter:"
      guess = gets.chomp.downcase

      if guess.match?(/\A[0-9]\Z/)
        SaveManager.save_game(guess, self)
        guess = gets.chomp.downcase
      end
      
      if @word.include?(guess)
        @correct_guesses.push(guess)
      else
        @incorrect_guesses.push(guess)
      end
    end
    play_again
  end
end



