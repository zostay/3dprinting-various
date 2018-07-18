union() {
    difference() {
        cylinder(h=.75, r=10, center=true);
        translate([0, 0, -.1])
            cylinder(h=1, r=8.8, center=true);
    }
    difference() {
        cylinder(h=.75, r=5, center=true);
        translate([0, 0, -.1])
            cylinder(h=1, r=3.8, center=true);
    }
    for (i = [0:7]) {
        rotate([0, 0, i*45])
        translate([0, 7, 0])
            cube([1, 5.5, 0.75], center=true);
    }
    translate([0, 0, .75])
        cylinder(h=.75, r=10, center=true);
    translate([0, 0, 1.5])
        cylinder(h=1, r=5.75, center=true);
    translate([0, 0, 2.5])
        cylinder(h=3, r=4.05, center=true);
}