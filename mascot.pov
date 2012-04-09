/*
 * Prospective mascot for D
 */

#include "colors.inc"

#declare amb = 0.5;
#declare metalfin = finish {
	diffuse 0.1
	ambient 0.4
	specular 1
	metallic
	roughness 0.1
};

#declare limb_tex = texture {
	pigment { White*.07 }
	finish {
		diffuse .7
		specular .1
		roughness 1.0
	}
}

#declare hand_tex = texture {
	pigment { White }
	finish { diffuse 0.5 ambient amb }
}

#declare foot_tex = hand_tex;

#declare waist = -.3;
#declare body_thickness = .2;
#declare body_width = 0.7;

#declare arm_rad = 0.05;
#declare upper_arm_len = 0.3;
#declare forearm_len = 0.25;
#declare wrist_width = arm_rad * 1.5;
#declare wrist_thickness = arm_rad;

#macro arm(raise_angle, fwd_angle, out_angle, elbow_angle, hand)
union {
	sphere {	// shoulder
		<0,0,0>, arm_rad
	}

	union {		// arm
		cylinder {	// upper arm
			<0, -upper_arm_len, 0>, <0,0,0>, arm_rad
		}

		union {		// lower arm
			sphere {	// elbow
				<0,0,0>, arm_rad
			}

			union {
				cylinder {	// forearm
					<0, -forearm_len+arm_rad/2, 0>, <0,0,0>,
					arm_rad
				}

				sphere {	// wrist
					<0, -forearm_len+arm_rad/2, 0>, arm_rad
				}

				// Hand
				object {
					hand
					translate <0, -forearm_len, 0>
				}

				rotate x*elbow_angle
			}
			translate <0, -upper_arm_len, 0>
		}
		rotate -y*out_angle
		rotate x*fwd_angle
		rotate z*raise_angle
	}
}
#end

//#declare palm_thickness = arm_rad*.6;
#declare palm_thickness = 0.02;
#declare palm_rad = arm_rad*1.2 - palm_thickness;

#macro hand(wrist_angle, twist_angle, spread, fingers)
union {
	// Palm
	torus {
		palm_rad, palm_thickness
		rotate z*90
	}
	cylinder {
		<-palm_thickness, 0, 0>, <palm_thickness, 0, 0>, palm_rad
	}

	// Thumb (==fingers[0])
	object {
		fingers[0]

		rotate y*20
		rotate x*50
		rotate y*20
		translate <0, palm_rad*.5, -palm_rad*.85>
	}

	// Fingers
	#local i = 1;
	#while (i < dimension_size(fingers,1))
		//#local ang = (i-2)*45;
		#local ang = 90 - i*200/dimension_size(fingers,1);
		object {
			fingers[i]
			rotate -x*ang*.8
			translate <0, -palm_rad, 0>
			rotate x*ang
			translate <0, -palm_thickness/2, 0>
		}
		#local i = i+1;
	#end

	rotate -z*wrist_angle
	rotate -y*twist_angle
	translate <0, -palm_rad, 0>
	texture { hand_tex }
}
#end

#macro digit(len,rad,joint_pos,base_angle,joint_angle)
union {
	#local joint2_ratio = .67;
	#local joint_pos2 = joint2_ratio * (1-joint_pos);
	#local len1 = len*joint_pos;
	#local len2 = len*joint_pos2;
	#local len3 = len*(1-joint_pos2-joint_pos);

	#local tip_rad_ratio = .85;
	#local tip_rad = rad*tip_rad_ratio;
	#local rad2 = rad + joint_pos*(tip_rad - rad);
	#local rad3 = rad + (joint_pos+joint_pos2)*(tip_rad - rad);

	#if (0) // DEBUG ONLY
	cylinder {
		<0,0,0>, <0,-len,0>, rad/2
		pigment { Black }
	}
	#end

	sphere {	// base joint
		<0,0,0>, rad
	}
	cone {	// first segment
		<0,0,0>, rad,
		<0, -len1, 0>, rad2
	}
	union {
		sphere {	// first joint
			<0,0,0>, rad2
		}
		cone {		// second segment
			<0,0,0>, rad2
			<0, -len2, 0>, rad3
		}
		sphere {	// second joint
			<0, -len2, 0>, rad3
		}
		union {		// fingertip
			cone {
				<0,0,0>, rad3
				<0, -len3, 0>, tip_rad
			}
			sphere {
				<0, -len3, 0>, tip_rad
			}
			rotate -z*joint_angle
			translate <0, -len2, 0>
		}

		rotate -z*joint_angle
		translate <0, -len1, 0>
	}
	translate <palm_thickness - rad, 0, 0>
	rotate -z*base_angle
}
#end

#declare thumb_len = 0.09;
#declare thumb_rad = 0.02;
#declare thumb_joint_pos = 0.4;

#macro thumb(base_angle,joint_angle)
	digit(thumb_len, thumb_rad, thumb_joint_pos, base_angle, joint_angle)
#end

#declare finger_len = 0.11;
#declare finger_rad = 0.018;
#declare finger_joint_pos = 0.5;	// ratio of finger_len

