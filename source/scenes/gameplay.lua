import "CoreLibs/graphics"
import "high_score"

scene.gameplay = {}

local gameplay <const> = scene.gameplay
local gfx <const> = playdate.graphics
local fonts <const> = fonts
local gridSize <const> = 20
local gridWidth <const> = screen.width / gridSize - 1
local gridHeight <const> = screen.height / gridSize - 1

local snake = nil
local movementTimer = nil
local apple = nil
local isGameOver = false
local newHighScore = false
local cachedHighScore = nil

local function numParts()
	return #snake.parts
end

local function setNewHighScore(score)
	newHighScore = true
	cachedHighScore = score
	highScore.write(score)
end

local function endGame()
	isGameOver = true
	sfx.play(sfx.death)
	movementTimer:pause()

	local numParts = numParts()

	local saveScore = highScore.read()

	if numParts > saveScore then
		setNewHighScore(numParts)
	else
		cachedHighScore = saveScore
	end
end

local function resetSnake()
	snake = {
		gridX = 2,
		gridY = 2,
		direction = "right",
		inputDirection = nil,
		movementDelayMS = 100,
		parts = {}
	}
end

local function resetMovementTimer()
	movementTimer.duration = snake.movementDelayMS
	movementTimer:reset()
	movementTimer:start()
end

local function drawGameOver()
	gfx.setFont(fonts.medium)
	gfx.drawText("Game Over", 40, 40);

	gfx.setFont(fonts.small)
	gfx.drawText("Press the A button to play again", 40, 88);
	gfx.drawText("Your Score: " .. numParts() .. " | High-Score: " .. cachedHighScore, 40, 120);

	if newHighScore then
		gfx.drawText("New high-score!", 40, 180);
	end
end

local function spawnApple()
	local appleOverlapsSnake = true
	while appleOverlapsSnake do
		apple.gridX = math.random(0, gridWidth)
		apple.gridY = math.random(0, gridHeight)

		local anyOverlaps = false

		if apple.gridX == snake.gridX and apple.gridY == snake.gridY then
			anyOverlaps = true
		end

		for _, part in pairs(snake.parts) do
			if apple.gridX == part.gridX and apple.gridY == part.gridY then
				anyOverlaps = true
			end
		end

		appleOverlapsSnake = anyOverlaps
	end
end

local function updateSnake()
	if playdate.buttonIsPressed(playdate.kButtonLeft) then
		if snake.direction ~= "right" then
			snake.inputDirection = "left"
		end
	end
	if playdate.buttonIsPressed(playdate.kButtonRight) then
		if snake.direction ~= "left" then
			snake.inputDirection = "right"
		end
	end
	if playdate.buttonIsPressed(playdate.kButtonUp) then
		if snake.direction ~= "down" then
			snake.inputDirection = "up"
		end
	end
	if playdate.buttonIsPressed(playdate.kButtonDown) then
		if snake.direction ~= "up" then
			snake.inputDirection = "down"
		end
	end
end

local function checkForSnakeBite()
	for _, part in pairs(snake.parts) do
		if part.gridX == snake.gridX and part.gridY == snake.gridY then
				endGame();
				return
		end
	end
end

local function moveSnake()
	local prevPos = { gridX = snake.gridX, gridY = snake.gridY }

	for _, part in pairs(snake.parts) do
		local segmentPos = { gridX = part.gridX, gridY = part.gridY }
		part.gridX = prevPos.gridX
		part.gridY = prevPos.gridY
		prevPos = segmentPos
	end

	snake.direction = snake.inputDirection or snake.direction

	if snake.direction == "right" then
		snake.gridX += 1
	end
	if snake.direction == "left" then
		snake.gridX -= 1
	end
	if snake.direction == "up" then
		snake.gridY -= 1
	end
	if snake.direction == "down" then
		snake.gridY += 1
	end

	if snake.gridX > gridWidth then
		snake.gridX = 0
	end
	if snake.gridX < 0 then
		snake.gridX = gridWidth
	end
	if snake.gridY > gridHeight then
		snake.gridY = 0
	end
	if snake.gridY < 0 then
		snake.gridY = gridHeight
	end

	snake.inputDirection = nil

	checkForSnakeBite()
end

local function eatApple()
	sfx.play(sfx.apple)
	table.insert(snake.parts, { gridX = snake.gridX, gridY = snake.gridY })

	if #snake.parts == 5 then
		snake.movementDelayMS = 90
		resetMovementTimer()
	end

	if #snake.parts == 10 then
		snake.movementDelayMS = 80
		resetMovementTimer()
	end

	if #snake.parts == 20 then
		snake.movementDelayMS = 60
		resetMovementTimer()
	end

	if #snake.parts == 30 then
		snake.movementDelayMS = 50
		resetMovementTimer()
	end

	spawnApple()
end

local function resetGame()
	newHighScore = false
	cachedHighScore = highScore.read()
	isGameOver = false
	resetSnake()
	spawnApple()
	resetMovementTimer()
end

function gameplay.update()
	print("gameplay update")

	if isGameOver then
		if playdate.buttonJustPressed(playdate.kButtonA) then
			sfx.play(sfx.select)
			resetGame()
		end
	else
		updateSnake()
	end

	if snake.gridX == apple.gridX and snake.gridY == apple.gridY then
		eatApple()
	end

	gfx.clear()

	if isGameOver then
		drawGameOver()
	else
		gfx.fillRect(snake.gridX * gridSize, snake.gridY * gridSize, gridSize, gridSize)
		for _, part in pairs(snake.parts) do
			gfx.fillRect(part.gridX * gridSize, part.gridY * gridSize, gridSize, gridSize)
		end
		gfx.fillCircleAtPoint(
			apple.gridX * gridSize + gridSize / 2,
			apple.gridY * gridSize + gridSize / 2,
			gridSize / 2 - 2
		)
	end
end
function gameplay.init()
	print("gameplay init")

	resetSnake()

	movementTimer = playdate.timer.new(snake.movementDelayMS, function()
		if isGameOver then
			return
		end

		moveSnake()
	end)

	movementTimer.repeats = true
	movementTimer:pause()

	apple = {
		gridX = 5,
		gridY = 5,
	}

	resetGame()
end
