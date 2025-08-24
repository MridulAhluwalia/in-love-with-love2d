-- a few global constants, centralized
require 'src/constants'

push = require 'lib/push'
Class = require 'lib/class'

require 'src/Util'

require 'src/StateMachine'

require 'src/states/BaseState'

require 'src/LevelMaker'


-- states
require 'src/states/EnterHighScoreState'
require 'src/states/GameOverState'
require 'src/states/HighScoreState'
require 'src/states/SelectPaddleState'
require 'src/states/PlayState'
require 'src/states/ServeState'
require 'src/states/StartState'
require 'src/states/VictoryState'

-- objects
require 'src/objects/Paddle'
require 'src/objects/Brick'
require 'src/objects/Ball'
