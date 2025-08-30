$fa = 1;
$fs = 0.5;
$fn = 100;


difference()
{
    difference()
    {
        difference()
        {
            cube([8+0.5, 2+0.5, 16+0.5], center=true);
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