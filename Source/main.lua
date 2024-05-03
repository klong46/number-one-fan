import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "CoreLibs/animation"
import "CoreLibs/crank"
import "balloon"

local gfx = playdate.graphics
local slib = gfx.sprite

Balloon()

function playdate.update()
    slib.update()
end
