# NickScrape.rb
# Nick Kurtz's attempt at/version of a basic web scraper to get acquainted with using the given gems and web scraping in general
# dependencies and commands to get them:
# gem install kimurai
# sudo apt-get install phantomjs
# created 2/10 by Nick Kurtz

require 'kimurai'


# created 2/10 by Nick Kurtz - initialize and scrape_site functions outlined
# edited 2/11 by Nick Kurtz - scrape_site method fleshed out more
# 2/11 - complete overhaul to the kimurai gem, which seems to package as many web-scraping gems as possible into one. This swap was done so we can look at js-gnerated content, which apparently Nokogiri and Mechanize cannot do.
class NickScrape < Kimurai::Base

  @name = 'basic_scraper'
  @engine = :poltergeist_phantomjs
  @start_urls = ['https://dining.osu.edu/NetNutrition/1']

  # created 2/11 by Nick Kurtz as a required method for the Kimurai gem Base
  # edited 2/12 by Nick Kurtz to access JavaScript-generated html pages and touch the information
  def parse(response, url:, data: {})

    #select restaurant names
    response.css('a').select{|table_row| table_row['class'] == 'cbo_nn_unitNameLink'}.each do |row|

      puts row.text
      
    end

    #click the 12th ave link to reach its food and wait for response
    browser.find('//a[@tabindex="0"]', text: '12th Avenue Bread Co.').trigger :click; sleep 1

    new_response = browser.current_response;

    #loop through and print all 12th ave foods
    new_response.css('td').select{|food_item| food_item['class'] == 'cbo_nn_itemHover'}.map do |food|

      puts food.text
      
    end
    
  end
  
end

#NickScrape.crawl!
NickScrape.parse! :parse, url:  'https://dining.osu.edu/NetNutrition/1'


