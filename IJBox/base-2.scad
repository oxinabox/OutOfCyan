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

engrave = 0.5;

box_k = 2*outer_thickness;
b_t = outer_thickness;
b_w = total_height;
b_l = total_depth;
b_c = 0.5 * b_t;
b_lip = 0.7;
b_h = box_k + b_lip + b_c;

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

        // Text on front/back/sides
        zrot(180){
            color("black") tag("remove") position(TOP + FRONT) back(10)
                text3d("Anticistamines", h=engrave*1.1, size=10, anchor=TOP);
            color("black") tag("remove") position(TOP + BACK) fwd(20)
                text3d("Transition Fluid", h=engrave*1.1, size=10, anchor=TOP);
            
            color("black") tag("remove") position(BOTTOM) orient(DOWN)
            {   
                back(50) left(25) text3d("Once a prince", h=engrave*3, size=10, anchor=BACK);
                back(35) right(5) text3d("forever a princess", h=engrave*3, size=10, anchor=BACK);
                
                back(15) left(25) text3d("Boys: just raw", h=engrave*3, size=10, anchor=BACK);
                right(5) text3d("materials for Girls", h=engrave*3, size=10, anchor=BACK);
            }
            
            color("black") tag("remove") orient(BACK)  position(RIGHT) yrot(90) down(0.1)
            {
                left(35) back(25) text3d("GIRL", h=engrave*3, size=25, anchor=BACK);
                right(25) fwd(3) text3d("JUICE", h=engrave*3, size=25, anchor=BACK);
            }
            color("black") tag("remove") orient(FRONT) position(RIGHT) yrot(90) down(0.1)
            {
                left(20) back(25) text3d("Stab the girl", h=engrave*3, size=15, anchor=BACK);
                right(5) fwd(3) text3d("For her health", h=engrave*3, size=15, anchor=BACK);
            }
        }
    };
    //Image on top
    zrot(180) color("black") up(total_height/2 - engrave) 
        //times 1.1 is just to make more visible
        linear_extrude(engrave*1.1) scale(0.7) import("estradiol.svg", center=true);
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
    up(-20 + k*80)
    right(70)
    xrot(90) yrot(0) zrot(90)
    lid(b_w, b_l, b_h, b_t, b_c, 0.2, b_c/6, 0);
