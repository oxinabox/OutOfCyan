include <BOSL2/std.scad>
include <BOSL2/cubetruss.scad>
$fn = 100;

width = 36+8+8;
thick = 2.5;
deep = 22+2*thick;
rounding=1.1;
slot=9;
slot_depth=40;
slot_shell = slot + 2*thick;
cuboid([thick, width, 48], rounding=rounding){
    color_this("blue") position(TOP+LEFT) cuboid([deep, width, thick], , rounding=rounding, anchor=LEFT+TOP){
        position(TOP + RIGHT) cuboid([thick, width, 17+thick], , rounding=rounding, anchor=TOP+RIGHT);
    };
    position(TOP)
    cubetruss([1,4,6], size=slot_shell, anchor=BOTTOM+LEFT, bracing=false, strut=thick*0.7){
        diff() position(TOP + LEFT) down(thick) cuboid([slot_shell, width, slot_depth +5 + thick], rounding=rounding, anchor=BOTTOM + LEFT)
        {
            up(0.01)
            position(TOP) tag("remove") cuboid([slot_depth, 36, slot], anchor=LEFT, orient=RIGHT)
            {
                position(FRONT) fwd(4) cuboid([slot_depth, sqrt(slot*slot/2), sqrt(slot*slot/2)], anchor=FRONT+TOP, orient=FRONT+TOP);
                position(BACK) fwd(4) cuboid([slot_depth, sqrt(slot*slot/2), sqrt(slot*slot/2)], anchor=FRONT+TOP, orient=FRONT+TOP);
            };
        };
        position(FRONT+RIGHT+TOP) down(38) back(0.5) left(0.5)
        cyl(r=thick/3, h=77, center=true, anchor=BACK);
        position(FRONT+LEFT+TOP) down(38) back(0.5) right(0.5)
        cyl(r=thick/3, h=77, center=true, anchor=BACK);
        position(BACK+RIGHT+TOP) down(38) fwd(0.5) left(0.5)
        cyl(r=thick/3, h=77, center=true, anchor=BACK);
        position(BACK+LEFT+TOP) down(38) fwd(0.5) right(0.5)
        cyl(r=thick/3, h=77, center=true, anchor=BACK);
    };
}