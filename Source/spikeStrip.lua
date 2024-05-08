local gfx = playdate.graphics
local slib = gfx.sprite

class('SpikeStrip').extends(slib)

function SpikeStrip:init(x, y, direction, length)
    SpikeStrip.super.init(self)
    self.spikes = {}
    y = y + 5
    x = x + 5
    for i=0, length-1 do
        local position = {x = x, y = y}
        if direction == DIRECTION.LEFT or direction == DIRECTION.RIGHT then
            position.y = y + i * 10
        elseif direction == DIRECTION.UP or direction == DIRECTION.DOWN then
            position.x = x + i * 10
        end
        table.insert(self.spikes, Spike(position.x, position.y, direction))
    end
    self:add()
end