# gui for scraper

# require "shoes"
require_relative "./Agent"



class Window < Shoes
    url '/', :index
    url '/results', :results

    def index
        stack do
            title "enter a url and the pattern"
            @new_url = edit_line
            button "OK" do 
                visit "/results"
            end
        end


    end

    def results
        stack do
            para "not found"
        end

    end


end

Shoes.app