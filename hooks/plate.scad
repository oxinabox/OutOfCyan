$fn = 100;
include <BOSL2/std.scad>
include <BOSL2/walls.scad>
include <BOSL2/joiners.scad>

from_wall = 15;
brace_r = 10;
brace_h = 20;
brace_d = 2.5;

total_width = 150;

strut_w = 6;
h_repeats = 6;
length = 210;

counter_brace_d = from_wall + brace_d + 2;
diff()
{
cuboid(
    [total_width, brace_h, counter_brace_d],
    rounding=1, edges = TOP,
    anchor=BOTTOM + BACK + LEFT
){
    position(BOTTOM) up(from_wall)
    tag("remove") cuboid([2*total_width, brace_h, brace_d], anchor=BOTTOM);

   
    position(BOTTOM)
    attach(FRONT)
    rot([0,0, 90])
    sparse_wall(h=total_width, l=length, thick=3, orient=BACK, anchor=BACK+LEFT, maxang=45, max_bridge=150/5, strut=strut_w);
};
for (i = [0: total_width/(h_repeats - 1): total_width]) right(i)
{
    tag_this("keep") tag_scope("Foo") diff("rem") cylinder(r=brace_r, h=counter_brace_d, center=false){
        position(TOP)
        back(3)
        up(0.2)
        tag_this("rem") zrot(90) snap_pin_socket("medium", anchor=BOTTOM);
    }
}

fwd(strut_w)
for (i = [0: total_width/(6): total_width]) right(i)
{

    v_gap = (length - strut_w)/12;
    for (j = [2:12]) fwd(j * v_gap){
        if (i > 0 && i < total_width){
            if ((i + j) % 2 == 1) {
                difference()
                {
                    cylinder(h=9.3, r=4, anchor=BOTTOM);
                    zrot(90)
                    snap_pin_socket("medium", anchor=TOP);
                }
            }
        }
    }
}
};




/*
    orient(LEFT)
    back(15)
    cylinder(r = 30, h= 5, anchor=RIGHT + FRONT){
        tag("remove")down(10)cylinder(r = 25, h= 15);
    }
*/