
$fn = 200;
inner_r = 40;

marble_r = 8;
thick = 2;
band_r = marble_r + thick;

rot_r = inner_r + band_r;
outer_r = rot_r + band_r;



module sector(radius, angles, fn = 24) {
    r = radius / cos(180 / fn);
    step = -360 / fn;

    points = concat([[0, 0]],
        [for(a = [angles[0] : step : angles[1] - 360]) 
            [r * cos(a), r * sin(a)]
        ],
        [[r * cos(angles[1]), r * sin(angles[1])]]
    );

    difference() {
        circle(radius, $fn = fn);
        polygon(points);
    }
}

module arc(radius, angles, width = 1, fn = 100) {
    difference() {
        sector(radius + width, angles, fn);
        sector(radius, angles+[-0.1, 0.1], fn);
    }
} 

rotate_extrude(convexity = 10){
    translate([rot_r, 0, 0])
    arc(band_r, [20, 360-20], thick);
};

color("red") rotate_extrude(convexity = 10){
    translate([rot_r, 0, 0])
    arc(band_r, [0, 360], 0.5);
};

