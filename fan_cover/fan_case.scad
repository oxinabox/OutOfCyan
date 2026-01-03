$fn = 98;
include <BOSL2/std.scad>

inner_width = 28;
inner_height = 13;
inner_length = 210;
thick=2.5;
round = thick;

inner_dims = [inner_width, inner_height, inner_length];
zrot(45)
diff() cuboid(inner_dims + [2*thick, 2*thick, thick], rounding=round, teardrop=30){
    position(TOP) up(0.01)
    tag("remove") color("red") cuboid(inner_dims, anchor=TOP, except=TOP, rounding=round, teardrop=30);
    
    attach(FRONT)
    textured_tile("trunc_diamonds", tex_reps=[5,10],
                  tex_inset=true, diff=true,
                  w1=0.95*inner_width, w2=0.95*inner_width, ysize=0.95*inner_length
    );

    attach(BACK)
    textured_tile("diamonds", tex_reps=[5,10],
                  tex_inset=true, diff=true,
                  w1=0.99*inner_width, w2=0.99*inner_width, ysize=0.95*inner_length
    );

    attach(LEFT)
    textured_tile("dots", tex_reps=[1,10],
                  tex_inset=true, diff=true,
                  w1=0.99*inner_height, w2=0.99*inner_height, ysize=0.95*inner_length
    );
};