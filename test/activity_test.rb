require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/activity'

class ActivityTest < Minitest::Test
  def setup
    @activity = Activity.new("Spelunking", ({name: "Bob", paid: 5}))
  end

  def test_activity_exists
    assert_instance_of Activity, @activity
  end

  def test_an_activity_has_attributes
    participants = ({name: "Bob", paid: 5})

    assert_equal "Spelunking", @activity.name
    assert_equal [participants], @activity.participants
    assert_equal "Bob", @activity.participants[0][:name]
    assert_equal 5, @activity.participants[0][:paid]
  end

  def test_an_activity_can_add_participants
    @activity.add_participants({name: "Dan", paid: 7})

    assert_equal 2, @activity.participants.count
    assert_equal "Dan", @activity.participants[1][:name]
    assert_equal 7, @activity.participants[1][:paid]
  end

  def test_an_activity_can_calculate_total_cost
    @activity.add_participants({name: "Dan", paid: 7})

    assert_equal 12, @activity.calculate_total_cost
  end

  def test_an_activity_can_calculate_cost_per_person
    @activity.add_participants({name: "Dan", paid: 7})

    assert_equal 6, @activity.calculate_cost_per_person
  end

  def test_an_activity_can_calculate_amount_owed_per_participant
    @activity.add_participants({name: "Dan", paid: 7})
    payout = @activity.calculate_amount_owed_per_participant

    assert_equal 1, payout[0][:owed]
    assert_equal -1, payout[1][:owed]
  end

  def test_an_activity_can_add_calculate_for_more_than_two_participants
    @activity.add_participants({name: "Dan", paid: 7})
    @activity.add_participants({name: "Wolfgang Amadeus Mozart", paid: 13})
    payout = @activity.calculate_amount_owed_per_participant


    assert_equal 25, @activity.calculate_total_cost
    assert_equal 8.33, @activity.calculate_cost_per_person
    assert_equal 3.33, payout[0][:owed]
    assert_equal 1.33, payout[1][:owed]
    assert_equal -4.67, payout[2][:owed]
  end
end
