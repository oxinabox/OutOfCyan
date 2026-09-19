$fn = $preview ? 16 : 32;



function hadamard(a,b) = !is_list(a) ? a*b : [ for(i = [0:len(a)-1]) hadamard(a[i],b[i]) ]; 

module pebble(word, seed) {
    p_dim=25;
    s_z_max = 7;


    space=0.04;
    magnet_radius= 3 + space;
    magnet_height = 3 + space;

    bottom_layer_thick = 0.2;
    magnet_offset = 10;
    difference(){
        hull() {
            scale([2.4, 1.4]) for (ii = [1:30]){
                r = rands(0, 360, 1, 10*ii*seed)[0];
                d = rands(0, 10, 1, 10*ii*seed +1)[0];
                s = hadamard([7,14, s_z_max], rands(0.2, 1, 3, 1000*seed*ii));
                
                    rotate([0, 0, r])
                        translate([d, 0, s[2]])
                            scale(s)
                                sphere(1);
            }
        };
        {
            color("red")  translate([0,0, 0.8*s_z_max]) linear_extrude(10)
                text(word, 10, halign="center", font="Noto Sans:style=Bold");

            color("green") for (side = [-1, 1])
                translate([side*magnet_offset, 0, bottom_layer_thick])
                    cylinder(r=magnet_radius, h=magnet_height, center=false);
        }
    };
}

//pebble("Trauma", 8);
//pebble("family", 9);

pebble(word, seed);