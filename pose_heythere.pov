// D mascot "hey, there!" pose
#include "colors.inc"
#include "mascot.pov"
#include "defscene.pov"

// Setup the pose
#declare left_eye_v_angle = -10;
#declare left_eye_h_angle = -10;
#declare left_eye_tilt = transform { rotate z*10 };

#declare right_eye_v_angle = -10;
#declare right_eye_h_angle = -10;
#declare right_eye_tilt = transform { rotate -z*1 };

#declare left_shoulder_raise_angle = 80;
#declare left_shoulder_fwd_angle = 0;
#declare left_shoulder_out_angle = 60;
#declare left_elbow_angle = 70;
#declare left_wrist_angle = 0;
#declare left_wrist_twist = 30;

#declare left_fingers = make_fingers(
	array[5][2] {
		{ 0, 20 }	// thumb
		{ 20, 20 }	// index finger
		{ 20, 20 }	// middle finger
		{ 20, 20 }	// ring finger
		{ 20, 20 }	// little finger
	}
);

#declare right_shoulder_raise_angle = 50;
#declare right_shoulder_fwd_angle = -10;
#declare right_shoulder_out_angle = -30;
#declare right_elbow_angle = 80;
#declare right_wrist_angle = -30;
#declare right_wrist_twist = 45;

#declare right_fingers = make_fingers(
	array[5][2] {
		{ 0, 70 }	// thumb
		{ 40, 70 }	// index finger
		{ 40, 70 }	// middle finger
		{ 40, 70 }	// ring finger
		{ 40, 70 }	// little finger
	}
);

#declare left_thigh_fwd_angle = 30;
#declare left_thigh_out_angle = 30;
#declare left_knee_angle = 40;
#declare left_foot_angle = 0;

#declare right_thigh_fwd_angle = 20;
#declare right_thigh_out_angle = 20;
#declare right_knee_angle = 15;
#declare right_foot_angle = 0;

// Generate the model
gen_mascot()

camera {
	location <-.4, .5, -2>	// final view
	look_at <0, 0, 0>
	right x*3/3
}
