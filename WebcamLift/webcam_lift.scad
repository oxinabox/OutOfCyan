include <BOSL2/std.scad>
include <BOSL2/cubetruss.scad>
$fn = 100;

thick = 2.5;
inner_width = 38.5;
width = inner_width+2*thick;
deep = 22+2*thick;
rounding=1.1;
slot=14;
slot_depth=32;
slot_shell = slot + 2*thick;
cuboid([thick, width, 48], rounding=rounding){
    color_this("blue") position(TOP+LEFT) cuboid([deep, width, thick], , rounding=rounding, anchor=LEFT+TOP){
        position(TOP + RIGHT) cuboid([thick, width, 17+thick], , rounding=rounding, anchor=TOP+RIGHT);
    };
        diff() position(TOP + LEFT) down(thick) cuboid([slot_shell, width, slot_depth +5 + thick], rounding=rounding, anchor=BOTTOM + LEFT)
        {
            up(0.01)
            position(TOP) tag("remove") cuboid([slot_depth, inner_width, slot], anchor=LEFT, orient=RIGHT);
        };

}