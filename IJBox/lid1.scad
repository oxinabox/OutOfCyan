include <dims.scad>

color("grey") cube([total_width, total_depth, thickness]);
translate([total_width/2, total_depth/2, thickness]) color("black") {
    scale(0.7) import("estradiol.svg", center=true);
    text("Anticistamines");
}