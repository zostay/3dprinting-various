

module clip() {
    union() {
        translate([0, 0, -3])
        cube([9,10,2]);
        
        translate([0,6,-3])
        rotate([0,90,0])
        linear_extrude(height=9) {
            polygon(points=[
                [0,0], [0,4], [1.75,0]
            ]);
        }
    }
}

module tab() {
    translate([0,0,3])
    union() {
        clip();
        mirror(v=[0,0,1]) {
            clip();
        }
    }
}

module stand() {
    union() {
        translate([59,45,0])
        tab();
        
        translate([-4.75,45,0])
        tab();
        
        cube([76.5,45,6]);

        translate([76.5-8,45,0])
        cube([8, 9, 6]);
        
        translate([5,45,0])
        cube([53, 9, 6]);
        
        union() {
            translate([0,0,3])
            rotate([0,90,0])
            cylinder(h=76.5,d=6);
            
            translate([76.5,0,3])
            rotate([-90,0,0])
            cylinder(h=45,d=6);
        
            intersection() {
                translate([0,0,3])
                rotate([0,90,0])
                cylinder(h=79.5,d=6);
                
                translate([76.5,-3,3])
                rotate([-90,0,0])
                cylinder(h=48,d=6);
            }
        }
    }
}

    stand();
    mirror(v=[1,0,0]) {
        stand();
    }