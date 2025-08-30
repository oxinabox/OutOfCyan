include <dims.scad>
difference(){
    cylinder(3, sharps_container_diameter/2 + thickness, sharps_container_diameter/2 + thickness);
    translate([0,0,-10])cylinder(230, sharps_container_diameter/2, sharps_container_diameter/2);   
};

