scene.stats = {}

local layout <const> = layout
local stats <const> = stats
local gfx <const> = playdate.graphics

function scene.stats.update()
	if playdate.buttonJustPressed(playdate.kButtonA) and playdate.buttonJustPressed(playdate.kButtonB) then
		sfx.play(sfx.death)
		stats.reset()
		scene.stats.drawScene()
		return
	end

	if playdate.buttonJustPressed(playdate.kButtonB) then
		sfx.play(sfx.select)
		scene.switchTo(scene.mainMenu)
		return
	end
end

function scene.stats.init()
	stats.load()
	scene.stats.drawScene()
end

function scene.stats.drawScene()
	gfx.clear()

	gfx.setFont(fonts.medium)

	gfx.drawText("Stats", layout.xPad, 10);

	gfx.setFont(fonts.small)


	gfx.drawText("High-Score: " .. stats.highScore, layout.xPad, 60)
	gfx.drawText("Plays: " .. stats.plays, layout.xPad, 88)
	gfx.drawText("Apples Eaten: " .. stats.applesEaten, layout.xPad, 116)

	gfx.drawText("(A) + (B) to reset stats", layout.xPad, 160)
	gfx.drawText("(B) ack", layout.xPad, 188)
end

function scene.stats.denit()
end
