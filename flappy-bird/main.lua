require 'src/Dependencies'


local backgroundScroll = 0
local groundScroll = 0

local BACKGROUND_SCROLL_SPEED = 30
GROUND_SCROLL_SPEED = 60

local BACKGROUND_LOOPING_POINT = 413

scrolling = true


function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    math.randomseed(os.time())

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = true,
        resizable = false
    })

    gFonts = {
        ['normalFont'] = love.graphics.newFont('fonts/font.ttf', 8),
        ['flappySmall'] = love.graphics.newFont('fonts/flappy.ttf', 14),
        ['flappyMedium'] = love.graphics.newFont('fonts/flappy.ttf', 28),
        ['flappyLarge'] = love.graphics.newFont('fonts/flappy.ttf', 56)
    }

    gSounds = {
        ['jump'] = love.audio.newSource('sounds/jump.wav', 'static'),
        ['explosion'] = love.audio.newSource('sounds/explosion.wav', 'static'),
        ['hurt'] = love.audio.newSource('sounds/hurt.wav', 'static'),
        ['score'] = love.audio.newSource('sounds/score.wav', 'static'),
        ['music'] = love.audio.newSource('sounds/marios_way.mp3', 'static')
    }

    gGraphics = {
        ['background'] = love.graphics.newImage('graphics/background.png'),
        ['ground'] = love.graphics.newImage('graphics/ground.png'),
        ['bird'] = love.graphics.newImage('graphics/bird.png'),
        ['pipe'] = love.graphics.newImage('graphics/pipe.png'),
    }

    gStateMachine = StateMachine {
        ['title'] = function() return TitleScreenState() end,
        ['countdown'] = function() return CountdownState() end,
        ['play'] = function() return PlayState() end,
        ['score'] = function() return ScoreState() end
    }
    gStateMachine:change('title')

    -- set initial font
    love.graphics.setFont(gFonts['flappyMedium'])

    -- kick off music
    gSounds['music']:setLooping(true)
    gSounds['music']:play()

    -- initialize input table
    love.keyboard.keysPressed = {}
end

function love.update(dt)
    -- adding a pause feature
    if love.keyboard.wasPressed('p') then
        scrolling = not scrolling
    end

    if scrolling then
        backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt) % BACKGROUND_LOOPING_POINT
        groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt) % VIRTUAL_WIDTH
        gStateMachine:update(dt)
    end

    love.keyboard.keysPressed = {}
end

function love.draw()
    push:start()

    love.graphics.draw(gGraphics['background'], -backgroundScroll, 0)
    gStateMachine:render()
    love.graphics.draw(gGraphics['ground'], -groundScroll, VIRTUAL_HEIGHT - 16)

    -- displayFPS()

    push:finish()
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end

    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function displayFPS()
    love.graphics.setFont(gFonts['normalFont'])
    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
end
