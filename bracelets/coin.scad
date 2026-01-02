$fn = 200;

inner_r = 38;
band_width = 25.4;

//coin_thick = 2.2;  // well kept australian penny
coin_thick = 1.28;

coin_radius =31/2 + 0.25;
big_thick = 100;
include <BOSL2/std.scad>
include <BOSL2/joiners.scad>
use <text_on.scad>


secondary_s = 0.1;
secondary_off = secondary_s * band_width;
rot_r = inner_r + secondary_off;
outer_r = rot_r + secondary_off;

plug_h=7;
plug_tol=0.1;
plug_r=3.3/2;

for (side=[0, 1]){
    mirror([0,0, side])
    right(side*2*(outer_r + 10))
    diff()
    {
        difference(){
            rotate_extrude(convexity = 10){
                translate([rot_r, 0, 0])
                scale([secondary_s, 1]) circle(band_width);
            };
            mirror([side, 0, 0]) // unfip
            text_on_cylinder(
                "CUNT",[0,0,0],
                r1=outer_r, r2=outer_r,
                h=-24, size=24,
                eastwest=-37.5,
                extrusion_height=secondary_off*2
            );
        }

        lip_front_t = 0.8;
        lip_back_t = 0.4;
        lip_side_t = 1;
        lip_over_t = 1.5;
        back(rot_r - 1.9) xrot(-90)
        //outer
        color("orange") cylinder(h=coin_thick + lip_front_t + lip_back_t, r=coin_radius + lip_side_t)
        {
            //coinspace
            position(BOTTOM) up(lip_back_t)
            tag("remove") color("red") cylinder(h=coin_thick, r=coin_radius, anchor=BOTTOM);
            //view_hole
            tag("remove") position(TOP) down(lip_front_t)
            color("blue") cylinder(h=big_thick, r=coin_radius-lip_over_t, anchor=BOTTOM);
        }

        //cut in half
        mirror([0,0, side])
        tag("remove") cylinder(r=big_thick, h=big_thick);

        for (lr=[-1, 1]){
            for (ii=[-60: 17 : 35]){
                tt = side ? "keep" : "remove";
                plug_rad = plug_r + abs(side - 1) * plug_tol;
                zrot(lr*ii) left(lr * rot_r)
                tag(tt) color("green") cylinder(r=plug_rad, h=2*plug_h, anchor=TOP+BOTTOM);
            }
        }
    };
};
