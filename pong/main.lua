require 'src/Dependencies'


function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    math.randomseed(os.time())

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = true,
        resizable = true
    })

    gFonts = {
        ['small'] = love.graphics.newFont('fonts/pixel.ttf', 8),
        ['medium'] = love.graphics.newFont('fonts/pixel.ttf', 16),
        ['large'] = love.graphics.newFont('fonts/pixel.ttf', 32)
    }

    gSounds = {
        ['paddle_hit'] = love.audio.newSource('sounds/paddle_hit.wav', 'static'),
        ['score'] = love.audio.newSource('sounds/score.wav', 'static'),
        ['wall_hit'] = love.audio.newSource('sounds/wall_hit.wav', 'static')
    }

    gTexture = {
        ['universe'] = love.graphics.newImage('graphics/universe.png'),
        ['planets'] = love.graphics.newImage('graphics/planets.png'),
        ['ball'] = love.graphics.newImage('graphics/ball.png'),
        ['paddle_1'] = love.graphics.newImage('graphics/paddle_1.png'),
        ['paddle_2'] = love.graphics.newImage('graphics/paddle_2.png')
    }

    gStateMachine = StateMachine {
        ['start'] = function() return StartState() end,
        ['play'] = function() return PlayState() end,
        ['serve'] = function() return ServeState() end,
        ['done'] = function() return DoneState() end
    }
    gStateMachine:change('start')

    love.keyboard.keysPressed = {}
end


function love.update(dt)
    gStateMachine:update(dt)

    love.keyboard.keysPressed = {}
end


function love.draw()
    push:start()

    love.graphics.clear(0.2, 0.21, 0.3, 1)

    gStateMachine:render()

    displayFPS()

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
    love.graphics.setFont(gFonts['small'])
    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
end
