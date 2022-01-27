# frozen_string_literal: true

require 'json'

def download_word_list
  system 'curl -o word_list.txt https://www.scrapmaker.com/data/wordlists/twelve-dicts/5desk.txt'
end

def create_word_list_array
  begin
    puts "Attempting to create word list now."
    word_list = File.readlines('word_list.txt', chomp: true).select { |word| word.length >= 5 && word.length <= 12}.map(&:downcase)
    puts "Word list created!"
    word_list
  rescue
    puts "File not found. Downloading file..."
    download_word_list
    puts "File downloaded!"
    create_word_list_array
  end
end

def convert_to_json(array)
  json_word_list = JSON.generate(array)
  puts "Word list converted to JSON!"
  json_word_list
end

json_file = File.new("word_list.json", "w")
json_file.puts(convert_to_json(create_word_list_array))
puts "JSON file created!"

File.delete("word_list.txt")