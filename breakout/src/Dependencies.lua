-- a few global constants, centralized
require 'src/constants'

push = require 'lib/push'
Class = require 'lib/class'

require 'src/Util'

require 'src/StateMachine'

-- states
require 'src/states/BaseState'
require 'src/states/StartState'
require 'src/states/PlayState'
require 'src/states/GameOverState'

-- objects
require 'src/objects/Paddle'
require 'src/objects/Ball'
require 'src/objects/Brick'

-- additional
require 'src/LevelMaker'
