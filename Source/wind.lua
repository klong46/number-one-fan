local gfx = playdate.graphics
local slib = gfx.sprite

class('Wind').extends(slib)

local function getAnimationTable(direction, reversed)
    local dir = direction
    if reversed then
        dir = direction * -1
    end
    if dir == DIRECTION.LEFT or dir == DIRECTION.DOWN then
        return gfx.imagetable.new('img/wind/wind_animation_left')
    elseif dir == DIRECTION.RIGHT or dir == DIRECTION.UP then
        return gfx.imagetable.new('img/wind/wind_animation_right')
    end
end

local DIRECTION_OFFSET = 100
local X_OFFSET = 25
local Y_OFFSET = -5
local MOVEMENT_SPEED = 1.5

function Wind:init(x, y, direction, reversed)
    Wind.super.init(self)
    local animationTable = getAnimationTable(direction, reversed)
    self.direction = direction
    self.reversed = reversed
    local directionOffset = 0
    local xOffset = X_OFFSET
    if direction == DIRECTION.LEFT or direction == DIRECTION.DOWN then
        xOffset = -X_OFFSET
    end
    if reversed then
        if direction == DIRECTION.LEFT or direction == DIRECTION.DOWN then
            directionOffset = -DIRECTION_OFFSET
        elseif direction == DIRECTION.RIGHT or direction == DIRECTION.UP then
            directionOffset = DIRECTION_OFFSET
        end
    end
    if direction == DIRECTION.UP or direction == DIRECTION.DOWN then
        self:moveTo(x+Y_OFFSET, y-xOffset-directionOffset)
    else
        self:moveTo(x+xOffset+directionOffset, y+Y_OFFSET)
    end
    self.animation = gfx.animation.loop.new(50, animationTable, false)
    self:add()
end

function Wind:move()
    local movement = MOVEMENT_SPEED
    if self.reversed then
        movement = -MOVEMENT_SPEED
    end
    if self.direction == DIRECTION.LEFT then
        self:moveBy(-movement, 0)
    elseif self.direction == DIRECTION.RIGHT then
        self:moveBy(movement, 0)
    elseif self.direction == DIRECTION.UP then
        self:moveBy(0, -movement)
    elseif self.direction == DIRECTION.DOWN then
        self:moveBy(0, movement)
    end
end

function Wind:update()
    if self.animation:isValid() then
        local image = self.animation:image()
        if self.direction == DIRECTION.UP then
            if self.reversed then
                image = image:rotatedImage(90)
            else
                image = image:rotatedImage(-90)
            end
        end
        if self.direction == DIRECTION.DOWN then
            if self.reversed then
                image = image:rotatedImage(-90)
            else
                image = image:rotatedImage(90)
            end
        end
        self:setImage(image)
        self:move()
    else
        self:remove()
    end
end