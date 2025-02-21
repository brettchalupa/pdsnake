scene.mainMenu = {}

local mainMenu <const> = scene.mainMenu

local gfx <const> = playdate.graphics

local meta <const> = meta
local sfx <const> = sfx
local fonts <const> = fonts
local xPad <const> = 24
local scene <const> = scene

local drawStart = nil
local toggleTimer = nil

local hs = nil

function mainMenu.update()
	if playdate.buttonIsPressed(playdate.kButtonA) then
		sfx.play(sfx.select)
		scene.switchTo(scene.gameplay)
		return
	end

	gfx.clear()

	gfx.setFont(fonts.medium)

	gfx.drawText(meta.name, xPad, 20);

	gfx.setFont(fonts.small)

	if drawStart then
		gfx.drawText("A   Start", xPad + 4, 120);
		gfx.drawCircleAtPoint(
			xPad + 10,
			130,
			14
		)
	end

	if hs > 0 then
		gfx.drawText("High-Score: " .. hs, 240, 26);
	end

	gfx.drawText(meta.versionAndBuild, xPad, screen.height - 44);
	gfx.drawText("by " .. meta.author, screen.width - 164, screen.height - 44);
end

function mainMenu.init()
	print("main menu init")
	drawStart = true
	toggleTimer = playdate.timer.new(600, function()
		drawStart = not drawStart
	end)
	toggleTimer.repeats = true
	toggleTimer.reverse = true
	hs = highScore.read()
end

function mainMenu.denit()
	toggleTimer:remove()
	toggleTimer = nil
	hs = nil
end
