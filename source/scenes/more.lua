scene.more = {}

local more <const> = scene.more
local gfx <const> = playdate.graphics
local layout <const> = layout
local qrCode = nil

function more.update()
	if playdate.buttonJustPressed(playdate.kButtonB) then
		sfx.play(sfx.select)
		scene.switchTo(scene.mainMenu)
		return
	end
end

function more.init()
	qrCode = playdate.graphics.image.new("sprites/qrcode.png")
	assert(qrCode, "Failed to load QR code image")

	more.draw()
end

function more.draw()
	gfx.clear()

	gfx.setFont(fonts.medium)

	gfx.drawText("More", layout.xPad, 10);

	gfx.setFont(fonts.small)

	qrCode:draw(layout.xPad - 2, 60)

	gfx.drawText("Find more of my games at\nbrettchalupa.itch.io", 112, 80)

	gfx.drawText("PDSnake is dedicated to the public domain.", layout.xPad, 160)

	gfx.drawText("(B) ack", layout.xPad, 200)
	gfx.drawText(meta.versionAndBuild, screen.width - 130, 200);
end

function more.denit()
	qrCode = nil
end
