local gfx = playdate.graphics
local slib = gfx.sprite

class('Balloon').extends(slib)

local image = gfx.image.new('img/balloon/balloon')
local animationTable = gfx.imagetable.new('img/balloon/balloon_pop_animation')

function Balloon:init(x, y)
    Balloon.super.init(self)
    self:setImage(image)
    self:moveTo(x, y)
    self:setCollideRect(0, 0, self:getSize())
    self.velocity = {x = 0, y = 0}
    self.animation = gfx.animation.loop.new(70, animationTable, false)
    self.animation.paused = true
    self.popped = false
    self:add()
end

function Balloon:inWindPath(fan)
    return self.y > fan.windPath.top and
           self.y < fan.windPath.bottom and
           self.x > fan.windPath.left and
           self.x < fan.windPath.right
end

function Balloon:update()
    -- if math.abs(self.velocity.y) < 2 then
    --     self.velocity.y = self.velocity.y - 0.11
    -- end
    if self.popped then
        self.animation.paused = false
        self:setImage(self.animation:image())
        if math.abs(self.velocity.y) < 4 then
            self.velocity.y = self.velocity.y + 0.4
        end
        self:moveBy(self.velocity.x, self.velocity.y)
    else
        local x, y, collisions = self:moveWithCollisions(self.x + self.velocity.x, self.y + self.velocity.y)
        for i, collision in ipairs(collisions) do
            if collision.other:getTag() == SPIKE_TAG then
                self.popped = true
                self.velocity.y = 0
                self.velocity.x = 0
            end
        end
    end
end