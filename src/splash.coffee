# requestAnimationFrame polyfill
do ->
	w = window
	for vendor in ['ms', 'moz', 'webkit', 'o']
		break if w.requestAnimationFrame
		w.requestAnimationFrame = w["#{vendor}RequestAnimationFrame"]
		w.cancelAnimationFrame = (w["#{vendor}CancelAnimationFrame"] or
								  w["#{vendor}CancelRequestAnimationFrame"])
	if w.requestAnimationFrame
		return if w.cancelAnimationFrame
		browserRaf = w.requestAnimationFrame
		canceled = {}
		w.requestAnimationFrame = (callback) ->
			id = browserRaf (time) ->
				if id of canceled then delete canceled[id]
				else callback time
		w.cancelAnimationFrame = (id) -> canceled[id] = true
	else
		targetTime = 0
		w.requestAnimationFrame = (callback) ->
			targetTime = Math.max targetTime + 16, currentTime = +new Date
			w.setTimeout (-> callback +new Date), targetTime - currentTime
		w.cancelAnimationFrame = (id) -> clearTimeout id

#input classes
class Keyboard
	constructor:->
		@pressed = {}
		@released = {}
		@map =
			8: 'backspace',
			9: 'tab',
			13: 'enter',
			16: 'shift',
			27: 'escape',
			32: 'space',
			37: 'left',
			38: 'up',
			39: 'right',
			40: 'down'
		for k, v of @map
			@pressed[k] = @pressed[v] = @released[k] = @released[v] = false
		for e in ['keyup', 'keydown']
			document.addEventListener(e, @handler, false)
	name: (code)->
		@map[code] or String.fromCharCode code
	handler:(event)=>
		code = event.keyCode
		key = @name code
		@pressed[code] = @pressed[key] = (event.type == 'keydown')
		@released[code] = @released[key] = (event.type == 'keyup')
	clear:->
		@released = {}

class Mouse
	constructor:(@element)->
		@x = @y = @px = @py = 0
		@pressed = {}
		@released = {}
		for b in ['left', 'middle', 'right']
			@pressed[b] = @released[b] = false
		@map =
			0: 'left',
			1: 'middle',
			2: 'right'
		for e in ['mousemove', 'mousedown', 'mouseup', 'contextmenu']
			@element.addEventListener(e, @handler, false)
	name: (code)->
		@map[code]
	handler:(event)=>
		event.preventDefault()
		event.stopPropagation()
		tmpx = @x
		tmpy = @y
		bounds = @element.getBoundingClientRect();
		@x = event.pageX - bounds.left - window.scrollX;
		@y = event.pageY - bounds.top - window.scrollY;
		@px = tmpx || @x
		@py = tmpy || @y
		if event.type in ['mousedown', 'mouseup']
			code = event.button
			key = @name code
			@pressed[code] = @pressed[key] = (event.type == 'mousedown')
			@released[code] = @released[key] = (event.type == 'mouseup')
	clear:->
		@released = {}


class App
	constructor:(@id, @width, @height)->
		@elapsed = 0
		@lastTick = 0
		@running = false
		@worker = null

		@canvas = document.getElementById @id
		if not @canvas
			@canvas = document.createElement 'canvas'
			document.body.appendChild(@canvas)
		@ctx = @canvas.getContext('2d')
		@canvas.setAttribute 'id', @id
		@canvas.width = @width
		@canvas.height = @height

		@mouse = new Mouse(@canvas)
		@keyboard = new Keyboard()

	update:(dt)->
	draw:(dt)->
	run:()->
		if not @running
			@lastTick = Date.now()
			step = =>
				@tick()
				@worker = requestAnimationFrame step
			@worker = requestAnimationFrame step
	stop:()->
		if @worker
			cancelAnimationFrame @worker
		@worker = null
		@running = false
	tick:()=>
		now = Date.now()
		dt = (now - @lastTick) / 1000
		@lastTick = now
		@elapsed += dt
		@update dt
		@draw dt
		@mouse.clear()
		@keyboard.clear()


Splash = @Splash = {}
Splash.VERSION = '0.1'
Splash.App = App