local gfx = playdate.graphics
local slib = gfx.sprite

class('Border').extends(slib)

function Border:init(x, y, w, h)
    Border.super.init(self)
    self:moveTo(x,y)
    self:setCollideRect(0, 0, w, h)
    self:add()
end