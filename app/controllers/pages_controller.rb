require 'rss/2.0'
require 'open-uri'

class PagesController < ApplicationController
  def home
    @news = "<h1>News and Updates</h1>"
    
    feed_url = "http://listenupapp.tumblr.com/rss"
    open (feed_url) do |http|
      response = http.read
      result = RSS::Parser.parse(response, false)
      result.channel.items.each do |item|
        @news += "<h2>#{item.title}</h2>#{item.description}<p>#{item.pubDate.to_date}</p>"
      end
    end
  end

  def help
  end

  def about
  end

  def contact
  end

end
