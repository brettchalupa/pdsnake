import "CoreLibs/object"
import "CoreLibs/timer"
import "CoreLibs/graphics"
import "store"
import "fonts"
import "sfx"
import "settings"
import "screen"
import "meta"
import "scene"
import "high_score"

local settings <const> = settings
local scene <const> = scene
local meta <const> = meta

function init()
	settings.load()

	local menu = playdate.getSystemMenu()
	menu:addMenuItem("reset score", function()
		highScore.write(0)
		scene.switchTo(scene.mainMenu)
	end)
	menu:addCheckmarkMenuItem("play sfx", settings.playSfx, settings.toggleSfx)
	menu:addCheckmarkMenuItem("batt. saver", settings.batterySaver, settings.toggleBatterySaver)
	scene.switchTo(scene.mainMenu)
end

function playdate.update()
	playdate.timer.updateTimers()

	scene.update()

	if meta.isDebug then
		playdate.drawFPS(screen.width - 24, 12)
	end
end

init()
