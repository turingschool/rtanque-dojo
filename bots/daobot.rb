class DaoBot < RTanque::Bot::Brain
  NAME = 'dao_bot'
  include RTanque::Bot::BrainHelper

  #This bot makes use of the rtanque radar to find
  #targets and aim at them

  def tick!
    if target = acquire_target
      shoot_at(target)
    else
      scan_for_targets
    end

    circle_clockwise
  end

  def circle_clockwise
    command.speed = MAX_BOT_SPEED
    direction = [1,2,3,4,5,6].sample
    command.heading = sensors.heading - 3 if direction < 3
    command.heading = sensors.heading + 3 if direction >= 3
  end



  def acquire_target
    # find the nearest bot to us according to the radar;
    # will return nil if there are no bots detected
    sensors.radar.min { |a,b| a.distance <=> b.distance }
  end

  def scan_for_targets
    # Sweep the radar in a circle looking for new targets
    # Also turn the turret as we go so that we can see
    # where the tank is looking as it goes.
    self.command.radar_heading = self.sensors.radar_heading + MAX_RADAR_ROTATION
    self.command.turret_heading = self.sensors.heading + RTanque::Heading::HALF_ANGLE
  end

  def shoot_at(target)
    # Turn our turret toward the desired target
    # And let 'er rip
    # Change the lower the fire power to shoot more frequent
    # but weaker shots.
    self.command.radar_heading = target.heading
    self.command.turret_heading = target.heading
    self.command.fire(MAX_FIRE_POWER)
  end
end
