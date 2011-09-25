
intervalId = null
ctx = null

map = (0 for y in [0..29] for x in [0..29])

food =
	x: 16
	y: 15

lifeTime = 10

KEY =
	LEFT_ARROW: 37
	UP_ARROW: 38
	RIGHT_ARROW: 39
	DOWN_ARROW: 40

nextSpeed =
	x: 1
	y: 0

speed =
	x: 1
	y: 0

position =
	top: 15
	left: 15

init = ->
	ctx.fillStyle = "#27005b"
	ctx.fillRect 0, 0, 300, 300

drawBlock = (pos) ->
	ctx.strokeStyle = "rgba(255,255,255, 0.5)"
	ctx.strokeRect pos.left * 10 + 0.5, pos.top * 10 + 0.5, 8, 8
	ctx.fillStyle = "rgba(255,255,255,0.2)"
	ctx.fillRect pos.left * 10 + 0.5, pos.top * 10 + 0.5, 8, 8

eraseBlock = (pos) ->
	ctx.fillStyle = "#27005b"
	ctx.fillRect pos.left * 10, pos.top * 10, 10, 10

popFood = ->
	randPosition = ->
		food.x = Math.floor(Math.random() * 30)
		food.y = Math.floor(Math.random() * 30)
	randPosition()	
	randPosition() while map[food.x][food.y] > 0

	ctx.strokeStyle = "rgba(152,208,0,0.8)"
	ctx.strokeRect food.x * 10 + 0.5, food.y * 10 + 0.5, 8, 8
	ctx.fillStyle = "rgba(152,208,0,0.5)"
	ctx.fillRect food.x * 10 + 0.5, food.y * 10 + 0.5, 8, 8

eatFood = ->
	eraseBlock position
	lifeTime++
	popFood()

tick = ->
	speed = nextSpeed
	position.top += speed.y
	position.left += speed.x

	for y in [0..29]
		for x in [0..29]
			if map[x][y] > 0
				map[x][y]--
				if map[x][y] == 0
					eraseBlock {top: y, left: x}

	eatFood() if position.left == food.x && position.top == food.y

	drawBlock position

	if map[position.left] == undefined || map[position.left][position.top] == undefined || map[position.left][position.top] > 0
		clearInterval(intervalId)
		alert("Perdu!")
	else
		map[position.left][position.top] = lifeTime

$ ->
	canvas = document.getElementById "game"
	ctx = canvas.getContext "2d"

	init()

	intervalId = setInterval tick, 100

	popFood()

	$(document).keydown (event) ->
		switch event.keyCode
			when KEY.LEFT_ARROW then nextSpeed = {x: -1, y: 0} if speed.x != 1; break;
			when KEY.UP_ARROW then nextSpeed = {x: 0, y: -1} if speed.y != 1; break;
			when KEY.RIGHT_ARROW then nextSpeed = {x: 1, y: 0} if speed.x != -1; break;
			when KEY.DOWN_ARROW then nextSpeed = {x: 0, y: 1} if speed.y != -1; break;
