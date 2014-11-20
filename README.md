#Welcome to the Dojo

Rtanque Battle Dojo, that is! Rtanque is a fun and simple tank simulator
built in ruby. Let's try our hand at some basic AI programming against
the built-in tank bots.

### Installation:

Clone this repo and run bundle!

### Generating a new tank:

```
# this will generate a new file at bots/my_bot.rb
# which will have the basic Rtanque#tick infrastructure
# in place
rtanque new_bot my_bot
```


### Running a simulation

```
rtanque start list_of bot_files to_use
```

so to run a simulation using the new `my_bot` which we just made:

```
rtanque start bots/my_bot
```

There are also some included sample bots which are a good way
to test the mettle of your bot. Sample bots are `keyboard` (drive this
one manually with the keyboard), `camper` (this bot just sits in the
center and shoots) and `seek_and_destroy` (this bot is pretty durn
fearsome. it will hunt you down).

To run a game with just the sample bots:

```
rtanque start sample_bots/keyboard sample_bots/camper sample_bots/seek_and_destroy
```

Also note that you can use wild cards when starting a simluation, so the
following command will run a game using all of the bots inside the
`bots` directory in this repo:

```
rtanque start bots/*
```


### Components of an Rtanque bot

##### Sensors

Sensors provide information about the tank's current status. For example
its heading, turret heading, speed, etc.

The full list of sensor attributes is:

```
:ticks
:health
:speed
:position
:heading
:radar
:radar_heading
:turret_heading
:gun_energy
```

##### Command

The bot's `command` is the interface for telling it what to do. Most of
these attributes are treated as `attr_accessors`, so to tell the bot to
go to a new speed, you would just assign it:

```
class WoraceBot < RTanque::Bot::Brain
  NAME = 'worace_bot'
  include RTanque::Bot::BrainHelper

  def tick!
    command.speed = MAX_BOT_SPEED #values between -5 and 5
  end
end
```

Command also has the `#fire` method, which accepts a `power` param,
telling your bot how hard to shoot.

```
class WoraceBot < RTanque::Bot::Brain
  NAME = 'worace_bot'
  include RTanque::Bot::BrainHelper

  def tick!
    command.fire(3)
  end
end
```

There are lots of other things you can do with a bot. The best way to
learn about them is to browse the sample bots in this repo and in the
rtanque repo at
https://github.com/awilliams/RTanque/tree/master/sample_bots.

### Joining the party

To submit your own bot to the fray, fork this repository, add your bot
under `bots/<your_bot_name>.rb` and commit. Then make a pull request to
this repo. Once we've collected all the bots, we will run a few
simulations and see who comes out on top.

