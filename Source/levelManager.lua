local gfx = playdate.graphics
local slib = gfx.sprite

class('LevelManager').extends(slib)

function LevelManager:init()
    LevelManager.super.init(self)
    self.levelNum = 1
    self.level = Level(1)
end

function LevelManager:resetLevel()
    slib:removeAll()
    self.level = Level(self.levelNum)
end

function LevelManager:nextLevel()
    slib:removeAll()
    self.levelNum = self.levelNum + 1
    self.level = Level(self.levelNum)
end