# create canvas
canvas = document.createElement 'canvas'
ctx = canvas.getContext("2d")

# setting canvas width/heigth
canvas.width = document.width
canvas.height = document.height


# adding canvas to the document
document.body.appendChild canvas

#filling width black color
ctx.fillStyle = '#000';
ctx.fillRect(0, 0, canvas.width, canvas.height)

#mouse object
mouse =
    pX: 0,
    pY: 0,
    x: 0,
    y: 0,
    down: false

#mouse events
canvas.addEventListener('mousemove', (event)->
    mouse.pX = mouse.x || event.clientX
    mouse.pY = mouse.y || event.clientY
    mouse.x = event.clientX;
    mouse.y = event.clientY;
)

canvas.addEventListener('mousedown', (event)->
    mouse.down = true
)

canvas.addEventListener('mouseup', (event)->
    mouse.down = false
)

# config object
config =
    strokeStyle: "#fff"
    firstFillStyle: "#fff"
    secondFillStyle: "#000"
    radius: 64
    save: ()->
        Canvas2Image.saveAsPNG(canvas)

# config gui
gui = new dat.GUI()
category = gui.addFolder('Config')
category.addColor(config, 'strokeStyle')
category.addColor(config, 'firstFillStyle')
category.addColor(config, 'secondFillStyle')
category.open()
gui.add(config, 'save')


# app loop
lastUpdate = Date.now()
fps = 60

run = ()->
    now = Date.now()
    dt = now - lastUpdate
    if dt >= (1000 / fps)
        lastUpdate = now - dt % (1000 / fps)
        render()
    requestAnimationFrame(run)


#draw func
render = ()->
    radius = Math.abs( mouse.x - mouse.pX ) + Math.abs( mouse.y - mouse.pY)

    ctx.beginPath();
    ctx.arc(mouse.x || canvas.width/2 , mouse.y || canvas.height/2 , radius * 1.4, 0, 2 * Math.PI, false)
    ctx.fillStyle = config.secondFillStyle
    ctx.fill()
    ctx.strokeStyle = config.strokeStyle
    ctx.stroke()
    ctx.closePath()

    ctx.beginPath();
    ctx.arc(mouse.x || canvas.width/2 , mouse.y || canvas.height/2 , radius, 0, 2 * Math.PI, false)
    ctx.fillStyle = config.firstFillStyle
    ctx.fill()
    ctx.closePath()

do run
