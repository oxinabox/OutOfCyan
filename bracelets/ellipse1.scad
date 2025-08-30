$fn = 200;
inner_r = 38;
band_width = 25.4;

use <text_on.scad>


secondary_s = 0.1;
secondary_off = secondary_s * band_width;
rot_r = inner_r + secondary_off;
outer_r = rot_r + secondary_off;
difference(){
    rotate_extrude(convexity = 10){
        translate([rot_r, 0, 0])
        scale([secondary_s, 1]) circle(band_width);
    };

    text_on_cylinder(
        "CUNT",[0,0,0],
        r1=outer_r, r2=outer_r,
        h=-24, size=24,
        eastwest=-37.5,
        extrusion_height=secondary_off*2
    );

        text_on_cylinder(
        "ART",[0,0,0],
        r1=outer_r, r2=outer_r,
        h=-24, size=24,
        eastwest=157,
        extrusion_height=secondary_off*2
    );
};
