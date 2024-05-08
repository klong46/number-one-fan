local gfx = playdate.graphics
local slib = gfx.sprite

class('Cowboy').extends(slib)

local animationTable = gfx.imagetable.new('img/cowboy/cowboy_idle')

function Cowboy:init()
    Cowboy.super.init(self)
    self.animation = gfx.animation.loop.new(200, animationTable, true)
    self:setCollideRect(0, 0, 80, 80)
    self:setTag(COWBOY_TAG)
    self:moveTo(360, 200)
    self:add()
end

function Cowboy:update()
    Cowboy.super.update(self)
    self:setImage(self.animation:image())
end