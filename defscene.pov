// Setup light and camera
light_source { <100,400,-800> White }
background { White*0.3 }
camera {
	location <-.4, .5, -2>	// final view
	//location <-.3, .3, -1.5>
	//location <0, .3, -1>		// front view, near
	//location <-2, .5, -.4>	// right side view
	look_at <0, -.1, 0>

	//location <0, .4, -.5>
	//look_at <0, .4, 0>

	right x*3/3
}
