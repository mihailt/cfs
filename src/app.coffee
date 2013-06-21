#application
class SampleApp extends Splash.App
	constructor:()->
		super

		@x = @width/2
		@y = @height/2
		@speed = 10
	update:(dt)->
		@radius = Math.abs( @mouse.x - @mouse.px ) + Math.abs( @mouse.y - @mouse.py )
	draw:()->
	    @ctx.beginPath();
	    @ctx.arc(@mouse.x || @width/2 , @mouse.y || @height/2 , @radius * 1.4, 0, 2 * Math.PI, false)
	    @ctx.fillStyle = '#000'
	    @ctx.fill()
	    @ctx.strokeStyle = '#fff'
	    @ctx.stroke()
	    @ctx.closePath()

	    @ctx.beginPath();
	    @ctx.arc(@mouse.x || @width/2 , @mouse.y || @height/2 , @radius, 0, 2 * Math.PI, false)
	    @ctx.fillStyle = '#fff'
	    @ctx.fill()
	    @ctx.closePath()

#app init
app = new SampleApp 'canvas', document.width, document.height
app.run()
