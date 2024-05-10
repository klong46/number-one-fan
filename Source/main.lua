import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "CoreLibs/animation"
import "CoreLibs/crank"
import "CoreLibs/ui"
import "balloon"
import "fan"
import "wind"
import "level"
import "spike"
import "spikeStrip"
import "background"
import "boy"
import "screenBorder"
import "cowboy"
import "levelManager"
import "heart"
import "tutorial"
import "continueButton"

DIRECTION = {LEFT = -1, RIGHT = 1, UP = 2, DOWN = -2}
SPIKE_TAG = 1
COWBOY_TAG = 2
MAX_BALLOON_SPEED = 3
NUM_LEVELS = 2

local backgroundMusic = playdate.sound.fileplayer.new('snd/jazz_music')
backgroundMusic:play(0)

Ticks = 0
local onTutorial = true
local pdMenu = playdate.getSystemMenu()
local CRANK_SPEED = 10
local gfx = playdate.graphics
local slib = gfx.sprite
local tutorial = Tutorial()

function playdate.leftButtonDown()
    LevelController.level:changeSelectedFan(-1)
end

function playdate.rightButtonDown()
    LevelController.level:changeSelectedFan(1)
end

function playdate.AButtonDown()
    if onTutorial then
        if tutorial.screen == 1 then
            tutorial:next()
        else
            slib.removeAll()
            LevelController = LevelManager()
            pdMenu:removeAllMenuItems()
            RestartMenuItem = pdMenu:addMenuItem("restart", function()
                LevelController:resetLevel()
            end)
            onTutorial = false
        end
    end
end

function playdate.BButtonDown()
    if onTutorial then
        tutorial:back()
    end
end

function playdate.update()
    slib.update()
    Ticks = playdate.getCrankTicks(CRANK_SPEED)
    if playdate.isCrankDocked() then
        playdate.ui.crankIndicator:draw()
    end
end
