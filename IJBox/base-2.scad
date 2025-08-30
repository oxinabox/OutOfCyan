$fn = 100;
include <BOSL2/std.scad>
include <dims.scad>

needle_slot_width = 20;

total_width = sharps_container_height;
total_depth = 4*thickness + sharps_container_diameter + vial_vslot_width + needle_slot_width;
total_height = 2 * thickness + sharps_container_diameter;
half_depth = total_width/2-thickness/2;

engrave = thickness/2;
difference(){
    diff() cuboid(
        [total_depth, total_width, total_height],
        rounding=thickness/2
    ){

        color("violet") tag("remove") position(FRONT+LEFT) orient(BACK) left(thickness) cylinder(
            h=sharps_container_height, r=sharps_container_diameter/2,
            anchor=BOT + RIGHT
        );

        swab_box_height = total_height - vial_vslot_height - 3* thickness;
        color_this("red") tag("remove") position(FRONT + BOT + LEFT)
            up(thickness) right(sharps_container_diameter + 2*thickness) cuboid(
            [max(swab_height, vial_vslot_width), swab_width, swab_box_height],
            anchor=FRONT + BOT + LEFT
        )
        {
            recolor("blue") tag("remove") position(FRONT + TOP + RIGHT) up(thickness) cuboid(
                [vial_vslot_width, 20, vial_vslot_height],
                anchor=FRONT + BOTTOM + RIGHT
            ){
                tag("remove") position(FRONT+RIGHT) left(vs_pad/2) orient(BACK)
                    cylinder(h=vial_length, r=vial_diameter/2, anchor=LEFT + BOT);
                tag("remove") position(FRONT+LEFT) right(vs_pad/2) orient(BACK)
                    cylinder(h=vial_length, r=vial_diameter/2, anchor=RIGHT + BOT);
            };

            barrel_box_depth = total_width - swab_width - thickness;
            color_this("green") tag("remove") position(BACK+RIGHT+BOT) back(thickness) cuboid(
                [vial_vslot_width, barrel_box_depth, swab_box_height],
                anchor=FRONT+RIGHT+BOT
            ){
                recolor("teal") tag("remove") position(TOP + LEFT + BACK) up(thickness) cuboid(
                    [bandaid_width, bandaid_length, vial_vslot_height],
                    anchor=BACK+LEFT+BOT
                );

                recolor("purple") tag("remove") position(TOP + RIGHT + BACK) up(thickness) cuboid(
                    [vial_vslot_width - bandaid_width - thickness, half_depth, vial_vslot_height],
                    anchor=BACK+RIGHT+BOT
                );
            };
        };

        color("cyan") tag("remove") position(BOTTOM + RIGHT + FRONT) up(thickness) left(thickness) cuboid(
            [needle_slot_width, half_depth, (sharps_container_diameter)],
            anchor = BOTTOM + RIGHT + FRONT
        );
        color("pink") tag("remove") position(BOTTOM + RIGHT + BACK) up(thickness) left(thickness) cuboid(
            [needle_slot_width, total_width/2-thickness/2, (sharps_container_diameter)],
            anchor = BOTTOM + RIGHT + BACK
        );

        color("black") tag("remove") position(TOP + FRONT) back(5*thickness)
            text3d("Anticistamines", h=engrave*1.1, size=10, anchor=TOP);
        color("black") tag("remove") position(TOP + BACK) fwd(7*thickness)
            text3d("Transition Fluid", h=engrave*1.1, size=10, anchor=TOP);
    };

    color("black") up(total_height/2 - engrave)
        /*times 1.1 is just to make more visible*/
        linear_extrude(engrave*1.1) scale(0.7) import("estradiol.svg", center=true);
};