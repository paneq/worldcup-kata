require "minitest/autorun"

class FootballTime
  include Comparable
  attr_reader :minute, :half, :extra_time

  def initialize(options = {})
    @minute     = options.fetch(:minute)
    @half       = options.fetch(:half)
    @extra_time = options.fetch(:extra_time)
  end

  def <=>(another)
    # implement it :)
  end
end

module Test
  extend MiniTest::Assertions

  def self.expect(a, msg)
    assert(a, msg)
  end

  def self.assert_equals(a,b,msg=nil)
    assert_equal(a,b,msg)
  end
end


class FootbalTimeTest < MiniTest::Unit::TestCase
  def test_everything
    Test.expect(FootballTime, "FootballTime class must be defined")

    Test.expect(
      FootballTime.new(minute: 12, half: 1, extra_time: true),
      "FootballTime can be created with number and match period description"
    )

    Test.assert_equals(
      FootballTime.new(minute: 12, half: 1, extra_time: false),
      FootballTime.new(minute: 12, half: 1, extra_time: false),
      "instance with the same minute, half and extra_time should be equal to other instance with same values"
    )

    Test.assert_equals(
      FootballTime.new(minute: 106, half: 2, extra_time: true),
      FootballTime.new(minute: 106, half: 2, extra_time: true),
      "instance with the same minute, half and extra_time should be equal to other instance with same values"
    )

    Test.expect(
      FootballTime.new(minute: 1, half: 1, extra_time: false) < FootballTime.new(minute: 2, half: 1, extra_time: false),
      "1st minute of first half is lower than 2nd minute of 1st half"
    )

    Test.expect(
      FootballTime.new(minute: 2, half: 1, extra_time: false) > FootballTime.new(minute: 1, half: 1, extra_time: false),
      "2nd minute of first half is greater than 1st minute of 1st half"
    )

    Test.expect(
      FootballTime.new(minute: 60, half: 2, extra_time: false) > FootballTime.new(minute: 30, half: 1, extra_time: false),
      "60th minute of match (2nd half) is greater than 30th minute (1st half)"
    )

    Test.expect(
      FootballTime.new(minute: 46, half: 2, extra_time: false) > FootballTime.new(minute: 47, half: 1, extra_time: false),
      "46th minute of match (2nd half) is greater than 47th minute of 1st half with additional time"
    )

    Test.expect(
       FootballTime.new(minute: 92, half: 2, extra_time: false) < FootballTime.new(minute: 91, half: 1, extra_time: true),
      "92nd minute of match (second half) is lower than 91st first minute of first half of extra time"
    )

    Test.expect(
       FootballTime.new(minute: 107, half: 1, extra_time: true) < FootballTime.new(minute: 106, half: 2, extra_time: true),
      "107th minute of match (first half of extra time) is lower than 106th minute of second half of extra time"
    )
  end
end
