local gfx = playdate.graphics
local slib = gfx.sprite

class('Level').extends(slib)

local FAN_STRENGTH_CONVERSION = 100
local REAL_FAN_STRENGTH = 0.2
local FAN_STRENGTH = REAL_FAN_STRENGTH/FAN_STRENGTH_CONVERSION
local AIR_FRICTION = 0.1
local BALLOON_MAX_SPEED = 2

function Level:init()
    Level.super.init(self)
    self.balloon = Balloon(300, 200)
    self.fans = {}
    self.selectedFan = Fan(380, 200, DIRECTION.LEFT, true)
    table.insert(self.fans, Fan(280, 220, DIRECTION.UP, false))
    table.insert(self.fans, self.selectedFan)
    table.insert(self.fans, Fan(20, 30, DIRECTION.RIGHT, false))
    -- table.insert(self.fans, Fan(360, 20, DIRECTION.DOWN))
    self:add()
end

function Level:update()
    if self.selectedFan.spinning and self.balloon:inWindPath(self.selectedFan) then
        local fanSpeed = math.floor(playdate.getCrankChange()) * FAN_STRENGTH
        if self.selectedFan.direction == DIRECTION.LEFT or self.selectedFan.direction == DIRECTION.RIGHT then
            if self.selectedFan.direction == DIRECTION.LEFT then
                fanSpeed = fanSpeed * -1
            end
            if math.abs(self.balloon.velocity.x + fanSpeed) < BALLOON_MAX_SPEED then
                self.balloon.velocity.x = self.balloon.velocity.x + fanSpeed
            end
        else
            if self.selectedFan.direction == DIRECTION.DOWN then
                fanSpeed = fanSpeed * -1
            end
            if math.abs(self.balloon.velocity.y - fanSpeed) < BALLOON_MAX_SPEED then 
                self.balloon.velocity.y = self.balloon.velocity.y - fanSpeed
            end
        end
    else
        if math.abs(self.balloon.velocity.x) < 0.1 then
            self.balloon.velocity.x = 0
        elseif self.balloon.velocity.x > 0 then
            self.balloon.velocity.x = self.balloon.velocity.x - AIR_FRICTION
        elseif self.balloon.velocity.x < 0 then
            self.balloon.velocity.x = self.balloon.velocity.x + AIR_FRICTION
        end
        if math.abs(self.balloon.velocity.y) < 0.1 then
            self.balloon.velocity.y = 0
        elseif self.balloon.velocity.y > 0 then
            self.balloon.velocity.y = self.balloon.velocity.y - AIR_FRICTION
        elseif self.balloon.velocity.y < 0 then
            self.balloon.velocity.y = self.balloon.velocity.y + AIR_FRICTION
        end
    end 
end