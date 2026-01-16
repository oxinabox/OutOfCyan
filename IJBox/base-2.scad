$fn = 98;
include <BOSL2/std.scad>
include <dims.scad>
include <sliding-lid-box-modules.scad>

needle_slot_width = 20;

total_width = sharps_container_height + 3;
barrel_box_depth = total_width - swab_width - thickness;
syringe_slot_width = vial_vslot_width + 20;
total_depth = 2*outer_thickness + 2*thickness + sharps_container_diameter + syringe_slot_width + needle_slot_width;
total_height = 2 * outer_thickness + sharps_container_diameter;
half_width = total_width/2 - thickness/2;

engrave = true;
engraving_depth = 0.5;

box_k = 2*outer_thickness;
b_t = outer_thickness;
b_w = total_height;
b_l = total_depth;
b_c = 0.5 * b_t;
b_lip = 0.7;
lip_and_lid = b_lip + b_c + b_t;  // the lip, the rail cut-out, and the thickness of the lid
b_h = box_k + b_lip + b_c;


lock_hole_radius = 3.5;
lock_hole_pos_v = (4.2 + lock_hole_radius);
lock_hole_pos_h = (12.5 + lock_hole_radius);

xrot(-90){

//Main box
difference(){
    //replace the `diff()` with `ghost_this()` while editting so can see what doing
    diff() cuboid(
        [total_depth, total_width, total_height],
        rounding=thickness/2,
        except=[FRONT, BACK]
    ){
        //Shelves
        color("violet") tag("remove") position(FRONT+LEFT) orient(BACK) left(outer_thickness) cylinder(
            h=total_width, r=sharps_container_diameter/2,
            anchor=BOT + RIGHT
        );

        swab_box_height = total_height - vial_vslot_height - thickness - 2* outer_thickness;
        color_this("red") tag("remove") position(FRONT + BOT + LEFT)
            up(outer_thickness) right(sharps_container_diameter + thickness + outer_thickness) cuboid(
            [max(swab_height, vial_vslot_width), swab_width, swab_box_height],
            anchor=FRONT + BOT + LEFT
        )
        {
            recolor("blue") tag("remove") position(FRONT + TOP + RIGHT) up(thickness) cuboid(
                [vial_vslot_width, 20, vial_vslot_height],
                anchor=FRONT + BOTTOM + RIGHT
            ){
                tag("remove") position(FRONT+RIGHT) left(vs_pad/2) orient(BACK)
                    cylinder(h=vial_length, r=vial_diameter/2, anchor=LEFT + BOT);
                tag("remove") position(FRONT+LEFT) right(vs_pad/2) orient(BACK)
                    cylinder(h=vial_length, r=vial_diameter/2, anchor=RIGHT + BOT);
            };

             recolor("orange") tag("remove") position(FRONT + BOTTOM + RIGHT) right(thickness) cuboid(
                [syringe_slot_width - vial_vslot_width - 2* thickness, swab_width, total_height - 2 * outer_thickness],
                anchor=FRONT + BOTTOM + LEFT
            );
        }

        color("cyan") tag("remove") position(BOTTOM + RIGHT + FRONT) up(outer_thickness) left(outer_thickness) cuboid(
            [needle_slot_width, half_width, (sharps_container_diameter)],
            anchor = BOTTOM + RIGHT + FRONT
        );
        color_this("pink") tag("remove") position(BOTTOM + RIGHT + BACK) up(outer_thickness) left(outer_thickness) cuboid(
            [needle_slot_width, total_width/2-thickness/2, (sharps_container_diameter)],
            anchor = BOTTOM + RIGHT + BACK
        ){
            color_this("green") tag("remove") position(BACK+LEFT+BOT) left(thickness) cuboid(
                [syringe_slot_width, barrel_box_depth, swab_box_height],
                anchor=BACK+RIGHT+BOT
            ){
                recolor("teal") tag("remove") position(TOP + LEFT + BACK) up(thickness) cuboid(
                    [bandaid_width, bandaid_length, vial_vslot_height],
                    anchor=BACK+LEFT+BOT
                );

                recolor("purple") tag("remove") position(TOP + RIGHT + BACK) up(thickness) cuboid(
                    [syringe_slot_width - bandaid_width - thickness, half_width, vial_vslot_height],
                    anchor=BACK+RIGHT+BOT
                );
            };
        };

        // locking holes
        for (ii=[0, 1]) for (jj=[0, 1])
        {
            mirror([0, 0, ii]) mirror([0, jj, 0]) 
            color("red") tag("remove") position(FRONT +LEFT + TOP)
                back(lock_hole_pos_h-lip_and_lid) down(lock_hole_pos_v) 
                zrot(45) orient(BACK) cylinder(
                h=100, r=lock_hole_radius,
                anchor= TOP + BOTTOM
            );
        }
        //For working out location to put the locking holes::
        //color("black") position(FRONT + TOP + LEFT) fwd(lip_and_lid) cuboid(lock_hole_pos, anchor=FRONT + TOP + LEFT);

        // Text on front/back/sides
        if (engrave) zrot(180){
            color("black") tag("remove") position(TOP + FRONT) back(10)
                text3d("Anticistamines", h=engraving_depth*1.1, size=10, anchor=TOP);
            color("black") tag("remove") position(TOP + BACK) fwd(20)
                text3d("Transition Fluid", h=engraving_depth*1.1, size=10, anchor=TOP);
            
            color("black") tag("remove") position(BOTTOM) orient(DOWN)
            {   
                back(50) left(25) text3d("Once a prince", h=engraving_depth*3, size=10, anchor=BACK);
                back(35) right(5) text3d("forever a princess", h=engraving_depth*3, size=10, anchor=BACK);
                
                back(15) left(25) text3d("Boys: just raw", h=engraving_depth*3, size=10, anchor=BACK);
                right(5) text3d("materials for Girls", h=engraving_depth*3, size=10, anchor=BACK);

                fwd(25) left(11) text3d("Estradiol is magic:", h=engraving_depth*3, size=10, anchor=BACK);
                fwd(40) right(22) text3d("brestigitation", h=engraving_depth*3, size=10, anchor=BACK);
            }
            
            color("black") tag("remove") orient(BACK)  position(RIGHT) yrot(90) down(0.1)
            {
                left(35) back(25) text3d("GIRL", h=engraving_depth*3, size=25, anchor=BACK);
                right(25) fwd(3) text3d("JUICE", h=engraving_depth*3, size=25, anchor=BACK);
            }
            color("black") tag("remove") orient(FRONT) position(RIGHT) yrot(90) down(0.1)
            {
                left(10) back(25) text3d("Stab the girl", h=engraving_depth*3, size=15, anchor=BACK);
                right(0) fwd(3) text3d("For her health", h=engraving_depth*3, size=15, anchor=BACK);
            }
        }
    };
    //Image on top
    if (engrave) zrot(180) color("black") up(total_height/2 - engraving_depth) 
        //times 1.1 is just to make more visible
        linear_extrude(engraving_depth*1.1) scale(0.7) import("estradiol.svg", center=true);
};

// Add a lip to the open faces of the box with a grove for the lid to slide into
for (k = [-1, 1])
    difference(){
        xrot(k*90) yrot(0) zrot(90)
        left(b_w/2)
        fwd(b_l/2)
        up(total_width/2 - box_k)
    box(b_w, b_l, b_h, b_t,  b_c);
    cuboid([total_depth + b_lip + 1000, total_width, total_height]);
};

// lids
for (k = [-1, 1]) 
    back(total_width/2 + b_c + b_lip)
    up(k*80)
    right(b_l/2)
    down(b_w/2)
    difference()
    {
        xrot(90) yrot(0) zrot(90) lid(b_w, b_l, b_h, b_t, b_c, 0.2, b_c/6, 0);

        //XXX The positioning math is wrong here this is kinda hard coded
        for (vp= [lock_hole_pos_v, total_height - lock_hole_pos_v])
            color("black")
            left(total_depth)
            up(total_height)
            right(lock_hole_pos_h - lip_and_lid - 2.25)
            down(vp)
            yrot(90) xrot(-45)//xrot(-45)
             cylinder(
                h=100, r=lock_hole_radius,
                anchor= TOP + BOTTOM + BACK
            );
    }
}