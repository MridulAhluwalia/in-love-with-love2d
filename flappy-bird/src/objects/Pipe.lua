Pipe = Class{}


PIPE_HEIGHT = 288
PIPE_WIDTH = 70


function Pipe:init(orientation, x, y)
    self.image = gGraphics['pipe']

    self.x = x
    self.y = y

    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.orientation = orientation
end


function Pipe:render()
    love.graphics.draw(self.image, self.x,
    (self.orientation == 'top' and self.y + self.height or self.y),
    0, 1, self.orientation == 'top' and -1 or 1)
end
