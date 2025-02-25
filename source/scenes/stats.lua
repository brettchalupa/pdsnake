scene.stats = {}

local layout <const> = layout
local stats <const> = scene.stats
local gfx <const> = playdate.graphics

function stats.update()
	if playdate.buttonIsPressed(playdate.kButtonB) then
		sfx.play(sfx.select)
		scene.switchTo(scene.mainMenu)
		return
	end

	gfx.clear()

	gfx.setFont(fonts.medium)

	gfx.drawText("Stats", layout.xPad, 10);

	gfx.setFont(fonts.small)
end

function stats.init()
end

function stats.denit()
end
