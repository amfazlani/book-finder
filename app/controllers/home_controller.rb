class HomeController < ApplicationController
  def index
    response = HTTParty.get("http://www.loc.gov/items?fo=json&fa=original-format:book&q=#{params[:q]}")

    @results = response['results'].map do |result|
      {
        loc_id: result['id'],
        image_url:  result['image_url'][0],
        title: result['title'],
        link_to_loc: result['url'],
        contributors: parse_contributers(result['item']) ,
        published_at: parse_published_at(result['item'])
      }
    end
  end

  private

  def parse_contributers(item)
    return "N/A" if item.nil? || item['contributors'].nil?
    
    item['contributors'].join(", ")
  end

  def parse_published_at(item)
    return "N/A" if item.nil? || item['created_published'].nil?

    item['created_published'].join(", ")
  end
end
