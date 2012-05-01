require File.expand_path(File.join('..', 'test_helper'), __FILE__)

class TestStumbleWeb < Test::Unit::TestCase
  include LocationFixtures
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_page_displays_usage_instructions_when_no_address_specified
    get "/"
    assert last_response.ok?, "Request failed!"
    assert last_response.body.include?("Just add an address friend!"),
      "TODO display usage instructions on page when no address is specified. " \
      "(HINT: use the words \"address parameter\" to make this test pass."
  end

end

