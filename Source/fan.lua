local gfx = playdate.graphics
local slib = gfx.sprite

class('Fan').extends(slib)

local LAST_FRAME = 6
local WIND_INTERVAL = 20
local windTimeOffset = WIND_INTERVAL
local TOP_OFFSET = 18
local BOTTOM_OFFSET = 18
local LEFT_OFFSET = 14
local RIGHT_OFFSET = 400
local RANDOM_WIND_OFFSET = 8

local function getAnimationTable(direction)
    if direction == DIRECTION.LEFT then
        return gfx.imagetable.new('img/fan/fan_animation_left')
    elseif direction == DIRECTION.RIGHT then
        return gfx.imagetable.new('img/fan/fan_animation_right')
    end
end

function Fan:init(x, y, direction)
    Fan.super.init(self)
    self.position = {x = x, y = y}
    self:moveTo(x, y)
    self.direction = direction
    self.animationTable = getAnimationTable(direction)
    self.animationFrame = 1
    local leftBorder = LEFT_OFFSET
    local rightBorder = RIGHT_OFFSET
    if direction == DIRECTION.LEFT then
        leftBorder = leftBorder * -1
        rightBorder = rightBorder * -1
    end
    self.windPath = {top = y - TOP_OFFSET,
                     bottom = y + BOTTOM_OFFSET,
                     left = x + LEFT_OFFSET,
                     right = x + RIGHT_OFFSET
                    }
    self.spinning = false
    self:add()
end

function Fan:incrementAnimationFrame(increment)
    self.animationFrame = self.animationFrame + increment
    if self.animationFrame > LAST_FRAME then
        self.animationFrame = 1
    elseif self.animationFrame < 1 then
        self.animationFrame = LAST_FRAME
    end
end

function Fan:makeWind()
    local reversed = false
    local yOffset = math.random(-RANDOM_WIND_OFFSET, RANDOM_WIND_OFFSET)
    if Ticks < 0 then
        reversed = true
    end
    Wind(self.position.x, self.position.y + yOffset, self.direction, reversed)
end

function Fan:update()
    self:setImage(self.animationTable:getImage(self.animationFrame))
    if Ticks ~= 0 then
        self.spinning = true
        if windTimeOffset > WIND_INTERVAL then
            self:makeWind()
            windTimeOffset = 0
        end
        windTimeOffset = windTimeOffset + 1
        self:incrementAnimationFrame(Ticks)
    else
        self.spinning = false
    end
end