StartState = Class{__includes = BaseState}


function StartState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('serve', {
        })
    end
end


function StartState:render()
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf(
        'Pong 1972',
        0,
        VIRTUAL_HEIGHT/2 - 32,
        VIRTUAL_WIDTH,
        'center'
    )

    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf(
        'Press Enter to Start Game',
        0,
        VIRTUAL_HEIGHT/1.5 - 32,
        VIRTUAL_WIDTH,
        'center'
    )
end
