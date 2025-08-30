/*
Based on
https://www.printables.com/model/512575-parametric-sliding-lid-box/
General Public License v3.0
Matt Braddock
@MattBraddock_295925
*/

/**
boxWidth = 50;
total width (in mm) of the box

boxLength = 80;
total length (in mm) of the box

boxHeight = 30;
total height (in mm) of the box

wallThickness = 3.2; // 0.1
total thickness (in mm) of the walls

cutoutSize = 2; // 0.1
height and width (in mm) of slide cutout (this subtracted from wallThickness is minimum wall thickness)

freedom = 0.2; // 0.1
amount of freedom (in mm) between slide and cutoutSize

bumpHeight = 0.8; // 0.1
height (in mm) of the latch bump (must be less than cutoutSize)

notchWidth = 0.7; // 0.01
width (in terms of total width) of notch on lid
**/

module box(boxWidth, boxLength, boxHeight, wallThickness, cutoutSize) {
    x = boxWidth;
    y = boxLength;
    z = boxHeight;
    w = wallThickness;
    c = cutoutSize;
    
    difference() {
        // outer shell
        cube([x, y, z]);
        
        // inner shell
        translate([w, w, w])
        cube([x - (2 * w), y - (2 * w), z]);
        
        // opening for lid
        translate([w, 0, z - c])
        cube([x - (2 * w), w, c]);
        
        translate([0, 0, z])
        slide_cutouts(x, y, w, c);
    }
}

module slide_cutouts(boxWidth, boxLength, wallThickness, cutoutSize) {
    x = boxWidth;
    y = boxLength;
    w = wallThickness;
    c = cutoutSize;
    // slide cutouts
    translate([w - c, 0, -c])
    polyhedron(points = [
        [0, 0, 0],
        [c, 0, 0],
        [c, 0, c],
        [0, y - w, 0],
        [c, y - w, 0],
        [c, y - w, c]
    ], faces = [
        [0, 2, 1],
        [3, 4, 5],
        [3, 5, 2, 0],
        [1, 2, 5, 4],
        [0, 1, 4, 3]
    ]);
    
    translate([x - w, 0, -c])
    polyhedron(points = [
        [0, 0, 0],
        [c, 0, 0],
        [0, 0, c],
        [0, y - w, 0],
        [c, y - w, 0],
        [0, y - w, c]
    ], faces = [
        [0, 2, 1],
        [3, 4, 5],
        [3, 5, 2, 0],
        [1, 2, 5, 4],
        [0, 1, 4, 3]
    ]);
    
    // latch cutouts
    translate([2 * w, y - ((w + c) / 2), -c])
    polyhedron(points = [
        [0, 0, c],
        [c, 0, c],
        [0, 0, 0],
        [c, 0, 0],
        [0, c, c],
        [c, c, c]
    ], faces = [
        [0, 1, 3, 2],
        [0, 4, 5, 1],
        [2, 3, 5, 4],
        [2, 4, 0],
        [3, 1, 5]
    ]);
    
    translate([x - (2 * w) - c, y - ((w + c) / 2), -c])
    polyhedron(points = [
        [0, 0, c],
        [c, 0, c],
        [0, 0, 0],
        [c, 0, 0],
        [0, c, c],
        [c, c, c]
    ], faces = [
        [0, 1, 3, 2],
        [0, 4, 5, 1],
        [2, 3, 5, 4],
        [2, 4, 0],
        [3, 1, 5]
    ]);
}

module lid(boxWidth, boxLength, boxHeight, wallThickness, cutoutSize, freedom, bumpHeight, notchWidth) {
    x = boxWidth;
    y = boxLength;
    z = boxHeight;
    w = wallThickness;
    c = cutoutSize;
    f = freedom;
    b = bumpHeight;
    n = notchWidth;
    
    difference() {
        union() {
            //bottom
            cube([x, y, w - c]);
            
            //top
            translate([w - c + f, 0, w - c])
            cube([x - (2 * (w - c + f)), y - w - f, c - f]);
            
            //bump one
            translate([(2 * w) + (c / 2) + f, y - (w / 2), w - c])
            cylinder(h = b, d1 = c - (2 * f), d2 = f, $fn = 6);
            
            //bump two
            translate([x - (2 * w) - (c / 2) - f, y - (w / 2), w - c])
            cylinder(h = b, d1 = c - (2 * f), d2 = f, $fn = 6);
        }
        
        //cutout one
        translate([w - c + f, 0, w - c])
        polyhedron(points = [
            [0, 0, 0],
            [c, 0, 0],
            [0, 0, c - f],
            [0, y - w, 0],
            [c, y - w, 0],
            [0, y - w, c - f]
        ], faces = [
            [0, 2, 1],
            [3, 4, 5],
            [3, 5, 2, 0],
            [1, 2, 5, 4],
            [0, 1, 4, 3]
        ]);
        
        //cutout two
        translate([x - w - f, 0, w - c])
        polyhedron(points = [
            [0, 0, 0],
            [c, 0, 0],
            [c, 0, c - f],
            [0, y - w, 0],
            [c, y - w, 0],
            [c, y - w, c - f]
        ], faces = [
            [0, 2, 1],
            [3, 4, 5],
            [3, 5, 2, 0],
            [1, 2, 5, 4],
            [0, 1, 4, 3]
        ]);
        
        //slide cutout
        translate([(x * (1 - n)) / 2, 0.1 * y, 0])
        polyhedron(points = [
            [0, 0, 0],
            [n * x, 0, 0],
            [0, c, 0],
            [n * x, c, 0],
            [0, 0, c],
            [n * x, 0, c]
        ], faces = [
            [0, 4, 5, 1],
            [4, 2, 3, 5],
            [1, 3, 2, 0],
            [1, 5, 3],
            [0, 2, 4]
        ]);
    }
}