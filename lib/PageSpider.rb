# created 2/13 by Heming Sun

require 'kimurai'

# crated 2/13 by Heming Sun
# Scrape the whole list of restaurant1
class PageSpider < Kimurai::Base

  @name = 'basic_scraper'
  @engine = :poltergeist_phantomjs
  @start_urls = ['https://dining.osu.edu/NetNutrition/1']

  #before start
  def self.open_spider
    logger.info "> Starting..."
  end
  #after closed, print message
  def self.close_spider
    logger.info "> Stopped..."
  end
  # Parse the page
  def parse(response, url:, data: {})

    #either make a list of restqurant names before searching or 
    #select restaurant names
    response.css('a').select{|table_row| table_row['class'] == 'cbo_nn_unitNameLink'}.each do |row|
      puts row.text

      # proceed through the link
      @browser.find('//a[@tabindex="0"]', text: '12th Avenue Bread Co.').trigger :click; sleep 1
      
      #get new reponse
      new_response = browser.current_response;

      # get food name and nutritions for each food item
      @browser.find_all(:xpath, "//td[@class='cbo_nn_itemHover']", wait: 1).each do |item| 

        puts "--------------"
        #print food name
        puts "  Food: #{item.text}"

        #index to count nutrition
        index = 0
        #click on food object
        item.trigger :click; sleep 1
        # test, careful because post request changes host states
        @browser.execute_script("getItemNutritionLabel(62980638)") ; sleep 2
        new_response = browser.current_response

        #loop through and print all 12th ave foods
        new_response.css('span').select{|food_item| food_item['class'] == 'cbo_nn_SecondaryNutrient'}.map do |food|
          puts "    Nutrition #{index}: #{food.text}"
          index += 1
        end

        
      end




    end
    
  end
  
end

#NickScrape.crawl!
PageSpider.parse! :parse, url:  'https://dining.osu.edu/NetNutrition/1'


