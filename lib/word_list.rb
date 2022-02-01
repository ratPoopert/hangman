# frozen_string_literal: true

require 'json'
require './lib/dictionary.rb'

# Handles all tasks for generating word lists from dictionaries.
class WordList
  FILE_NAME = 'word_list.json'
  MIN_WORD_LENGTH = 5
  MAX_WORD_LENGTH = 12

  def self.import
    JSON.parse(File.read(FILE_NAME))
  rescue StandardError
    export
    JSON.parse(File.read(FILE_NAME))
  end

  def self.export
    File.write FILE_NAME, JSON.dump(Dictionary.import)
  end

  def self.filter
    import.select do |word|
      word.length.between?(MIN_WORD_LENGTH, MAX_WORD_LENGTH)
    end
  end

  def self.select_word
    filter.sample.downcase
  end

  private_class_method :import, :export, :filter
end
