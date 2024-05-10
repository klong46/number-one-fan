local gfx = playdate.graphics
local slib = gfx.sprite

class('Level').extends(slib)

local FAN_STRENGTH_CONVERSION = 100
local REAL_FAN_STRENGTH = 0.7
local FAN_STRENGTH = REAL_FAN_STRENGTH/FAN_STRENGTH_CONVERSION
local AIR_FRICTION = 0.1

function Level:init(levelNum)
    Level.super.init(self)
    Background()
    ScreenBorder()
    self.balloon = Balloon()
    self.fans = {}
    self.levelData = playdate.datastore.read("levels/"..levelNum)
    -- self.selectedFan = Fan(20, 9, DIRECTION.DOWN, true)
    -- table.insert(self.fans, Fan(150, 80, DIRECTION.LEFT, false))
    -- table.insert(self.fans, self.selectedFan)
    self:addSpikestrips()
    self:addFans()
    Boy()
    Cowboy()
    self:add()
end

function Level:addSpikestrips()
    for i, strip in ipairs(self.levelData.spikeStrips) do
        SpikeStrip(strip.x, strip.y, strip.direction, strip.length)
    end
end

function Level:addFans()
    for i, fan in ipairs(self.levelData.fans) do
        local currentFan = Fan(fan.x, fan.y, fan.direction, fan.selected)
        table.insert(self.fans, currentFan)
        if fan.selected then
            self.selectedFan = currentFan
        end
    end
end

function Level:getSelectedFanIndex()
    for i, fan in ipairs(self.fans) do
        if fan == self.selectedFan then
            return i
        end
    end
end

function Level:changeSelectedFan(increment)
    self.selectedFan:unselect()
    local index = self:getSelectedFanIndex()
    if increment == 1 and index == #self.fans then
        self.selectedFan = self.fans[1]
    elseif increment == -1 and index == 1 then
        self.selectedFan = self.fans[#self.fans]
    else
        self.selectedFan = self.fans[index + increment]
    end
    self.selectedFan.selected = true
end

function Level:update()
    if not self.balloon.popped and
           self.selectedFan.spinning and
           self.balloon:inWindPath(self.selectedFan) then
        local fanSpeed = math.floor(playdate.getCrankChange()) * FAN_STRENGTH
        if self.selectedFan.direction == DIRECTION.LEFT or self.selectedFan.direction == DIRECTION.RIGHT then
            if self.selectedFan.direction == DIRECTION.LEFT then
                fanSpeed = fanSpeed * -1
            end
            if math.abs(self.balloon.velocity.x + fanSpeed) < MAX_BALLOON_SPEED then
                self.balloon.velocity.x = self.balloon.velocity.x + fanSpeed
            end
        else
            if self.selectedFan.direction == DIRECTION.DOWN then
                fanSpeed = fanSpeed * -1
            end
            if math.abs(self.balloon.velocity.y - fanSpeed) < MAX_BALLOON_SPEED then
                self.balloon.velocity.y = self.balloon.velocity.y - fanSpeed
            end
        end
    else
        if math.abs(self.balloon.velocity.x) < 0.05 then
            self.balloon.velocity.x = 0
        elseif self.balloon.velocity.x > 0 then
            self.balloon.velocity.x = self.balloon.velocity.x - AIR_FRICTION
        elseif self.balloon.velocity.x < 0 then
            self.balloon.velocity.x = self.balloon.velocity.x + AIR_FRICTION
        end
        if math.abs(self.balloon.velocity.y) < 0.05 then
            self.balloon.velocity.y = 0
        elseif self.balloon.velocity.y > 0 then
            self.balloon.velocity.y = self.balloon.velocity.y - AIR_FRICTION
        elseif self.balloon.velocity.y < 0 then
            self.balloon.velocity.y = self.balloon.velocity.y + AIR_FRICTION
        end
    end
end

-- TODO:
-- test on device
-- JSON level editor