import "border"

local gfx = playdate.graphics
local slib = gfx.spri

class('ScreenBorder').extends(slib)

function ScreenBorder:init()
    ScreenBorder.super.init(self)
    Border(0, 0, 400, 1)
    Border(0, 0, 1, 240)
    Border(0, 240, 400, 1)
    Border(400, 0, 1, 240)
end