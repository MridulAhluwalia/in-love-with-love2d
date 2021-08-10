require 'src/Dependencies'


function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    math.randomseed(os.time())

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = false
    })

    gFonts = {
        ['small'] = love.graphics.newFont('fonts/pixel.ttf', 8),
        ['medium'] = love.graphics.newFont('fonts/pixel.ttf', 16),
        ['large'] = love.graphics.newFont('fonts/pixel.ttf', 32)
    }
end


function love.update(dt)
    love.keyboard.keysPressed = {}
end


function love.draw()
    push:start()

    displayFPS()

    push:finish()
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
