$fn = 100;
include <BOSL2/std.scad>
include <BOSL2/joiners.scad>

w = 2.91;
diff()
{
snap_pin("medium"){
    attach(TOP)
    xrot(90)
    zrot(-110)
    back(0.1) left(3.5)
    {
        down(w/2)
        linear_extrude(w) tag("keep") stroke(catenary(22, droop=9), width=3.5);
    }
    position(TOP)
    left(2.3) down(2.7)
    cyl(r=2.8, h=w, orient=BACK);
}
};

/*
fwd(50){
    cylinder(h=2, r=10, anchor=BOTTOM);
    difference()
    {
        cylinder(h=9.3, r=4, anchor=BOTTOM);
        zrot(90)
        snap_pin_socket("medium", anchor=TOP);
    }
}
*/