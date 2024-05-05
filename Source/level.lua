local gfx = playdate.graphics
local slib = gfx.sprite

class('Level').extends(slib)

local FAN_STRENGTH_CONVERSION = 100
local REAL_FAN_STRENGTH = 1.7
local FAN_STRENGTH = REAL_FAN_STRENGTH/FAN_STRENGTH_CONVERSION
local AIR_FRICTION = 0.1

function Level:init()
    Level.super.init(self)
    self.balloon = Balloon(200, 100)
    self.fans = {}
    table.insert(self.fans, Fan(150, 140, DIRECTION.RIGHT))
    table.insert(self.fans, Fan(150, 190, DIRECTION.RIGHT))
    self:add()
end

function Level:update()
    for i, fan in ipairs(self.fans) do
        if fan.spinning and self.balloon:inWindPath(fan) then
            if math.abs(self.balloon.velocity.x) < 1 then
                local fanSpeed = math.floor(playdate.getCrankChange()) * FAN_STRENGTH
                self.balloon.velocity.x = self.balloon.velocity.x + fanSpeed
            end
        else
            if math.abs(self.balloon.velocity.x) < 0.1 then
                self.balloon.velocity.x = 0
            elseif self.balloon.velocity.x > 0 then
                self.balloon.velocity.x = self.balloon.velocity.x - AIR_FRICTION
            elseif self.balloon.velocity.x < 0 then
                self.balloon.velocity.x = self.balloon.velocity.x + AIR_FRICTION
            end
        end
    end
end