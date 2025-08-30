$fs=0.5;
$fn=24;

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

module chord(radius, offset){
    translate([-(radius-offset), 0, 0])
    difference()
    {
        sphere(radius);
        translate([-offset,0,0])
        cube([2*radius,20*radius,20*radius], center=true);
    }    
}



module holder(){
    difference()
    {
        difference()
        {
            difference()
            {
                roundedcube(8+0.7, 2+0.7, 16+0.7, 0.3, center=true);
                translate([0, 0, 0.5])
                    cube([8, 2, 17], center=true);
            }
            translate([0, 1, 1])
                cube([8-3.7, 1, 16], center=true);
        }


        for (s = [-1,-0.75, 0.75, 1])
        {
            translate([s*3.5, 2, 7.5])
                rotate([90, 0, 0])
                    cylinder(5, 0.2, 0.2);

            translate([s*3.5, 2, 6.5])
                rotate([90, 0, 0])
                    cylinder(5, 0.2, 0.2);
        }    
        for (s = [-1:0.5:1])
        {    
            for (d=[4.5:-2.5:-7])
            {
                translate([s*3.5, -0.5, d])
                    rotate([90, 0, 0])
                        cylinder(2, 0.2, 0.2);

                translate([s*3.5, -0.5, d])
                    rotate([90, 0, 0])
                        cylinder(2, 0.2, 0.2);            
            }
        }
    }
    
    // For better gluing once cut in half
    color("red")
    for (r=[0, 180])
    rotate([0, r, 0])
    translate([(8+0.7)/2, 0, 0])
    scale([1,1/5,1.2])
    difference()
    {
        chord(9, 2);
        for (i = [-1.5,0,1.5])
        translate([0.4,10,i])
        rotate([90,0,0])
        cylinder(20, 0.2, 0.2);
    }
}

holder();


/*
difference()
{
    holder();
    translate([0,10,0])
    cube(20,20,20, center=true);
}

translate([0, 10, 0])

difference()
{
    rotate([0,0,180])
    holder();
    translate([0,10,0])
    cube(20,20,20, center=true);
}
*/