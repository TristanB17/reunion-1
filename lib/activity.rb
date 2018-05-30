class Activity
  attr_reader   :name,
                :participants

  def initialize(name, participants)
    @name = name
    @participants = [participants]
  end

  def add_participants(participant)
    @participants << participant
  end

  def calculate_total_cost
    @participants.map do |participant|
      participant[:paid]
    end.sum
  end

  def calculate_cost_per_person
    (calculate_total_cost.to_f / @participants.count.to_f).round(2)
  end

end
