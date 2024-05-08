local gfx = playdate.graphics
local slib = gfx.sprite

class('Boy').extends(slib)

local animationTable = gfx.imagetable.new('img/boy/boy_idle')

function Boy:init()
    Boy.super.init(self)
    self.animation = gfx.animation.loop.new(200, animationTable, true)
    self:setCollideRect(0, 43, 80, 40)
    self:moveTo(40, 200)
    self:add()
end

function Boy:update()
    Boy.super.update(self)
    self:setImage(self.animation:image())
end