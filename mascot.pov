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

#declare palm_rad = arm_rad*1.2;

#macro hand(twist_angle, spread, fingers)
union {
	sphere {
		<0,0,0>, palm_rad
		scale <.75,1,1>
	}

	// Thumb (==fingers[0])
	object {
		fingers[0]

		rotate x*40
		rotate y*30
		translate <-palm_rad*.1, palm_rad*.4, -palm_rad*.8>
	}

	// Fingers
	#local i = 1;
	#while (i < dimension_size(fingers,1))
		//#local ang = (i-2)*45;
		#local ang = i*180/dimension_size(fingers,1) - 90;
		object {
			fingers[i]
			rotate -x*ang*.75
			translate <0, -palm_rad*.9, 0>
			rotate x*ang
		}
		#local i = i+1;
	#end

	rotate -y*twist_angle
	translate <0, -palm_rad, 0>
	texture { hand_tex }
}
#end

#macro digit(len,rad,joint_pos,base_angle,joint_angle)
union {
	sphere {
		<0,-.5,0>, .65
		scale <rad, len*joint_pos, rad>
	}
	sphere {
		<0,-.5,0>, .6
		scale <rad, len*(1-joint_pos), rad>
		rotate -z*joint_angle
		translate <0, -len*joint_pos, 0>
	}
	rotate -z*base_angle
}
#end

#declare thumb_len = 0.13;
#declare thumb_rad = 0.045;
#declare thumb_joint_pos = 0.6;

#macro thumb(base_angle,joint_angle)
	digit(thumb_len, thumb_rad, thumb_joint_pos, base_angle, joint_angle)
#end

#declare finger_len = 0.1;
//#declare finger_len = 0.00001;
#declare finger_rad = 0.04;
#declare finger_joint_pos = 0.6;	// ratio of finger_len

#macro finger(base_angle,joint_angle)
	digit(finger_len, finger_rad, finger_joint_pos, base_angle, joint_angle)
#end

#declare leg_rad = arm_rad*1.2;
#declare thigh_len = 0.3;
#declare lower_leg_len = thigh_len*1;

#macro leg(fwd_angle, out_angle, knee_angle, foot_angle)
union {
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
			sphere {
				<0,0,0>, leg_rad
				translate <0, 0, -leg_rad*.6>
				scale <1.5, .75, 2.5>
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
#declare eye_y = 0.7;
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
		rotate z*10
		translate left_eye_pos
	}
	object {	// right eye
		eye(right_eye_v_angle, right_eye_h_angle)
		rotate -z*1
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
				hand(left_wrist_twist, 0, left_fingers))

			translate <left_shoulder_x, shoulder_y, 0>
		}
		object {	// right arm
			arm(right_shoulder_raise_angle,
				right_shoulder_fwd_angle,
				right_shoulder_out_angle, right_elbow_angle,
				hand(right_wrist_twist, 0, right_fingers))

			scale <-1,1,1>	// right arm = mirror image of left arm
			translate <right_shoulder_x, shoulder_y, 0>
		}

		texture { limb_tex }
	}

	// Legs
	#local hip_y = 0;
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
