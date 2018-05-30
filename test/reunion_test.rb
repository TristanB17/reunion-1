require 'minitest'
require 'minitest/test'
require 'minitest/autorun'
require './lib/reunion'
require './lib/activity'
require 'pry'

class ReunionTest < Minitest::Test
  def setup
    @reunion = Reunion.new("Panama", Activity.new("Spelunking", ({name: "Bob", paid: 5})))

    @activity_2 = Activity.new("Bruncheon", ({name: "Wallace", paid: 9}))
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

  def test_a_reunion_can_add_activities
    @reunion.add_activity(@activity_2)

    assert_equal @activity_2, @reunion.activities[1]
    assert_equal "Bruncheon", @reunion.activities[1].name
  end

  def test_a_reunion_can_calculate_its_total_cost
    @reunion.activities[0].add_participants({name: "Sam", paid: 4})
    @activity_2.add_participants({name: "William", paid: 5})
    @reunion.add_activity(@activity_2)

    total_cost = @reunion.calculate_total_reunion_cost

    assert_equal 23, total_cost
  end

  def test_a_reunion_can_calculate_all_amounts_owed_per_person
    @reunion.activities[0].add_participants({name: "Sam", paid: 4})
    @activity_2.add_participants({name: "William", paid: 5})
    @reunion.add_activity(@activity_2)

    amounts_owed = @reunion.calculate_all_amounts_owed_per_participant

    assert_equal -0.5, @reunion.activities[0].participants[0][:owed]
    assert_equal 0.5, @reunion.activities[0].participants[1][:owed]
  end
end
