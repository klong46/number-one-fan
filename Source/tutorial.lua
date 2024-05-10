local gfx = playdate.graphics
local slib = gfx.sprite

class('Tutorial').extends(slib)

local SCREEN_1 = gfx.image.new('img/tutorial/tutorial_1')
local SCREEN_2 = gfx.image.new('img/tutorial/tutorial_2')
local POSITION = {X = 200, Y = 120}

function Tutorial:init()
    Tutorial.super.init(self)
    OnControlScreen = true
    self.screen = 1
    slib.removeAll()
    self:setImage(SCREEN_1)
    self:moveTo(POSITION.X, POSITION.Y)
    ContinueButton()
    self:add()
end

function Tutorial:next()
    if self.screen == 1 then
        self:setImage(SCREEN_2)
        self.screen = 2
    elseif self.screen == 2 then
        LevelController = LevelManager()
    end
end

function Tutorial:back()
    if self.screen == 2 then
        self:setImage(SCREEN_1)
        self.screen = 1
    end
end