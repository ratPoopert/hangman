# frozen_string_literal: true

# Handles all tasks relating to 'dictionary' files used for generating word lists.
class Dictionary
  URL = 'https://www.scrapmaker.com/data/wordlists/twelve-dicts/5desk.txt'
  FILE_NAME = 'dictionary.txt'

  def self.download
    puts 'Dictionary file not found. Downloading file...'
    system "curl -o #{FILE_NAME} #{URL}"
    puts 'Dictionary file downloaded!'
  end

  def self.read
    dictionary = File.readlines(FILE_NAME, chomp: true)
    File.delete(FILE_NAME)
    dictionary
  end

  def self.import
    read
  rescue StandardError
    download
    read
  end

  private_class_method :download, :read
end
