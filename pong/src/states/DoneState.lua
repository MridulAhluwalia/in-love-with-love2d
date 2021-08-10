DoneState = Class{__includes = BaseState}


function DoneState:update(dt)
    -- decide serving player as the opposite of who won
    if winningPlayer == 1 then
        servingPlayer = 2
    else
        servingPlayer = 1
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('serve', {
        })
    end
end


function DoneState:render()
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf(
        'Pong 1972',
        0,
        VIRTUAL_HEIGHT/3 - 32,
        VIRTUAL_WIDTH,
        'center'
    )

    love.graphics.printf(
        'Player ' .. tostring(winningPlayer) .. ' wins!',
        0,
        VIRTUAL_HEIGHT/2 - 32,
        VIRTUAL_WIDTH,
        'center'
    )

    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf(
        'Press Enter to Play Again!',
        0,
        3 * VIRTUAL_HEIGHT/4,
        VIRTUAL_WIDTH,
        'center'
    )
end
