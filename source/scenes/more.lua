scene.more = {}

local more <const> = scene.more
local gfx <const> = playdate.graphics
local layout <const> = layout

function more.update()
	if playdate.buttonJustPressed(playdate.kButtonB) then
		sfx.play(sfx.select)
		scene.switchTo(scene.mainMenu)
		return
	end
end

function more.init()
	more.draw()
end

function more.draw()
	gfx.clear()

	gfx.setFont(fonts.medium)

	gfx.drawText("More", layout.xPad, 10);

	gfx.setFont(fonts.small)

	gfx.drawText("Find more of my games at\nbrettchalupa.itch.io", layout.xPad, 60)

	gfx.drawText("(B) ack", layout.xPad, 188)
end

function more.denit()
end
