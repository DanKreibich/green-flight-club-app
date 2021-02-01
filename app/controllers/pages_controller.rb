class PagesController < ApplicationController
  def home
    # in order to display the right navbar on the homepage
    @navbar_dark = true
  end
end
