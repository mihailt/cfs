class Particle
	constructor:(@x, @y, @vx, @vy)->
		@scale = 1.0
		@radius = 20
		@color = '#ff0000'
		@scaleSpeed = 0.2
	update:(dt)->
		@scale -= @scaleSpeed * dt
		if @scale <= 0
			@scale = 0
		@x += @vx * dt
		@y += @vy * dt

	draw:(ctx)->
		ctx.beginPath()
		ctx.arc @x, @y, @radius * @scale, 0, 2 * Math.PI, true
		ctx.closePath()
		ctx.fillStyle = @color
		ctx.fill()
		ctx.strokeStyle = '#fff'
		ctx.stroke()
		ctx.restore()

#application
class SampleApp extends Splash.App
	constructor:()->
		super
		@particles = []
		@paused = false

	update:(dt)->
		if @keyboard.released.P
			@paused = !@paused
		if @mouse.down.left
			speed = 10
			for angle in [0...360] by  Math.round(360/10)
				vx = speed * Math.cos( angle * Math.PI / 180 )
				vy = speed * Math.sin( angle * Math.PI / 180 )
				particle = new Particle @mouse.x, @mouse.y, vx, vy
				@particles.push particle
		if @paused
			return
		for p in @particles
			p.update(dt)
		@particles = @particles.filter (p) -> p.scale > 0

	draw:()->
		@ctx.clearRect 0, 0, @width, @height
		for p in @particles
			p.draw(@ctx)

#app init
app = new SampleApp 'canvas', 800, 600
app.run()