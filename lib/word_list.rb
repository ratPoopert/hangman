# frozen_string_literal: true

require 'json'
require './lib/dictionary.rb'

# Handles all tasks for generating word lists from dictionaries.
class WordList
  FILE_NAME = 'word_list.json'
  MIN_WORD_LENGTH = 5
  MAX_WORD_LENGTH = 12

  # Parse the existing Word List JSON file, or create one if it
  # does not already exist.
  def self.import
    JSON.parse(File.read(FILE_NAME))
  rescue StandardError
    export
    JSON.parse(File.read(FILE_NAME))
  end

  # Create a new Word List JSON file by filtering a Dictionary
  # object.
  def self.export
    File.write FILE_NAME, JSON.dump(filter_dictionary)
  end

  # Filter the words in a dictionary by length Dictionary.
  def self.filter_dictionary(dictionary = Dictionary.import)
    dictionary.select do |word|
      word.length.between?(MIN_WORD_LENGTH, MAX_WORD_LENGTH)
    end
  end

  # Select a random word from an existing Word List.
  def self.select_word
    import.sample.downcase
  end

  private_class_method :import, :export, :filter_dictionary
end