require 'rss/2.0'
require 'open-uri'

class PagesController < ApplicationController
  def home
    @title = "Home"
  end

  def help
    @title = "Help"
  end

  def about
    @title = "About"
  end

  def contact
    @title = "Contact"
  end

end
