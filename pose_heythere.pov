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
#declare left_wrist_twist = 30;

#declare right_shoulder_raise_angle = 50;
#declare right_shoulder_fwd_angle = -10;
#declare right_shoulder_out_angle = -30;
#declare right_elbow_angle = 80;
#declare right_wrist_twist = 45;

#declare left_thumb = object { thumb(0,20) }
#declare left_fing = object { finger(20,20) }
#declare left_fingers = array[4] {
	left_thumb, left_fing, left_fing, left_fing
};

#declare right_thumb = object { thumb(0,70) }
#declare right_fing = object { finger(45,80) }
#declare right_fingers = array[4] {
	right_thumb, right_fing, right_fing, right_fing
};

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
