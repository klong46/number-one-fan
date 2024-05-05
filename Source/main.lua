import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "CoreLibs/animation"
import "CoreLibs/crank"
import "balloon"
import "fan"
import "wind"
import "level"

DIRECTION = {LEFT = -1, RIGHT = 1, UP = 2, DOWN = -2}

Ticks = 0
local CRANK_SPEED = 7
local gfx = playdate.graphics
local slib = gfx.sprite

Level()

function playdate.update()
    slib.update()
    Ticks = playdate.getCrankTicks(CRANK_SPEED)
end
