LevelMaker = Class {}

function LevelMaker.createMap(level)
    local bricks = {}

    -- rows and columns
    local numRows = math.random(1, 5)
    local numCols = math.random(7, 13)
    if numCols % 2 == 0 then numCols = numCols + 1 end

    -- tier and color limits
    local highestTier  = math.min(3, math.floor(level / 5))
    local highestColor = math.min(5, (level % 5) + 3)

    for y = 1, numRows do
        -- row pattern flags
        local skipPattern          = math.random(2) == 1
        local alternatePattern     = math.random(2) == 1

        -- alternating setup
        local altColor1, altColor2 = math.random(highestColor), math.random(highestColor)
        local altTier1, altTier2   = math.random(0, highestTier), math.random(0, highestTier)
        local useAlt               = math.random(2) == 1

        -- solid setup
        local solidColor           = math.random(highestColor)
        local solidTier            = math.random(0, highestTier)

        -- skip toggle
        local skip                 = math.random(2) == 1

        for x = 1, numCols do
            -- handle skipping
            if skipPattern and skip then
                skip = not skip
            else
                skip = not skip

                local b = Brick(
                    (x - 1) * 32 + 8 + (13 - numCols) * 16, -- x
                    y * 16                                  -- y
                )

                if alternatePattern then
                    if useAlt then
                        b.color, b.tier = altColor1, altTier1
                    else
                        b.color, b.tier = altColor2, altTier2
                    end
                    useAlt = not useAlt
                else
                    b.color, b.tier = solidColor, solidTier
                end

                table.insert(bricks, b)
            end
        end
    end

    -- ensure we return at least 1 brick
    if #bricks == 0 then
        return LevelMaker.createMap(level)
    end
    return bricks
end
