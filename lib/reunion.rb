class Reunion
  attr_reader   :location,
                :activities

  def initialize(location, activity)
    @location = location
    @activities = [activity]
  end 
end
