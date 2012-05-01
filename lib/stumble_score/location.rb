require "rubygems"
require "net/https"
require "uri"
require "json"

module StumbleScore

  class Location
    GOOGLE_KEY    = "AIzaSyDZ3HukggTQAWV6LTT_d4bqtZmj-DIekyE"
    RADIUS        = 2000 # (meters)
    CRITERIA      = URI.escape("bar|pub")
    MAGIC_NUMBER  = 20

    def initialize(address)
      @address=address
      @bars=bars
      @bar_addresses=bar_addresses
    end

    def bar_count
      @bars.count
    end

    def score
      self.bar_count * 5.0
    end

    def classification
      case bar_count
      when 0..5
        return "Dry"        
      when 6..10
        return "Tipsy"
      else
        return "Sloppy"
      end
    end

    def bar_names
      names = Array.new
      @bars.each do |b|
        names.push b["name"]
      end
      names
    end

    def bar_addresses
      bar_addr = {}
      @bars.each do |b|
        bar_addr[b["name"]] = b["vicinity"]
      end
      bar_addr
    end

    def bars
      uri = URI::HTTPS.build({
        :host  => "maps.googleapis.com",
        :path  => "/maps/api/place/search/json",
        :query => "location=#{self.geocode}&" \
                  "radius=#{RADIUS}&" \
                  "keyword=#{CRITERIA}&" \
                  "sensor=false&" \
                  "key=#{GOOGLE_KEY}"
      })
      parsed = self.ask_the_google(uri)
      parsed["results"]
    end

    def geocode
      raise "@address instance variable not set!" unless @address
      escaped_address = URI.escape(@address)
      uri = URI::HTTPS.build({
        :host  => "maps.googleapis.com",
        :path  => "/maps/api/geocode/json",
        :query => "address=#{escaped_address}&" \
                  "sensor=false"
      })
      parsed   = self.ask_the_google(uri)
      location = parsed["results"][0]["geometry"]["location"]
      "#{location["lat"]},#{location["lng"]}"
    end

    def ask_the_google(uri)
      session              = Net::HTTP.new(uri.host, uri.port)
      session.use_ssl      = true
      session.verify_mode  = OpenSSL::SSL::VERIFY_NONE
      request              = Net::HTTP::Get.new(uri.request_uri)
      response             = session.request(request)
      json                 = response.body
      JSON.parse(json)
    end

  end

end
