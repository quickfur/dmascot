/*
 * Prospective mascot for D?
 */

#include "colors.inc"

#declare amb = 0.4;
#declare metalfin = finish {
	diffuse 0.1
	ambient 0.4
	specular 1
	metallic
	roughness 0.1
};

#declare H = 0.75;
#declare W = 0.75;
#declare waist = -.3;
#declare body_thickness = .2;
#declare body_width = 0.7;

#local arm_rad = 0.05;
#local upper_arm_len = 0.3;
#local forearm_len = 0.3;

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
					pigment { White }
					finish { diffuse 0.5 ambient amb }
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
			#local shoulder_raise_angle = 50;
			#local shoulder_fwd_angle = 20;
			#local shoulder_out_angle = 10;
			#local elbow_angle = 20;

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

		pigment { Black }
		finish {
			diffuse .7
			specular .1
			roughness 1.0
		}
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
	location <-.4, .5, -1.5>	// final view
	//location <-.3, .3, -1.5>
	//location <0, .3, -1>	// front view, near
	look_at <0, 0, 0>

	//location <0, .4, -.5>
	//look_at <0, .4, 0>
}
