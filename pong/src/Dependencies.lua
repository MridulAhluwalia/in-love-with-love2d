-- a few global constants, centralized
require 'src/constants'

push = require 'lib/push'
Class = require 'lib/class'

require 'src/StateMachine'

-- game states
require 'src/states/BaseState'
require 'src/states/StartState'
require 'src/states/PlayState'
require 'src/states/ServeState'
require 'src/states/DoneState'

-- game objects
require 'src/objects/Ball'
require 'src/objects/Paddle'
