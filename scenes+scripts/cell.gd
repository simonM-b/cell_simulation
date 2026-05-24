extends Sprite2D

func moveN(stepPX=800):
	position.y -= stepPX

func moveS(stepPX=800):
	position.y += stepPX
	
func moveW(stepPX=800):
	position.x -= stepPX

func moveE(stepPX=800):
	position.x += stepPX
