$fn = 100;
inner_r = 38;
band_width = 25.4;

coin_thick = 2.2;
coin_radius =31/2 + 0.25;
big_thick = 100;
include <BOSL2/std.scad>
include <BOSL2/joiners.scad>
use <text_on.scad>


secondary_s = 0.1;
secondary_off = secondary_s * band_width;
rot_r = inner_r + secondary_off;
outer_r = rot_r + secondary_off;

lip_front_t = 0.8;
lip_back_t = 0.4;
lip_side_t = 1;
lip_over_t = 1.5;
coin_lip_outer_r = coin_radius + lip_side_t
crossover_end = (band_thick - coin_lip_outer_r)
diff()
{
    difference(){
        
        //rotate_extrude(convexity = 10){
            color("green") translate([rot_r, 0, 0])
            scale([secondary_s, 1]) circle(band_width);
            color("red") polygon([[rot_r, 0], [rot_r, band_width], [outer_r, 0]])
        //};

        text_on_cylinder(
            "CUNT",[0,0,0],
            r1=outer_r, r2=outer_r,
            h=-24, size=24,
            eastwest=-37.5,
            extrusion_height=secondary_off*2
        );
    }


    back(rot_r - 1.9) xrot(-90)
    //outer
    color("orange") cylinder(h=coin_thick + lip_front_t + lip_back_t, r=coin_lip_outer_r)
    {
        //coinspace
        position(BOTTOM) up(lip_back_t)
        tag("remove") color("red") cylinder(h=coin_thick, r=coin_radius, anchor=BOTTOM);
        //view_hole
        tag("remove") position(TOP) down(lip_front_t)
        color("blue") cylinder(h=big_thick, r=coin_radius-lip_over_t, anchor=BOTTOM);
    }

    // for test prints
    //tag("remove") cylinder(r=big_thick, h=big_thick);
    //down(coin_radius + lip_side_t + 2) tag("remove") cylinder(r=big_thick, h=big_thick, anchor=TOP);

};
