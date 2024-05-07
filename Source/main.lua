import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "CoreLibs/animation"
import "CoreLibs/crank"
import "balloon"
import "fan"
import "wind"
import "level"
import "spike"
import "spikeStrip"

DIRECTION = {LEFT = -1, RIGHT = 1, UP = 2, DOWN = -2}
SPIKE_TAG = 1

Ticks = 0
local CRANK_SPEED = 7
local gfx = playdate.graphics
local slib = gfx.sprite

local level = Level()

function playdate.leftButtonDown()
    level:changeSelectedFan(-1)
end

function playdate.rightButtonDown()
    level:changeSelectedFan(1)
end

function playdate.AButtonDown()
    level.balloon.popped = true
end

function playdate.update()
    slib.update()
    Ticks = playdate.getCrankTicks(CRANK_SPEED)
end
