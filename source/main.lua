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
import "stats"

local settings <const> = settings
local stats <const> = stats
local scene <const> = scene
local meta <const> = meta

function init()
	settings.load()
	stats.load()

	local menu = playdate.getSystemMenu()
	menu:addCheckmarkMenuItem("play sfx", settings.playSfx, settings.toggleSfx)
	menu:addCheckmarkMenuItem("dark mode", settings.darkMode, settings.toggleDarkMode)
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

function playdate.gameWillTerminate()
	stats.addTimePlayed(playdate.getCurrentTimeMilliseconds())
	stats.save()
end

init()
