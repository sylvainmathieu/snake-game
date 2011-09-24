
intervalId = null
map = (0 for y in [0..30] for x in [0..30])

lifeTime = 10

KEY =
	LEFT_ARROW: 37
	UP_ARROW: 38
	RIGHT_ARROW: 39
	DOWN_ARROW: 40

speed =
	x: 1
	y: 0

position =
	top: 15
	left: 15

init = (ctx) ->
	ctx.fillStyle = "#27005b"
	ctx.fillRect 0, 0, 300, 300

drawBlock = (ctx, pos) ->
	ctx.strokeStyle = "#ffffff"
	ctx.strokeRect pos.top * 10 + 1, pos.left * 10 + 1, 8, 8
	ctx.fillStyle = "rgba(255,255,255,0.2)"
	ctx.fillRect pos.top * 10 + 1, pos.left * 10 + 1, 8, 8

eraseBlock = (ctx, pos) ->
	ctx.fillStyle = "#27005b"
	ctx.fillRect pos.top * 10, pos.left * 10, 10, 10

tick = (ctx) ->

	position.top += speed.x
	position.left += speed.y

	for y in [0..30]
		for x in [0..30]
			if map[x][y] > 0
				map[x][y]--
				if map[x][y] == 0
					eraseBlock ctx, {top: y, left: x}

	drawBlock ctx, position

	if map[position.left] == undefined || map[position.left][position.top] == undefined || map[position.left][position.top] > 0
		clearInterval(intervalId)
		alert("Perdu!")
	else
		map[position.left][position.top] = lifeTime

$ ->
	canvas = document.getElementById "game"
	ctx = canvas.getContext "2d"

	init ctx

	intervalId = setInterval tick, 100, ctx

	$(document).keydown (event) ->
		switch event.keyCode
			when KEY.LEFT_ARROW then speed = {x: -1, y: 0} if speed.x != 1; break;
			when KEY.UP_ARROW then speed = {x: 0, y: -1} if speed.y != 1; break;
			when KEY.RIGHT_ARROW then speed = {x: 1, y: 0} if speed.x != -1; break;
			when KEY.DOWN_ARROW then speed = {x: 0, y: 1} if speed.y != -1; break;
