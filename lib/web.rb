require "rubygems"
require "sinatra"
require "uri"
require File.expand_path(File.join('..', 'stumble_score'), __FILE__)

get '/' do
  @address = params[:address]
  @err = nil
  if @address != nil
    begin
      @location = StumbleScore::Location.new @address
      @bar_addresses = @location.bar_addresses
    rescue
      @err = "Could not get location results"
    end
  end 

  erb :index
end


