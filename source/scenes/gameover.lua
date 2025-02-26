scenes.gameover = {}

local gameover <const> = scenes.gameover
local gfx <const> = playdate.graphics
local fonts <const> = fonts

local score = nil
local highScore = nil
local isNewHigh = false

function gameover.setScore(_score, _highScore, _isNewHigh)
	score = _score
	highScore = _highScore
	isNewHigh = _isNewHigh
end

function gameover.init()
end

function gameover.denit()
	score = nil
	highScore = false
end

local function drawGameOver()
	gfx.clear()

	gfx.setFont(fonts.medium)
	gfx.drawText("Game Over", 40, 40);

	gfx.setFont(fonts.small)
	gfx.drawText("Press the A button to play again", 40, 88);
	gfx.drawText("Your Score: " .. score .. " | High-Score: " .. highScore, 40, 120);

	if isNewHigh then
		gfx.drawText("New high-score!", 40, 180);
	end
end

function gameover.update()
	if playdate.buttonJustPressed(playdate.kButtonA) then
		sfx.play(sfx.select)
		scenes.switchTo(scenes.gameplay)
		return
	end

	if playdate.buttonJustPressed(playdate.kButtonB) then
		sfx.play(sfx.select)
		scenes.switchTo(scenes.mainMenu)
		return
	end

	drawGameOver()
end