// base_angles = array[5] base angles
// joint_angles = array[5] joint angles
//#macro make_fingers(base_angles, joint_angles)
// angles = array[5][2] of base/joint angles for each finger
#macro make_fingers(angles)
	#local fingers = array[5];
	#local fingers[0] = thumb(angles[0][0], angles[0][1])
	#local fingers[1] = object {
		digit(finger_len*1, finger_rad*1, finger_joint_pos,
			angles[1][0], angles[1][1])
	}
	#local fingers[2] = object {
		digit(finger_len*1, finger_rad*1, finger_joint_pos,
			angles[2][0], angles[2][1])
	}
	#local fingers[3] = object {
		digit(finger_len*.93, finger_rad*.93, finger_joint_pos,
			angles[3][0], angles[3][1])
	}
	#local fingers[4] = object {
		digit(finger_len*.85, finger_rad*.85, finger_joint_pos,
			angles[4][0], angles[4][1])
	}
	fingers
#end

#declare leg_rad = arm_rad*1.2;
#declare thigh_len = 0.3;
#declare lower_leg_len = thigh_len*1;

#macro leg(fwd_angle, out_angle, knee_angle, foot_angle)
union {
	sphere {	// hip joint
		<0,0,0>, leg_rad
	}

	cylinder {	// thigh
		<0,0,0>, <0, -thigh_len, 0>, leg_rad
	}

	union {	
		sphere {	// knee
			<0,0,0>, leg_rad
		}
		cylinder {	// lower leg
			<0,0,0>, <0, -lower_leg_len, 0>, leg_rad
		}
		union {	// foot
			difference {
				sphere {
					<0,0,0>, leg_rad
				}
				box {
					-1.1*<leg_rad,leg_rad,leg_rad>,
					1.1*<leg_rad,-leg_rad/4,leg_rad>
				}
				translate <0, 0, -leg_rad>
				scale <1.5, 1.3, 2.2>
				rotate -x*foot_angle
				translate <0, 0, leg_rad>
			}
			texture { foot_tex }
			translate <0, -lower_leg_len, 0>
		}
		rotate -x*knee_angle
		translate <0, -thigh_len, 0>
	}

	rotate x*fwd_angle
	rotate -y*out_angle
}
#end

//#declare eye_y = 0.68;
#declare eye_y = 0.71;
#declare left_eye_pos = <.65*body_width, eye_y, 0>;
#declare right_eye_pos = <.35*body_width, eye_y, 0>;
#declare eye_h = 0.25;
#declare eye_w = eye_h * .5;

#macro eye(v_angle, h_angle)
sphere {
	<0,1,0>/2, 1/2
	pigment {
		gradient -z
		color_map {
			[0.0 Black]
			[0.5 Black]
			[0.5 White]
			[1.0 White]
		}
		scale <1,1,1000>
		translate <0, 0, -.9>/2
	}
	finish {
		ambient amb
		phong .9
	}
	rotate x*v_angle
	rotate y*h_angle
	scale <eye_w, eye_h, eye_w>
}
#end

/*
 * The actual mascot model
 */
#macro gen_mascot()
union {
	// Eyes
	object {	// left eye
		eye(left_eye_v_angle, left_eye_h_angle)
		transform { left_eye_tilt }
		translate left_eye_pos
	}
	object {	// right eye
		eye(right_eye_v_angle, right_eye_h_angle)
		transform { right_eye_tilt }
		translate right_eye_pos
	}

	// Body (bo-D ?)
	text {
		ttf "timrom.ttf" "D" body_thickness 0
		pigment { Red }
		finish { metalfin }
		translate <0, 0, -body_thickness/2>
	}

	// Arms
	#local shoulder_y = 0.5;
	#local left_shoulder_x = body_width - 0.01;
	#local right_shoulder_x = 0.07;
	union {
		object {	// left arm
			arm(left_shoulder_raise_angle, left_shoulder_fwd_angle,
				left_shoulder_out_angle, left_elbow_angle,
				hand(left_wrist_angle, left_wrist_twist, 0,
					left_fingers))

			translate <left_shoulder_x, shoulder_y, 0>
		}
		object {	// right arm
			arm(right_shoulder_raise_angle,
				right_shoulder_fwd_angle,
				right_shoulder_out_angle, right_elbow_angle,
				hand(right_wrist_angle, right_wrist_twist, 0,
					right_fingers))

			scale <-1,1,1>	// right arm = mirror image of left arm
			translate <right_shoulder_x, shoulder_y, 0>
		}

		texture { limb_tex }
	}

	// Legs
	#local hip_y = -leg_rad/2;
	#local left_leg_pos = <.65*body_width, hip_y, 0>;
	#local right_leg_pos = <.35*body_width, hip_y, 0>;
	union {
		object {	// left leg
			leg(left_thigh_fwd_angle, left_thigh_out_angle,
				left_knee_angle, left_foot_angle)

			translate left_leg_pos
		}

		object {	// right leg
			leg(right_thigh_fwd_angle, right_thigh_out_angle,
				right_knee_angle, right_foot_angle)

			scale <-1,1,1>	// right leg = mirror image of left leg
			translate right_leg_pos
		}
		texture { limb_tex }
	}

	translate <-body_width/2, waist, 0>
}
#end
