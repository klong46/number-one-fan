local gfx = playdate.graphics
local slib = gfx.sprite

class('Balloon').extends(slib)

local image = gfx.image.new('img/balloon')

function Balloon:init(x, y)
    Balloon.super.init(self)
    self:setImage(image)
    self:moveTo(x, y)
    self.velocity = {x = 0, y = 0}
    self:add()
end

function Balloon:inWindPath(fan)
    return self.y > fan.windPath.top and
           self.y < fan.windPath.bottom and
           self.x > fan.windPath.left and
           self.x < fan.windPath.right
end

function Balloon:update()
    if math.abs(self.velocity.y) < 0.5 then
        self.velocity.y = self.velocity.y + 0.01
    end
    self:moveBy(self.velocity.x, self.velocity.y)
end