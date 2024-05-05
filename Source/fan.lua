local gfx = playdate.graphics
local slib = gfx.sprite

class('Fan').extends(slib)

local LAST_FRAME = 6
local WIND_INTERVAL = 20
local TOP_OFFSET = 18
local BOTTOM_OFFSET = 18
local LEFT_OFFSET = 14
local RIGHT_OFFSET = 150
local RANDOM_WIND_OFFSET = 8

local function getAnimationTable(direction)
    if direction == DIRECTION.LEFT then
        return gfx.imagetable.new('img/fan/fan_animation_left')
    elseif direction == DIRECTION.RIGHT then
        return gfx.imagetable.new('img/fan/fan_animation_right')
    elseif direction == DIRECTION.UP then
        return gfx.imagetable.new('img/fan/fan_animation_up')
    elseif direction == DIRECTION.DOWN then
        return gfx.imagetable.new('img/fan/fan_animation_down')
    end
end

local function getWindPath(x, y, direction)
    local leftBorder = LEFT_OFFSET
    local rightBorder = RIGHT_OFFSET
    local topBorder = TOP_OFFSET
    local bottomBorder = BOTTOM_OFFSET
    if direction == DIRECTION.LEFT or direction == DIRECTION.DOWN then
        leftBorder = leftBorder * -1
        rightBorder = rightBorder * -1
    end
    if direction == DIRECTION.RIGHT then
        return {
            top = y - topBorder,
            bottom = y + bottomBorder,
            left = x + leftBorder,
            right = x + rightBorder
           }
    elseif direction == DIRECTION.LEFT then
        return {
            top = y - topBorder,
            bottom = y + bottomBorder,
            left = x + rightBorder,
            right = x + leftBorder
            }
    elseif direction == DIRECTION.UP then
        return {
                top = y - rightBorder,
                bottom = y + leftBorder,
                left = x - topBorder,
                right = x + bottomBorder
            }
    end
    return {
        top = y - rightBorder,
        bottom = y + leftBorder,
        left = x - topBorder,
        right = x + bottomBorder
    }
end

function Fan:init(x, y, direction, selected)
    Fan.super.init(self)
    self.selected = selected
    self.position = {x = x, y = y}
    self:moveTo(x, y)
    self.direction = direction
    self.animationTable = getAnimationTable(direction)
    self.animationFrame = 1
    self.windPath = getWindPath(x, y, direction)
    self.spinning = false
    self.windTimeOffset = WIND_INTERVAL
    self:setImage(self.animationTable:getImage(self.animationFrame))
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
    local yOffset = 0
    local xOffSet = 0
    if self.direction == DIRECTION.LEFT or self.direction == DIRECTION.DOWN then
        yOffset = math.random(-RANDOM_WIND_OFFSET, RANDOM_WIND_OFFSET)
    else
        xOffSet = math.random(-RANDOM_WIND_OFFSET, RANDOM_WIND_OFFSET)
    end
    if Ticks < 0 then
        reversed = true
    end
    Wind(self.position.x + xOffSet, self.position.y + yOffset, self.direction, reversed)
end

function Fan:update()
    if self.selected then
        self:setImage(self.animationTable:getImage(self.animationFrame))
        if Ticks ~= 0 then
            self.spinning = true
            if self.windTimeOffset > WIND_INTERVAL then
                self:makeWind()
                self.windTimeOffset = 0
            end
            self.windTimeOffset = self.windTimeOffset + 1
            self:incrementAnimationFrame(Ticks)
        else
            self.spinning = false
        end
    end
end