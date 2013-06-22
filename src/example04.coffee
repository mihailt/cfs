#application
randomInteger = (min, max=0) ->
	Math.floor(Math.random() * (max + 1 - min)) + min
clamp = (val, min, max) ->
	if max < min
		[max, min] = [min, max]
	Math.max(min, Math.min(val, max))


colors = [
	'#1abc9c',
	'#2ecc71',
	'#3498db',
	'#9b59b6',
	'#34495e',
	'#f1c40f',
	'#d35400',
	'#e74c3c',
	'#7f8c8d'
]

class Loader
	constructor:(@x, @y, @width, @height, loaded)->
		@color = colors[randomInteger 0, colors.length - 1]
		@setLoaded loaded
	setLoaded:(loaded)->
		@loaded = clamp(loaded, 0, 100)
	draw:(ctx)->
		ctx.fillStyle = @color
		ctx.fillRect(@x, @y, (@width/100) * @loaded, @height)

class SampleApp extends Splash.App
	constructor:()->
		super
		@loaded = 0
		@loader = new Loader(@width/4, @height/2, @width/2, 4, @loaded)
	update:(dt)->
		@loaded += 0.5
		if @loaded > 100
			@loaded = 0
		@loader.setLoaded @loaded
	draw:()->
		@ctx.clearRect 0, 0, @width, @height
		@loader.draw @ctx


#app init
app = new SampleApp 'canvas', 800, 600

window.onblur = -> app.stop()
window.onfocus = -> app.run()

app.run()