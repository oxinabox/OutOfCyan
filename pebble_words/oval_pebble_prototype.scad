seed = 10;
hull() scale([1, 2,1]) for (ii=[1:50]) {
    r = rands(0, 360, 1, 10*ii*seed)[0];
    d = rands(0, 10, 1, 10*ii*seed +1)[0];
    rotate([0, 0, r])
        translate([d, 0, 0])
            sphere(1);
    
}