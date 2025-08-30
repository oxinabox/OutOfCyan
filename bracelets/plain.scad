$fn = 200;
inner_r = 38;
band_width = 4;
text_size = 6;
use <text_on.scad>

secondary_off = band_width/2;
rot_r = inner_r + secondary_off;
outer_r = rot_r + secondary_off;
difference(){
    rotate_extrude(convexity = 10){
        translate([rot_r, 0, 0])
        circle(band_width);
    };

    text_on_cylinder(
        " DANCER",[0,0,0],
        r1=outer_r, r2=outer_r,
        h=-text_size, size=text_size,
        eastwest=0,
        extrusion_height=secondary_off*2
    );

    text_on_cylinder(
        "  GIFT ",[0,0,0],
        r1=outer_r, r2=outer_r,
        h=-text_size, size=text_size,
        eastwest=72,
        extrusion_height=secondary_off*2
    );
    text_on_cylinder(
        "BEAUTY",[0,0,0],
        r1=outer_r, r2=outer_r,
        h=-text_size, size=text_size,
        eastwest=72*2,
        extrusion_height=secondary_off*2
    );
    text_on_cylinder(
        "WATCHER",[0,0,0],
        r1=outer_r, r2=outer_r,
        h=-text_size, size=text_size,
        eastwest=72*3,
        extrusion_height=secondary_off*2
    );
    text_on_cylinder(
        "  WORLD",[0,0,0],
        r1=outer_r, r2=outer_r,
        h=-text_size, size=text_size,
        eastwest=72*4,
        extrusion_height=secondary_off*2
    );
};
