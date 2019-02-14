# Agent.rb
# Simple web scrape agent that reads url and patterns from url_file and print fetched information out
# urls and patterns should be put in URL_FILE, 
# each url takes one line followed by css patterns and split by '~'

# Created by Heming Sun 02/08/19

require 'nokogiri'
require 'open-uri'

# class Agent read url and patterns from url_file and can print them out 
# created by Heming Sun 02/08/19
# edited 2/10 by Nick Kurtz to ensure a relative file path
class Agent
    $URL_FILE = "#{File.dirname(__FILE__)}./lib/urls/trial_url"

    # constructor
    # created by Heming Sun 02/08/19
    def initialize
        @url_list = {}
        @path_list = []
        #read url_list
        File.readlines($URL_FILE).each do |line|
            lines = line.split('~')
            path_list = lines.slice(1, lines.length)
            puts path_list.class
            @url_list[lines[0]] = path_list
            
        end
        
    end
    # scrape method scrape urls stored in url_list using patterns
    # created by Heming Sun 02/08/19
    def scrape
        @url_list.each {|key, value| 
            puts "Parsing: #{key}";
            puts value
            Nokogiri::HTML(open(key.strip)).css(*value).each do |link|
                puts link.content
            end
        }
    end
end

Agent.new.scrape
