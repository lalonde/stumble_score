require "rubygems"
require "sinatra"
require "uri"
require File.expand_path(File.join('..', 'stumble_score'), __FILE__)

get '/' do
  @address = params[:address]
    
  if @address != nil
    @location = StumbleScore::Location.new @address
    @bar_addresses = @location.bar_addresses
  end 

  erb :index
end


