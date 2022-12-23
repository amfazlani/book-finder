class HomeController < ApplicationController
  def index
    response = HTTParty.get("http://www.loc.gov/items?fo=json&fa=original-format:book")

    @results = response['results'].map do |result|
      { 
        loc_id: result['id'],
        image_url:  result['image_url'][0],
        title: result['title'],
        link_to_loc: result['url'],
        resources: result['resources']
      }
    end
    
  end
end