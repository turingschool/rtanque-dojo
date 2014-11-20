class TurretSpinnerBot < RTanque::Bot::Brain
  NAME = 'turret_spinner_bot'
  include RTanque::Bot::BrainHelper

  #This bot sits still in the center of the map
  #and shoots its turret periodically in a circle.

  def tick!
    rotate_turret
    shoot
  end

  def rotate_turret
    command.turret_heading = sensors.turret_heading + 0.05
  end

  def shoot
    command.fire(MAX_FIRE_POWER)
  end
end
