class DeathToAll < RTanque::Bot::Brain
  NAME = 'DEATH_TO_ALL'
  include RTanque::Bot::BrainHelper

  def tick!
    if target = acquire_target
      shoot_at(target)
    else
      scan_for_targets
    end

    command.speed = rand(1..5)

    # command.speed = MAX_BOT_SPEED
    ## main logic goes here

    # use self.sensors to detect things
    # See http://rubydoc.info/github/awilliams/RTanque/master/RTanque/Bot/Sensors

    # use self.command to control tank
    # See http://rubydoc.info/github/awilliams/RTanque/master/RTanque/Bot/Command

    # self.arena contains the dimensions of the arena
    # See http://rubydoc.info/github/awilliams/RTanque/master/frames/RTanque/Arena
  end

  def acquire_target
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
    self.command.fire(MIN_FIRE_POWER)
  end
end
