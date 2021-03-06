require File.expand_path(File.join('..', 'test_helper'), __FILE__)

class TestCLI < Test::Unit::TestCase
  include LocationFixtures

  def test_cli_displays_number_of_bars_near_specified_address
    output = CLI.run(CHESTNUT_HILL)
    assert output.include?("Bar count: #{CHESTNUT_HILL_BAR_COUNT}"),
      "TODO display number of bars in CLI for specified address."

    output = CLI.run(PAOLI)
    assert output.include?("Bar count: #{PAOLI_BAR_COUNT}"),
      "That's odd. The specified number of bars works for one address but not another."

    output = CLI.run(RITTENHOUSE)
    assert output.include?("Bar count: #{RITTENHOUSE_BAR_COUNT}"),
      "That's odd. The specified number of bars works in two addresses but not a third."
  end

end

class TestLocation < Test::Unit::TestCase
  include LocationFixtures

  def test_bar_count_finds_number_of_bars_near_specified_address
    location = StumbleScore::Location.new(CHESTNUT_HILL)
    assert_equal CHESTNUT_HILL_BAR_COUNT, location.bar_count

    location = StumbleScore::Location.new(PAOLI)
    assert_equal PAOLI_BAR_COUNT, location.bar_count

    location = StumbleScore::Location.new(RITTENHOUSE)
    assert_equal RITTENHOUSE_BAR_COUNT, location.bar_count
  end

end
