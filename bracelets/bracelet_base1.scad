$fn = 200;
inner_r = 38;
outer_r = inner_r + 3;
band_width = 25.4;

use <text_on.scad>

difference(){
    cylinder(r=outer_r, h=band_width, center=true);
    cylinder(r=inner_r, h=band_width*2, center=true);
    text_on_cylinder("TRANSEXUAL",[0,0,0],r1=outer_r,r2=outer_r, h=-18, size=20, eastwest=0);
};