class DustinBot < RTanque::Bot::Brain
  NAME = 'DUSTIN_BOT'
  include RTanque::Bot::BrainHelper

  def tick!
    if target = acquire_target
      shoot_at(target)
    else
      scan_for_targets
    end
  end

  def acquire_target
    # find the nearest bot to us according to the radar;
    # will return nil if there are no bots detected
    sensors.radar.min { |a,b| a.distance <=> b.distance }
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

  def scan_for_targets
    # Sweep the radar in a circle looking for new targets
    # Also turn the turret as we go so that we can see
    # where the tank is looking as it goes.
    self.command.radar_heading = self.sensors.radar_heading + MAX_RADAR_ROTATION
    self.command.turret_heading = self.sensors.heading + RTanque::Heading::HALF_ANGLE
  end
def hide_in_corners
  @corner_cycle ||= CORNERS.shuffle.cycle
  self.at_tick_interval(self.camp_interval) {
  self.corner = @corner_cycle.next
  self.reset_camp_interval
  }
  self.corner ||= @corner_cycle.next
  self.move_to_corner
  end
  def move_to_corner
  if self.corner
  command.heading = self.sensors.position.heading(RTanque::Point.new(*self.corner, self.arena))
  command.speed = MAX_BOT_SPEED
  end
  end
  def corner=(corner_name)
  @corner = case corner_name
  when :NE
  [self.arena.width, self.arena.height]
  when :SE
  [self.arena.width, 0]
  when :SW
  [0, 0]
  else
  [0, self.arena.height]
  end
  end
  def corner
  @corner
  end
  def camp_interval
  @camp_interval ||= self.reset_camp_interval
  end
  def reset_camp_interval
  @camp_interval = rand(SWITCH_CORNER_TICK_RANGE.max - SWITCH_CORNER_TICK_RANGE.min) + SWITCH_CORNER_TICK_RANGE.min
  end

end
