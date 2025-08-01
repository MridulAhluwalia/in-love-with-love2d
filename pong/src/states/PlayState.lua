PlayState = Class { __includes = BaseState }


function PlayState:update(dt)
    ball:update(dt)

    -- ball collision with player 1
    if ball:collides(player1) then
        ball.dx = -ball.dx * 1.03
        ball.x = player1.x + 5 -- offset to avoid collision issues paddle width

        -- keep velocity going in the same direction, but randomize it
        if ball.dy < 0 then
            ball.dy = -math.random(10, 150)
        else
            ball.dy = math.random(10, 150)
        end

        gSounds['paddle_hit']:play()
    end

    -- ball collision with player 2
    if ball:collides(player2) then
        ball.dx = -ball.dx * 1.03
        ball.x = player2.x - 4 -- offset to avoid collision issues ball width

        -- keep velocity going in the same direction, but randomize it
        if ball.dy < 0 then
            ball.dy = -math.random(10, 150)
        else
            ball.dy = math.random(10, 150)
        end

        gSounds['paddle_hit']:play()
    end

    -- ball collides with upper wall
    if ball.y <= 0 then
        ball.y = 0
        ball.dy = -ball.dy

        gSounds['wall_hit']:play()
    end

    -- ball collides with lower wall
    if ball.y >= VIRTUAL_HEIGHT - 4 then
        ball.y = VIRTUAL_HEIGHT - 4
        ball.dy = -ball.dy

        gSounds['wall_hit']:play()
    end

    -- win point player 2
    if ball.x < 0 then
        gSounds['score']:play()

        servingPlayer = 1
        player2Score = player2Score + 1

        if player2Score == WIN_POINT_LIMIT then
            winningPlayer = 2
            gStateMachine:change('done')
        else
            gStateMachine:change('serve', {
                player1Score = player1Score,
                player2Score = player2Score,
                servingPlayer = servingPlayer
            })
        end
    end

    -- win point player 1
    if ball.x > VIRTUAL_WIDTH then
        gSounds['score']:play()

        servingPlayer = 2
        player1Score = player1Score + 1

        if player1Score == WIN_POINT_LIMIT then
            winningPlayer = 1
            gStateMachine:change('done')
        else
            gStateMachine:change('serve', {
                player1Score = player1Score,
                player2Score = player2Score,
                servingPlayer = servingPlayer
            })
        end
    end

    -- player 1 movement
    if love.keyboard.isDown('w') then
        player1.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('s') then
        player1.dy = PADDLE_SPEED
    else
        player1.dy = 0
    end

    -- player 2 movement
    if love.keyboard.isDown('up') then
        player2.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('down') then
        player2.dy = PADDLE_SPEED
    else
        player2.dy = 0
    end

    player1:update(dt)
    player2:update(dt)
end

function PlayState:render()
    -- display score
    displayScore()

    -- render ball
    ball:render()

    -- render player 1 paddle
    player1:render()
    player2:render()
end
