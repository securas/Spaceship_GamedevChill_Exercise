extends Polygon2D

#var curve : Curve2D
#
#var start_point : Vector2
#var start_point_out : Vector2


func _ready():
	randomize()
	update_polygon()

func update_polygon():
	var npoints := 11
	var screen_width = 320
	var point_hspacing = float( 320 ) / ( npoints - 1 )
	var points = []
	var ystart = -20.0
	points.append( Vector2( 0, -20.0 ) )
	for idx in range( 1, npoints - 1 ):
		var nxt_point = Vector2( idx * point_hspacing, ystart - ( ( randi() % 20 ) - 10 ) )
		if idx > 0 and idx < ( npoints - 1 ):
			nxt_point.x += ( randi() % 20 ) - 10
		if nxt_point.y > -5: nxt_point.y = -5
		elif nxt_point.y < -50: nxt_point.y = -50
		ystart = nxt_point.y
		points.append( nxt_point )
	points.append( Vector2( screen_width, -20.0 ) )
	#print( points )
	var new_polygon = PoolVector2Array()
	new_polygon.append( Vector2.ZERO )
	for p in points:
		new_polygon.append( p )
	new_polygon.append( Vector2( points[-1].x, 0 ) )
	polygon = new_polygon
	
	$KinematicBody2D/CollisionPolygon2D.polygon = new_polygon
