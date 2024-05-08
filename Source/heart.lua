local gfx = playdate.graphics
local slib = gfx.sprite

class('Heart').extends(slib)

local image = gfx.image.new('img/heart/heart')
local ding = playdate.sound.sampleplayer.new('snd/ding')


function Heart:init()
    Heart.super.init(self)
    self:setImage(image)
    self:moveTo(355,185)
    self:setZIndex(1)
    self.movementAnim = gfx.animator.new(1500, 0, 2, playdate.easingFunctions.outCubic)
    ding:play()
    self:add()
end

function Heart:update()
    if not self.movementAnim:ended() then
        self:moveTo(self.x - self.movementAnim:currentValue(), self.y - self.movementAnim:currentValue())
        local scaleX, scaleY = self:getScale()
        self:setScale(scaleX + self.movementAnim:currentValue() / 10, scaleY + self.movementAnim:currentValue() / 10)
    end

end