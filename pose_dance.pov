// D mascot dancing pose
#include "colors.inc"
#include "mascot.pov"
#include "defscene.pov"

// Setup the pose
#declare left_eye_v_angle = 10;
#declare left_eye_h_angle = 0;

#declare right_eye_v_angle = 10;
#declare right_eye_h_angle = 0;

#declare left_shoulder_raise_angle = 145;
#declare left_shoulder_fwd_angle = 0;
#declare left_shoulder_out_angle = 90;
#declare left_elbow_angle = 50;
#declare left_wrist_twist = 30;

#declare right_shoulder_raise_angle = 30;
#declare right_shoulder_fwd_angle = 0;
#declare right_shoulder_out_angle = 90;
#declare right_elbow_angle = 140;
#declare right_wrist_twist = 45;

#declare straight_finger = object { finger(0,0) }
#declare curled_finger = object { finger(80,90) }

#declare left_thumb = object { thumb(20,80) }
#declare left_fingers = array[4] {
	left_thumb, straight_finger, straight_finger, curled_finger
};

#declare right_thumb = object { thumb(20,80) }
#declare right_finger = object { finger(40,90) }
#declare right_fingers = array[4] {
	right_thumb, right_finger, right_finger, right_finger
};

#declare left_thigh_fwd_angle = 85;
#declare left_thigh_out_angle = 60;
#declare left_knee_angle = 120;
#declare left_foot_angle = 10;

#declare right_thigh_fwd_angle = 10;
#declare right_thigh_out_angle = 50;
#declare right_knee_angle = 30;
#declare right_foot_angle = 20;

// Generate the model
gen_mascot()
