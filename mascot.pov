/*
 * Prospective mascot for D?
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

#declare H = 0.75;
#declare W = 0.75;
#declare waist = -.3;
#declare body_thickness = .2;
#declare body_width = 0.7;

#local arm_rad = 0.05;
#local upper_arm_len = 0.25;
#local forearm_len = 0.25;
#local wrist_width = arm_rad * 1.5;
#local wrist_thickness = arm_rad;

#macro arm(raise_angle, fwd_angle, out_angle, elbow_angle)
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
				cylinder {
					<0, -forearm_len, 0>, <0,0,0>, arm_rad
				}

				// Hand
				sphere {
					// TEMPORARY
					<0,0,0>, arm_rad*2
					texture { hand_tex }
					scale <1,1,.65>
					translate <0, -forearm_len, 0>
				}

				rotate x*elbow_angle
			}
			translate <0, -upper_arm_len, 0>
		}
		rotate y*shoulder_out_angle
		rotate x*shoulder_fwd_angle
		rotate z*shoulder_raise_angle
	}
}
#end

#local leg_rad = arm_rad*1.2;
#local thigh_len = 0.3;
#local lower_leg_len = thigh_len*1;

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
				scale <1.5, .5, 3>
				translate <0, 0, -leg_rad*1>
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

union {
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
			#local shoulder_raise_angle = 30;
			#local shoulder_fwd_angle = 20;
			#local shoulder_out_angle = 10;
			#local elbow_angle = 50;

			arm(shoulder_raise_angle, shoulder_fwd_angle,
				shoulder_out_angle, elbow_angle)

			translate <left_shoulder_x, shoulder_y, 0>
		}
		object {	// right arm
			#local shoulder_raise_angle = 50;
			#local shoulder_fwd_angle = 20;
			#local shoulder_out_angle = 10;
			#local elbow_angle = 20;

			arm(shoulder_raise_angle, shoulder_fwd_angle,
				shoulder_out_angle, elbow_angle)

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
			#local fwd_angle = 30;
			#local out_angle = 10;
			#local knee_angle = 40;
			#local foot_angle = 0;
			leg(fwd_angle, out_angle, knee_angle, foot_angle)

			translate left_leg_pos
		}

		object {	// right leg
			#local fwd_angle = 20;
			#local out_angle = 15;
			#local knee_angle = 10;
			#local foot_angle = 0;
			leg(fwd_angle, out_angle, knee_angle, foot_angle)

			scale <-1,1,1>	// right leg = mirror image of left leg
			translate right_leg_pos
		}
		texture { limb_tex }
	}

	translate <-body_width/2, waist, 0>
}

#local ruler = 0;
#if (ruler)
	union {
		cylinder {
			<0,0,0>, <0,H,0>, H/75
			pigment { Yellow }
			finish { metalfin }
		}

		cylinder {
			#local mark_h = 0.68;
			<0, mark_h, 0>, <0, mark_h - H/150, 0>, H/20
			pigment { Yellow }
			finish { metalfin }
		}

		cylinder {
			#local mark_h = 0.5;
			<0, mark_h, 0>, <0, mark_h - H/150, 0>, H/20
			pigment { Yellow }
			finish { metalfin }
		}

		cylinder {
			<-W,0,0>, <W,0,0>, H/75
			pigment { Yellow }
			finish { metalfin }
		}

		translate <0, waist, 0>
	}
#end

light_source { <100,400,-800> White }
background { White*0.3 }
camera {
	location <-.4, .5, -2>	// final view
	//location <-.3, .3, -1.5>
	//location <0, .3, -1>	// front view, near
	look_at <0, 0, 0>

	//location <0, .4, -.5>
	//look_at <0, .4, 0>
}
