// D mascot dancing pose
#include "colors.inc"
#include "mascot.pov"
#include "defscene.pov"

// Setup the pose
#declare left_eye_v_angle = 10;
#declare left_eye_h_angle = 0;
#declare left_eye_tilt = transform { rotate z*10 };

#declare right_eye_v_angle = 10;
#declare right_eye_h_angle = 0;
#declare right_eye_tilt = transform { rotate z*5 };

#declare left_shoulder_raise_angle = 145;
#declare left_shoulder_fwd_angle = 0;
#declare left_shoulder_out_angle = 90;
#declare left_elbow_angle = 50;
#declare left_wrist_angle = 0;
#declare left_wrist_twist = 30;

#declare left_fingers = make_fingers(
	array[5][2] {
		{ 0, 80 }	// thumb
		{ 0, 0 }	// index finger
		{ 0, 0 }	// middle finger
		{ 80, 90 }	// ring finger
		{ 80, 80 }	// little finger
	}
);

#declare right_shoulder_raise_angle = 30;
#declare right_shoulder_fwd_angle = 0;
#declare right_shoulder_out_angle = 90;
#declare right_elbow_angle = 140;
#declare right_wrist_angle = -30;
#declare right_wrist_twist = 45;

#declare right_fingers = make_fingers(
	array[5][2] {
		{ 0, 90 }	// thumb
		{ 90, 80 }	// index finger
		{ 90, 80 }	// middle finger
		{ 90, 80 }	// ring finger
		{ 90, 80 }	// little finger
	}
);

#declare left_thigh_fwd_angle = 85;
#declare left_thigh_out_angle = 60;
#declare left_knee_angle = 120;
#declare left_foot_angle = 10;

#declare right_thigh_fwd_angle = 10;
#declare right_thigh_out_angle = 50;
#declare right_knee_angle = 30;
#declare right_foot_angle = 40;

// Generate the model
object {
	gen_mascot()
	rotate z*5
}

camera {
	location <-.4, .5, -2>	// final view
	look_at <0, 0, 0>
	right x*3/3
}
