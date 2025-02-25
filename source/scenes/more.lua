scene.more = {}

local more <const> = scene.more
local gfx <const> = playdate.graphics
local layout <const> = layout

function more.update()
	if playdate.buttonIsPressed(playdate.kButtonB) then
		sfx.play(sfx.select)
		scene.switchTo(scene.mainMenu)
		return
	end

	gfx.clear()

	gfx.setFont(fonts.medium)

	gfx.drawText("More", layout.xPad, 10);

	gfx.setFont(fonts.small)
end

function more.init()
end

function more.denit()
end
