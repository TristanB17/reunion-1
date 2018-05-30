class Reunion
  attr_reader   :location,
                :activities

  def initialize(location, activity)
    @location = location
    @activities = [activity]
  end

  def add_activity(activity)
    @activities << activity
  end

  def calculate_total_reunion_cost
    @activities.map do |activity|
      activity.calculate_total_cost
    end.sum
  end

  def calculate_all_amounts_owed_per_participant
    @activities.each do |activity|
      activity.calculate_amount_owed_per_participant
    end
  end

  def all_amounts_owed_printout
    good = []
    @activities.each do |activity|
      good << activity.participants
    end
    isolate(good.flatten)
  end

  def isolate(persons)
    printout = []
    persons.map do |person|
      printout << "#{person[:name]} owes #{person[:owed]} dollars"
    end
    printout.join("\n")
  end
end
