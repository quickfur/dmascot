#include "colors.inc"
#include "mascot.pov"
#include "defscene.pov"

#declare left_fingers = make_fingers(
	array[5][2] {
	/*
		{ 0, 20 }	// thumb
		{ 20, 20 }	// index finger
		{ 20, 20 }	// middle finger
		{ 20, 20 }	// ring finger
		{ 20, 20 }	// little finger
	*/
	/*
		{ 0, 90 }	// thumb
		{ 90, 80 }	// index finger
		{ 90, 80 }	// middle finger
		{ 90, 80 }	// ring finger
		{ 90, 80 }	// little finger
	*/
		{ 0, 80 }	// thumb
		{ 0, 0 }	// index finger
		{ 0, 0 }	// middle finger
		{ 80, 90 }	// ring finger
		{ 80, 80 }	// little finger
	}
);

object {
	hand(0, 0, 0, left_fingers)
	rotate y*90
	rotate z*180
	translate <-.12, 0, 0>
}

object {
	hand(0, 0, 0, left_fingers)
	rotate y*-90
	rotate z*180
	translate <.12, 0, 0>
}

camera {
	location <0.1, 0.1, -.45>	// final view
	look_at <0, 0.1, 0>
	right x*3/3
}
