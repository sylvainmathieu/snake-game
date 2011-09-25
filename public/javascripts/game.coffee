
intervalId = ctx = score = nextSpeed = speed = playerPos = food = map = null
gridSize = 40
lifeTime = null

KEY =
	LEFT_ARROW: 37
	UP_ARROW: 38
	RIGHT_ARROW: 39
	DOWN_ARROW: 40

drawBlock = (pos) ->
	ctx.strokeStyle = "rgba(255,255,255, 0.5)"
	ctx.strokeRect pos.x * 10 + 0.5, pos.y * 10 + 0.5, 8, 8
	ctx.fillStyle = "rgba(255,255,255,0.2)"
	ctx.fillRect pos.x * 10 + 0.5, pos.y * 10 + 0.5, 8, 8

eraseBlock = (pos) ->
	ctx.fillStyle = "#27005b"  
	ctx.fillRect pos.x * 10, pos.y * 10, 10, 10

popFood = ->
	randPos = ->
		food.x = Math.floor(Math.random() * 30)
		food.y = Math.floor(Math.random() * 30)
	randPos()	
	randPos() while map[food.x][food.y] > 0

	ctx.strokeStyle = "rgba(152,208,0,0.8)"
	ctx.strokeRect food.x * 10 + 0.5, food.y * 10 + 0.5, 8, 8
	ctx.fillStyle = "rgba(152,208,0,0.5)"
	ctx.fillRect food.x * 10 + 0.5, food.y * 10 + 0.5, 8, 8

eatFood = ->
	eraseBlock playerPos
	lifeTime++
	score += 100
	popFood()

tick = ->
	score-- if score > 0
	$(".score").text score

	speed = nextSpeed
	playerPos.x += speed.x
	playerPos.y += speed.y

	for y in [0..(gridSize - 1)]
		for x in [0..(gridSize - 1)]
			if map[x][y] > 0
				map[x][y]--
				if map[x][y] == 0
					eraseBlock {x: x, y: y}

	eatFood() if playerPos.x == food.x && playerPos.y == food.y

	drawBlock playerPos

	if map[playerPos.x] == undefined || map[playerPos.x][playerPos.y] == undefined || map[playerPos.x][playerPos.y] > 0
		clearInterval(intervalId)
		$(".gameOver").show()
		$(".gameOver .finalScore").text score
	else
		map[playerPos.x][playerPos.y] = lifeTime

init = ->
	nextSpeed = {x: 1, y: 0}
	speed = {x: 1, y: 0}
	playerPos = {x: 15, y: 15}
	food = {x: 16, y: 15}

	lifeTime = 10

	map = (0 for y in [0..(gridSize - 1)] for x in [0..(gridSize - 1)])

	score = 0

	canvas = document.getElementById "game"
	canvas.width = canvas.width;
	ctx = canvas.getContext "2d"

	ctx.fillStyle = "#27005b"
	ctx.fillRect 0, 0, gridSize * 10, gridSize * 10

	intervalId = setInterval tick, 100

	popFood()

$ ->
	init()

	$(document).keydown (event) ->
		switch event.keyCode
			when KEY.LEFT_ARROW then nextSpeed = {x: -1, y: 0} if speed.x != 1; break;
			when KEY.UP_ARROW then nextSpeed = {x: 0, y: -1} if speed.y != 1; break;
			when KEY.RIGHT_ARROW then nextSpeed = {x: 1, y: 0} if speed.x != -1; break;
			when KEY.DOWN_ARROW then nextSpeed = {x: 0, y: 1} if speed.y != -1; break;

	$(".restart a").click ->
		init()
		$(".gameOver").hide()
