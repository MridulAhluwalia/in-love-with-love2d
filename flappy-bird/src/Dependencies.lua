-- a few global constants, centralized
require 'src/constants'

push = require 'lib/push'
Class = require 'lib/class'

require 'src/StateMachine'

-- states
require 'src/states/BaseState'
require 'src/states/CountdownState'
require 'src/states/PlayState'
require 'src/states/ScoreState'
require 'src/states/TitleScreenState'

-- objects
require 'src/objects/Bird'
require 'src/objects/Pipe'
require 'src/objects/PipePair'
