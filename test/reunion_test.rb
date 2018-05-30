require 'minitest'
require 'minitest/test'
require 'minitest/autorun'
require './lib/reunion'
require './lib/activity'

class ReunionTest < Minitest::Test
  def setup
    @reunion = Reunion.new("Panama", Activity.new("Spelunking", ({name: "Bob", paid: 5})))
  end

  def test_reunion_exists
    assert_instance_of Reunion, @reunion
  end

  def test_a_reunion_has_attributes
    assert_equal "Panama", @reunion.location
    assert_equal "Spelunking", @reunion.activities[0].name
    assert_equal "Bob", @reunion.activities[0].participants[0][:name]
    assert_equal 5, @reunion.activities[0].participants[0][:paid]
  end
end
