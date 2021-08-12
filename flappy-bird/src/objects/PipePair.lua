PipePair = Class{}


local GAP_HEIGHT = 90


function PipePair:init(y)
    self.x = VIRTUAL_WIDTH + 32
    self.y = y

    self.scored = false
    self.remove = false

    self.pipes = {
        ['upper'] = Pipe('top', self.x, self.y),
        ['lower'] = Pipe('bottom', self.x, self.y + GAP_HEIGHT + PIPE_HEIGHT)
    }
end


function PipePair:update(dt)
    if self.x > -PIPE_WIDTH then
        self.x = self.x + -GROUND_SCROLL_SPEED * dt
        self.pipes['lower'].x = self.x
        self.pipes['upper'].x = self.x
    else
        self.remove = true
    end
end


function PipePair:render()
    for k, pipe in pairs(self.pipes) do
        pipe:render()
    end
end
