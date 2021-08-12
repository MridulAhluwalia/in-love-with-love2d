PlayState = Class{__includes = BaseState}


function PlayState:init()
    self.score = 0
    self.bird = Bird()
    self.pipePairs = {}
    self.pipeSpawnTimer = 0

    self.lastY = -PIPE_HEIGHT + math.random(80) + 20
end


function PlayState:update(dt)
    self.pipeSpawnTimer = self.pipeSpawnTimer + dt

    if self.pipeSpawnTimer > 2 then
        local y = math.max(-PIPE_HEIGHT + 10,
            math.min(self.lastY + math.random(-20, 20), VIRTUAL_HEIGHT - 90 - PIPE_HEIGHT))
        self.lastY = y

        table.insert(self.pipePairs, PipePair(y))
        self.pipeSpawnTimer = 0
    end

    for k, pair in pairs(self.pipePairs) do
        if not pair.scored then
            if pair.x + PIPE_WIDTH < self.bird.x then
                self.score = self.score + 1
                pair.scored = true
                gSounds['score']:play()
            end
        end

        pair:update(dt)
    end

    for k, pair in pairs(self.pipePairs) do
        if pair.remove then
            table.remove(self.pipePairs, k)
        end
    end

    for k, pair in pairs(self.pipePairs) do
        for l, pipe in pairs(pair.pipes) do
            if self.bird:collides(pipe) then
                gSounds['explosion']:play()
                gSounds['hurt']:play()

                gStateMachine:change('score', {
                    score = self.score
                })
            end
        end
    end

    self.bird:update(dt)

    if self.bird.y >= VIRTUAL_HEIGHT - 15 then
        gSounds['explosion']:play()
        gSounds['hurt']:play()

        gStateMachine:change('score', {
            score = self.score
        })
    end
end


function PlayState:render()

    self.bird:render()

    for k, pair in pairs(self.pipePairs) do
        pair:render()
    end

    love.graphics.setFont(gFonts['flappyMedium'])
    love.graphics.print('Score: ' .. tostring(self.score), 8, 8)
end
