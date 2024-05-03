local gfx = playdate.graphics
local slib = gfx.sprite

class('Balloon').extends(slib)

local image = gfx.image.new('img/balloon')

function Balloon:init()
    Balloon.super.init(self)
    self:setImage(image)
    self:moveTo(200, 120)
    self.velocity = {x = 0, y = 0}
    self:add()
end

function Balloon:update()
    if self.velocity.y > -1 then
        self.velocity.y = self.velocity.y - 0.1
    end

    self:moveBy(self.velocity.x, self.velocity.y)
end