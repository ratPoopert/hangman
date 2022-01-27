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

word_list = create_word_list