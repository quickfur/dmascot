// D mascot running pose
#include "colors.inc"
#include "mascot.pov"
#include "defscene.pov"

// Setup the pose
#declare left_eye_v_angle = -40;
#declare left_eye_h_angle = 0;
#declare left_eye_tilt = transform { rotate x*30 };

#declare right_eye_v_angle = -40;
#declare right_eye_h_angle = 0;
#declare right_eye_tilt = transform { rotate x*30 };

#declare left_shoulder_raise_angle = 30;
#declare left_shoulder_fwd_angle = 80;
#declare left_shoulder_out_angle = 20;
#declare left_elbow_angle = 110;
#declare left_wrist_angle = -30;
#declare left_wrist_twist = 0;

#declare left_fingers = make_fingers(
	array[5][2] {
		{ 0, 80 }	// thumb
		{ 70, 80 }	// index finger
		{ 70, 80 }	// middle finger
		{ 70, 80 }	// ring finger
		{ 70, 80 }	// little finger
	}
);

#declare right_shoulder_raise_angle = 40;
#declare right_shoulder_fwd_angle = -110;
#declare right_shoulder_out_angle = -10;
#declare right_elbow_angle = 70;
#declare right_wrist_angle = -30;
#declare right_wrist_twist = 0;

#declare right_fingers = make_fingers(
	array[5][2] {
		{ 0, 80 }	// thumb
		{ 70, 80 }	// index finger
		{ 70, 80 }	// middle finger
		{ 70, 80 }	// ring finger
		{ 70, 80 }	// little finger
	}
);


#declare left_thigh_fwd_angle = 80;
#declare left_thigh_out_angle = 10;
#declare left_knee_angle = 20;
#declare left_foot_angle = 20;

#declare right_thigh_fwd_angle = -80;
#declare right_thigh_out_angle = -10;
#declare right_knee_angle = 40;
#declare right_foot_angle = 30;

// Generate the model
object {
	gen_mascot()
	rotate x*20
}

camera {
	location <-1.5, .5, -1.25>	// side view
	look_at <0, 0, 0>
	right x*3/3
}
