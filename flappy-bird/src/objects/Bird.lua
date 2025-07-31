Bird = Class {}


local GRAVITY = 20


function Bird:init()
    self.image = gGraphics['bird']

    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.x = VIRTUAL_WIDTH / 2 - self.width / 2
    self.y = VIRTUAL_HEIGHT / 2 - self.height / 2

    self.dy = 0
end

function Bird:update(dt)
    self.dy = self.dy + GRAVITY * dt

    if love.keyboard.wasPressed('space') then
        self.dy = -5
        gSounds['jump']:play()
    end

    self.y = self.y + self.dy
end

function Bird:render()
    love.graphics.draw(self.image, self.x, self.y)
end

function Bird:collides(pipe)
    if (self.x + self.width - 2) >= pipe.x and self.x <= (pipe.x + 2 + PIPE_WIDTH) then
        if (self.y + self.height - 2) >= pipe.y and self.y <= (pipe.y + 2 + PIPE_HEIGHT) then
            return true
        end
    end

    return false
end
