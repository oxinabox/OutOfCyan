$fn = 100;
include <BOSL2/std.scad>
include <dims.scad>
include <sliding-lid-box-modules.scad>
slot_cutout = thickness/2;
box(vial_vslot_width, vial_length, vial_vslot_height, thickness, slot_cutout);

translate([-80, 0, 0])
lid(vial_vslot_width, vial_length, vial_vslot_height, thickness, slot_cutout, 0.2, thickness/3, 0.2);



diff()
cuboid(
    [vial_vslot_width + 2*thickness, vial_length 2*thickness, vial_vslot_height + 2* thickness],
    rounding=thickness
){
    tag("remove") position(FRONT) cuboid(
        [vial_vslot_width, 20, vial_vslot_height],
        anchor=FRONT
    ){
        tag("remove") position(FRONT+RIGHT) left(vs_pad/2) orient(BACK)
            cylinder(h=vial_length, r=vial_diameter/2, anchor=LEFT + BOT);
        tag("remove") position(FRONT+LEFT) right(vs_pad/2) orient(BACK)
            cylinder(h=vial_length, r=vial_diameter/2, anchor=RIGHT + BOT);
    };

    tag("remove") position(FRONT) fwd(2) cuboid(
        [100, 5, vial_diameter + 100],
        anchor=FRONT
    );

}