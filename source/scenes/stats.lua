scene.stats = {}

-- TODO: refactor into layout module
local xPad <const> = 12
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

	gfx.drawText("Stats", xPad, 10);

	gfx.setFont(fonts.small)
end

function stats.init()
end

function stats.denit()
end
