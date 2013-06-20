#config
config =
    strokeStyle: "#fff"
    firstFillStyle: "#fff"
    secondFillStyle: "#000"

gui = new dat.GUI()
category = gui.addFolder('Config')
category.addColor(config, 'strokeStyle')
category.addColor(config, 'firstFillStyle')
category.addColor(config, 'secondFillStyle')
category.open()

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
	    @ctx.fillStyle = config.secondFillStyle
	    @ctx.fill()
	    @ctx.strokeStyle = config.strokeStyle
	    @ctx.stroke()
	    @ctx.closePath()

	    @ctx.beginPath();
	    @ctx.arc(@mouse.x || @width/2 , @mouse.y || @height/2 , @radius, 0, 2 * Math.PI, false)
	    @ctx.fillStyle = config.firstFillStyle
	    @ctx.fill()
	    @ctx.closePath()

#app init
app = new SampleApp 'canvas', document.width, document.height
app.run()
