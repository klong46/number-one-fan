local gfx = playdate.graphics
local slib = gfx.sprite

class('Balloon').extends(slib)

local image = gfx.image.new('img/balloon/balloon')
local animationTable = gfx.imagetable.new('img/balloon/balloon_pop_animation')
local popSound = playdate.sound.sampleplayer.new('snd/balloon_pop')

function Balloon:init()
    Balloon.super.init(self)
    self:setImage(image)
    self:moveTo(23, 162)
    self:setCollideRect(0, 0, self:getSize())
    self.velocity = {x = 0, y = 0}
    self.animation = gfx.animation.loop.new(70, animationTable, false)
    self.animation.paused = true
    self.popped = false
    self.collisionResponse = 'bounce'
    self:add()
end

function Balloon:inWindPath(fan)
    return self.y > fan.windPath.top and
           self.y < fan.windPath.bottom and
           self.x > fan.windPath.left and
           self.x < fan.windPath.right
end

function Balloon:update()
    -- if math.abs(self.velocity.y) < MAX_BALLOON_SPEED then
    --     self.velocity.y = self.velocity.y + 0.15
    -- end
    if self.popped then
        self.animation.paused = false
        self:setImage(self.animation:image())
        if math.abs(self.velocity.y) < 4 then
            self.velocity.y = self.velocity.y + 0.8
        end
        self:moveBy(self.velocity.x, self.velocity.y)
        if self.y > 240 then
            LevelController:resetLevel()
        end
    else
        local x, y, collisions = self:moveWithCollisions(self.x + self.velocity.x, self.y + self.velocity.y)
        for i, collision in ipairs(collisions) do
            if collision.other:getTag() == SPIKE_TAG then
                popSound:play()
                self.popped = true
                self.velocity.y = 0
                self.velocity.x = 0
            elseif collision.other:getTag() == COWBOY_TAG then
                Heart()
                self:remove()
            else
                self.velocity.y = self.velocity.y * -0.5
                self.velocity.x = self.velocity.x * -0.5
            end
        end
    end
end