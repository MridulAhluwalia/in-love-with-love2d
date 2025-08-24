StartState = Class { __includes = BaseState }


function StartState:enter(params)

end

function StartState:init()
    -- whether we're highlighting "Start" or "High Scores"
    self.highlighted = 1
end

function StartState:update(dt)
    -- toggle highlighted option if we press an arrow key up or down
    if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('down') then
        self.highlighted = self.highlighted == 1 and 2 or 1
        gSounds['paddle-hit']:play()
    end

    -- confirm whichever option we have selected to change screens
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gSounds['confirm']:play()

        if self.highlighted == 1 then
            gStateMachine:change('paddle-select', {})
        else
            gStateMachine:change('high-scores', {
                highScores = loadHighScores()
            })
        end
    end

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function StartState:render()
    -- title
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf("BREAKOUT", 0, VIRTUAL_HEIGHT / 3, VIRTUAL_WIDTH, 'center')

    -- options
    if self.highlighted == 1 then
        love.graphics.setColor(103 / 255, 1, 1, 1)
    end

    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf("START", 0, (VIRTUAL_HEIGHT / 2) + 70, VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(1, 1, 1, 1)

    if self.highlighted == 2 then
        love.graphics.setColor(103 / 255, 1, 1, 1)
    end

    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf("HIGHSCORE", 0, (VIRTUAL_HEIGHT / 2) + 90, VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(1, 1, 1, 1)
end
