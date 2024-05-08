local gfx = playdate.graphics
local slib = gfx.sprite

class('Background').extends(slib)

local image = gfx.image.new('img/background')

function Background:init()
    Background.super.init(self)
    self:setImage(image:fadedImage(0.2, gfx.image.kDitherTypeScreen))
    self:moveTo(100,100)
    self:setZIndex(-1)
    self:add()
end