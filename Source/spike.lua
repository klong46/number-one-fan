local gfx = playdate.graphics
local slib = gfx.sprite

class('Spike').extends(slib)


function Spike:init(x, y, direction)
    Spike.super.init(self)
    self:setImage(self:getImageByDirection(direction))
    self:moveTo(x, y)
    self:setCollideRect(0, 0, self:getSize())
    self:setTag(SPIKE_TAG)
    self:add()
end

function Spike:getImageByDirection(direction)
    if direction == DIRECTION.LEFT then
        return gfx.image.new('img/spike/spike_left')
    elseif direction == DIRECTION.RIGHT then
        return gfx.image.new('img/spike/spike_right')
    elseif direction == DIRECTION.UP then
        return gfx.image.new('img/spike/spike_up')
    elseif direction == DIRECTION.DOWN then
        return gfx.image.new('img/spike/spike_down')
    end
end