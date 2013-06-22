randomFloat = (min, max)->
	return min + Math.random()*(max-min)

class ParticleSystem
	constructor:()->
		@particles = []
	create: (x, y, color)->
		for angle in [0...360] by  Math.round(360/10)
			speed = randomFloat 60.0, 200.0
			vx = speed * Math.cos( angle * Math.PI / 180 )
			vy = speed * Math.sin( angle * Math.PI / 180 )
			particle = new Particle x, y, vx, vy, color
			@particles.push particle
	update:(dt)->
		for p in @particles
			p.update(dt)
		@particles = @particles.filter (p) -> p.scale > 0
	draw:(ctx)->
		for p in @particles
			p.draw(ctx)

class Particle
	constructor:(@x, @y, @vx, @vy, @color)->
		minSize = 10
		maxSize = 30
		minScaleSpeed = 1.0
		maxScaleSpeed = 4.0

		@scale = 1.0
		@radius = randomFloat minSize, maxSize
		@scaleSpeed = randomFloat minScaleSpeed, maxScaleSpeed
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

#application
class SampleApp extends Splash.App
	constructor:()->
		super
		@particleSystem = new ParticleSystem
	update:(dt)->
		if @mouse.pressed.left
				@particleSystem.create @mouse.x, @mouse.y, "#FFA318"
				@particleSystem.create @mouse.x, @mouse.y, "#525252"
		@particleSystem.update dt
	draw:()->
		@ctx.clearRect 0, 0, @width, @height
		@particleSystem.draw @ctx

#app init
app = new SampleApp 'canvas', 800, 600

window.onblur = -> app.stop()
window.onfocus = -> app.run()

app.run()