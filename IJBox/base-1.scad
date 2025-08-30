include <dims.scad>

total_width = 3*thickness + vial_slot_width + syringe_length_hard;
total_depth = 4*thickness + sharps_container_diameter + swab_height + vial_slot_depth;
total_height = 2 * thickness + sharps_container_diameter;
big_vert = 2 * total_height;

difference(){
    cube([total_width, total_depth, total_height]);
    color("red") translate([thickness, thickness, thickness + sharps_container_diameter/2]) cube(
        [total_width-2*thickness, sharps_container_diameter, big_vert + sharps_container_diameter]
    );
    color("blue") translate(
        [thickness, thickness + sharps_container_diameter/2, thickness + sharps_container_diameter/2]
        ) rotate([0, 90, 0]) cylinder(
            sharps_container_height, sharps_container_diameter/2, sharps_container_diameter/2
    );
    
    translate(
        [thickness, 2*thickness + sharps_container_diameter, thickness]
    ) color("purple") cube (
            [vial_slot_width, swab_height, big_vert + vial_diameter/2]
        );

    translate([total_width - thickness, 2*thickness + sharps_container_diameter, thickness]) {
        color("brown") translate([-bandaid_length, 0,  0]) cube (
            [bandaid_length, bandaid_width, big_vert]
        );

        color("orange") translate([-syringe_length_hard, bandaid_width + thickness, 0]) cube (
            [
                syringe_length_hard,
                total_depth - 4* thickness - sharps_container_diameter - bandaid_width,
                big_vert + vial_diameter/2
            ]
        );
    };
    translate(
        [thickness, total_depth - thickness - vial_slot_depth, total_height - vial_diameter + thickness]
    ){ 
        color("green") cube (
                [vial_slot_width, vial_slot_depth, big_vert + vial_diameter/2]
        );
        color("blue") translate(
            [thickness + vial_slot_width/4, thickness, thickness]
            ) rotate([-90, 0, 0]) cylinder(
                vial_length, vial_diameter/2, vial_diameter/2
        );
        color("blue") translate(
            [3*vial_slot_width/4, thickness, thickness]
            ) rotate([-90, 0, 0]) cylinder(
                vial_length, vial_diameter/2, vial_diameter/2
        );
    }
}