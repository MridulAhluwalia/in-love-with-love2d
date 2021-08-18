PlayState = Class{__includes = BaseState}


function PlayState:init()
    self.paddle = Paddle()
    self.ball = Ball(1)

    self.ball.dx = math.random(-250, 250)
    self.ball.dy = math.random(-70, -90)

    self.bricks = LevelMaker.createMap()
end


function PlayState:update(dt)
    self.paddle:update(dt)
    self.ball:update(dt)

    if self.ball.y >= VIRTUAL_HEIGHT then
        gSounds['hurt']:play()
        gStateMachine:change('game-over')
    end

    if self.ball:collides(self.paddle) then
        self.ball.dy = -self.ball.dy
        gSounds['paddle-hit']:play()
    end

    for k, brick in pairs(self.bricks) do
        if brick.inPlay and self.ball:collides(brick) then
            brick:hit()
        end
    end
end


function PlayState:render()
    for k, brick in pairs(self.bricks) do
        brick:render()
    end

    self.paddle:render()
    self.ball:render()
end
