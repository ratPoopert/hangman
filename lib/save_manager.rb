# frozen_string_literal: true

class SaveManager
  def self.filename(slot)
    "saved_games/hangman_#{slot}.json"
  end

  def self.save_game(slot, game)
    saved_game = {
      word: game.word,
      correct_guesses: game.correct_guesses,
      incorrect_guesses: game.incorrect_guesses
    }
    File.write filename(slot), JSON.dump(saved_game)
    puts "Game saved!"
  end

  def self.load_game(slot, game)
    begin
      saved_game = JSON.parse(File.read(filename(slot)))
      game.load_game(saved_game)
    rescue
      puts "I'm sorry, but there is no saved game with that number"
      game.initialize
    end
  end
end