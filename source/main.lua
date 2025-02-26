import "CoreLibs/object"
import "CoreLibs/timer"
import "CoreLibs/graphics"
import "store"
import "fonts"
import "icons"
import "sfx"
import "layout"
import "settings"
import "screen"
import "meta"
import "stats"
import "scenes"

local settings <const> = settings
local stats <const> = stats
local scenes <const> = scenes
local meta <const> = meta

function init()
	settings.load()
	stats.load()

	local menu = playdate.getSystemMenu()
	menu:addCheckmarkMenuItem("play sfx", settings.playSfx, settings.toggleSfx)
	menu:addCheckmarkMenuItem("dark mode", settings.darkMode, settings.toggleDarkMode)
	menu:addCheckmarkMenuItem("batt. saver", settings.batterySaver, settings.toggleBatterySaver)
	scenes.switchTo(scenes.mainMenu)
end

function playdate.update()
	playdate.timer.updateTimers()

	scenes.update()

	if meta.isDebug then
		playdate.drawFPS(screen.width - 24, 12)
	end
end

function playdate.gameWillTerminate()
	stats.addTimePlayed(playdate.getCurrentTimeMilliseconds())
	stats.save()
end

init()
