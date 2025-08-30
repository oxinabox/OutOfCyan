$fn = 100;

include <dims.scad>

include <BOSL2/std.scad>



echo(vial_vslot_width);

diff()
cuboid(
    [vial_vslot_width + 2 * thickness, vial_length + thickness * 2, vial_vslot_height + 2* thickness],
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