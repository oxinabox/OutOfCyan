length = 330;

sheet_thick = 0.9;
over_thick = 2;
total_thick = 2*over_thick+sheet_thick;

gap_height = 28; // up to 36
total_height = 50;
slot_height = (total_height - gap_height)/2;

//content = "The only constant is change";
content = "Please move the pebbles";

difference() {
    difference()
    {
        cube([total_thick, length, total_height]);
        {
            translate([over_thick, 0, 0])
                color("green") cube([sheet_thick, length, slot_height]);

            translate([over_thick, 0, gap_height + slot_height])
                color("blue") cube([sheet_thick, length, slot_height]);
        }
    }
    color("purple")  translate([total_thick-over_thick/2,length/2, total_height/2])
        rotate([90, 0, 90])
            linear_extrude(20)
                text(content, 16, halign="center", font="Noto Sans:style=Bold", valign="center");
}