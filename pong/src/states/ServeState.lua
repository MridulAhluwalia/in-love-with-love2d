ServeState = Class{__includes = BaseState}


function ServeState:init()
    winningPlayer = 0

    -- player paddle initial position
    player1 = Paddle(10, 30, 5, 20)
    player2 = Paddle(VIRTUAL_WIDTH - 15, VIRTUAL_HEIGHT - 50, 5, 20)

    -- ball initialization
    ball = Ball(VIRTUAL_WIDTH/2 - 2, VIRTUAL_HEIGHT/2 - 2, 4, 4)
end


function ServeState:enter(params)
    player1Score = params.player1Score or 0
    player2Score = params.player2Score or 0
    servingPlayer = params.servingPlayer or math.random(2)
end


function ServeState:update(dt)
    ball.dy = math.random(-50, 50)
    if servingPlayer == 1 then
        ball.dx = 180
    else
        ball.dx = -180
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('play')
    end
end


function ServeState:render()
    -- display score
    displayScore()
    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf(
        'Player ' .. tostring(servingPlayer) .. "'s serve!",
        0, VIRTUAL_HEIGHT/2, VIRTUAL_WIDTH, 'center')

    -- render ball
    ball:render()

    -- render player 1 paddle
    player1:render()
    player2:render()
end


function displayScore()
    -- score display
    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf('Player 1', 0,
        VIRTUAL_HEIGHT/12,
        VIRTUAL_WIDTH/3 + 45,
        'right'
    )
    love.graphics.printf('Player 2', 0,
        VIRTUAL_HEIGHT/12,
        3 * VIRTUAL_WIDTH/4 - 10,
        'right'
    )
    love.graphics.setFont(gFonts['large'])
    love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH/2 - 70,
        VIRTUAL_HEIGHT/6
    )
    love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH/2 + 50,
        VIRTUAL_HEIGHT/6
    )
end
