
intervalId = null
map = (1 for i in [0..300] for j in [0..300])

KEY =
	LEFT_ARROW: 37
	UP_ARROW: 38
	RIGHT_ARROW: 39
	DOWN_ARROW: 40

speed =
	x: 1
	y: 0

position =
	top: 150
	left: 150

initMap = (ctx) ->
	ctx.fillStyle = "rgb(128,0,0)"
	ctx.fillRect 0, 0, 300, 300
	ctx.fillStyle = "rgb(255,200,200)"
	ctx.fillRect 5, 5, 290, 290

tick = (ctx) ->
	position.top += speed.x
	position.left += speed.y

	ctx.fillRect position.top, position.left, 2, 2

	if !map[position.top] || !map[position.top][position.left]
		clearInterval(intervalId)
		alert("Perdu!")
	else
		map[position.top][position.left] = 0

$ ->
	canvas = document.getElementById "game"
	ctx = canvas.getContext "2d"

	initMap ctx

	ctx.fillStyle = "rgb(0,0,0)"
	intervalId = setInterval tick, 10, ctx

	$(document).keydown (event) ->
		switch event.keyCode
			when KEY.LEFT_ARROW then speed = {x: -1, y: 0}
			when KEY.UP_ARROW then speed = {x: 0, y: -1}
			when KEY.RIGHT_ARROW then speed = {x: 1, y: 0}
			when KEY.DOWN_ARROW then speed = {x: 0, y: 1}
