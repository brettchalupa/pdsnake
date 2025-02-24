scene.mainMenu = {}

local mainMenu <const> = scene.mainMenu

local gfx <const> = playdate.graphics

local meta <const> = meta
local sfx <const> = sfx
local fonts <const> = fonts
local xPad <const> = 12
local scene <const> = scene

local drawStart = nil
local toggleTimer = nil
local snakeImage = nil

local hs = nil

function mainMenu.update()
	if playdate.buttonIsPressed(playdate.kButtonA) then
		sfx.play(sfx.select)
		scene.switchTo(scene.gameplay)
		return
	end

	gfx.clear()
	snakeImage:draw(xPad, 8)

	gfx.setFont(fonts.medium)

	gfx.drawText(meta.name, xPad + 38, 10);

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
		gfx.drawText("High-Score: " .. hs, 240, 16);
	end

	gfx.drawText(meta.versionAndBuild, xPad, screen.height - 34);
	gfx.drawText("by " .. meta.author, screen.width - 156, screen.height - 34);
end

function mainMenu.init()
	drawStart = true
	toggleTimer = playdate.timer.new(600, function()
		drawStart = not drawStart
	end)
	toggleTimer.repeats = true
	toggleTimer.reverse = true
	stats.load()
	hs = stats.highScore

	snakeImage = gfx.image.new("sprites/snake.png")
	assert(snakeImage)
end

function mainMenu.denit()
	toggleTimer:remove()
	toggleTimer = nil
	hs = nil
	snakeImage = nil
end
