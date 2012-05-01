require File.expand_path(File.join('..', 'stumble_score'), __FILE__)

class CLI
  
  def self.run(address="")
    if address.length == 0
      return "Address is required.  usage stumblescore <address>"      
    end
    loc = StumbleScore::Location.new address
    loc.bar_addresses
    "Welcome to StumbleScore.\r\n"\
    "Looking for score near\r\n\t#{address}\r\n\r\n"\
    "Bar count: #{loc.bar_count}\r\n"\
    "StumbleScore: #{loc.score}\r\n"\
    "Classified as: #{loc.classification}"\
    "Bars: \r\n#{loc.bar_names.join("\r\n")}\r\n"
  end

end
