module tire_part() {
    translate([0,4,0]) minkowski() {
        rotate([0,90,0]) cylinder(r=.2, h=0.01, $fn=10);
        cube([.8,1,1.5], center=true);
    }
}

module quarter_spoke() {
    rotate([0,0,-18])
    #translate([0,0,.1]) linear_extrude(height=.5) {
        polygon([
            [0,1], [0,2.3], [1/2,3.25], [.75,3.25], [1/5,2], [1/5,1]
            //[1.5, 3.3], [.75, 2.5], [0.5,3.3], [0, 1],
            //[.25,0.8]
        ]);
    }
}

module half_spoke() {
    quarter_spoke();
    mirror([-.951,.309,0]) quarter_spoke();
}

module spoke() {
    half_spoke();
    mirror([1,0,0]) half_spoke();
}

module tire() {
    intersection() {
        translate([0,0,.5]) union() {
            translate([0,0,-.8]) 
            cylinder(r=4, h=2, $fn=10, center=true); 
            
            translate([0,0,-.25])
            sphere(r=1, $fn=30, center=true);
            
            i=0;
            for (i = [0:10:360]) {
                rotate([0,0,i]) tire_part();
            }
            
            translate([0,0,-1.4])
            difference() {
                cylinder(r=1,h=2,$fn=20);
                cylinder(r=0.8,h=3,$fn=20);
            }
            
            for (i = [0:72:360]) {
                rotate([0,0,i]) spoke();
            }
        }
        
        translate([-5,-5,0]) cube([10,10,10]);
    }
}

tire();

//translate([19,0,0])
//scale(10)
//import("/Users/sterling/Downloads/porche_911/911.stl");
