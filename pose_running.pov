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
#declare left_wrist_twist = 0;

#declare right_shoulder_raise_angle = 40;
#declare right_shoulder_fwd_angle = -110;
#declare right_shoulder_out_angle = -10;
#declare right_elbow_angle = 70;
#declare right_wrist_twist = 0;

#declare curled_thumb = object { thumb(40,90) }
#declare curled_finger = object { finger(90,90) }

#declare left_fingers = array[4] {
	curled_thumb, curled_finger, curled_finger, curled_finger
};

#declare right_fingers = array[4] {
	curled_thumb, curled_finger, curled_finger, curled_finger
};

#declare left_thigh_fwd_angle = 80;
#declare left_thigh_out_angle = 10;
#declare left_knee_angle = 20;
#declare left_foot_angle = 20;

#declare right_thigh_fwd_angle = -80;
#declare right_thigh_out_angle = -10;
#declare right_knee_angle = 40;
#declare right_foot_angle = 20;

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
