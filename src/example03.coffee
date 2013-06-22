#application
class SampleApp extends Splash.App
	constructor:()->
		super
		@x = @width / 2
		@y = @height / 2
		@speed = 100
		@color = '#FFA318'
	update:(dt)->
		if @keyboard.pressed.left
			@x -= @speed * dt
		if @keyboard.pressed.right
			@x += @speed * dt
		if @keyboard.pressed.up
			@y -= @speed * dt
		if @keyboard.pressed.down
			@y += @speed * dt
	draw:()->
		@ctx.clearRect 0, 0, @width, @height
		@ctx.beginPath()
		@ctx.arc @x, @y, 40 + Math.sin(@elapsed) * 30, 0, 2 * Math.PI, true
		@ctx.closePath()
		@ctx.fillStyle = @color
		@ctx.fill()

#app init
app = new SampleApp 'canvas', 800, 600

window.onblur = -> app.stop()
window.onfocus = -> app.run()

app.run()