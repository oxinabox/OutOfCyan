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
            for (ii = [1:30]){
                s = hadamard([13,13, s_z_max], rands(0.2, 1, 3, 1000*seed*ii));
                pos = p_dim * hadamard([2,1],rands(-0.5,0.5, 2, seed*ii));
                translate([pos[0], pos[1], s[2]]) {
                    scale(s)
                        sphere(1);
                }
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
//pebble("family", 8);

pebble(word, seed);