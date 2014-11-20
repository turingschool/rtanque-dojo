class CircleBot < RTanque::Bot::Brain
  NAME = 'circle_bot'
  include RTanque::Bot::BrainHelper

  #This bot just drives in a circle and shoots fast

  def tick!
    circle_clockwise
    shoot
  end

  def circle_clockwise
    command.speed = MAX_BOT_SPEED
    command.heading = sensors.heading + 0.1
  end

  def shoot
    command.fire(MIN_FIRE_POWER)
  end
end
