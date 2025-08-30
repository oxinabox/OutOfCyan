$fn = $preview ? 16 : 50;

module roundedcube(xx, yy, height, radius, center=false, centerxy=false)
{
    translate([(center||centerxy)?-xx/2:0,(center||centerxy)?-yy/2:0,center?0:height/2])
    hull()
    {
        for (zz=[-(height/2-radius), (height/2-radius)])
        {
            translate([0,0,zz])
            {
               
                {
                    translate([radius,radius,0])
                    sphere(radius);

                    translate([xx-radius,radius,0])
                    sphere(radius);

                    translate([xx-radius,yy-radius,0])
                    sphere(radius);

                    translate([radius,yy-radius,0])
                    sphere(radius);
                }
            }
        }
    }
}




module holder(wall, fwall, slot, bottom_panel, width, depth, height, hole_radius, spacing)
{
    difference()
    {
        difference()
        {
            difference()
            {
                roundedcube(width+2*wall, depth+fwall, height+wall, depth/10, center=true);
                translate([0, 0, wall])
                    cube([width, depth, height+wall], center=true);
            }
            translate([0, fwall, bottom_panel])
                cube([slot, depth, height], center=true);
        }


        for (s = [-0.85, 0.85])
        {
            translate([s*0.45*width, depth, 0.47*height])
                rotate([90, 0, 0])
                {
                    cylinder(2*(depth+fwall), hole_radius, hole_radius);
                }
        }    
        for (s = [-0.9 : 0.45 : 0.9])
        {    
            for (d=[0.7*height/2:-spacing:-0.9*height/2])
            {
                translate([s*width/2, 0, d])
                    rotate([90, 0, 0])
                        cylinder(2*(depth+fwall), hole_radius, hole_radius);
            }
        }
    }  
}



buffer=2;
elastic_buffer=1;
phone_width = 80+buffer;
phone_depth = 14.5 + buffer + elastic_buffer;
phone_height = 160 + buffer;
popcap_diameter =40+buffer+10;
bottom_panel = 40;
belt_width = 35/2;
hole_radius = 2.5;
wall = 2.5;
fwall = 1.5;
outer_width = phone_depth + 2*fwall;

module holder_set()
{
    holder(wall, fwall, popcap_diameter, bottom_panel, phone_width, phone_depth,       phone_height, hole_radius, belt_width);
}


mode = 2;
if (mode == 1)
{
    holder_set();
}

if (mode == 2 || mode == 3)
{
    difference()
    {
        holder_set();
        translate([0,outer_width/2,0])
        cube([200,outer_width,200], center=true);
    }
}

translate([100, 0, 0])
if (mode == 2 || mode == 4)
{
    difference()
    {
        rotate([0,0,180])
        holder_set();
        translate([0,outer_width/2,0])
        cube([200,outer_width,200], center=true);
    }
}