module cut_out() {
    translate([-5.5,-100,-1])
        cube([11, 200, 4]);
}   

module cut_outs() {
    for (i = [0:6]) {
        translate([i*32.6, 0, 0]) cut_out();
    }
}

difference() {
    union() {
        cylinder(h=4, d=150, center=True);
        translate([0,0,4])
            cylinder(h=18, d1=150, d2=90, center=True);
    }
    
    translate([0, 0, 4])
        cylinder(h=20, d=74, center=True);

    translate([-82,0,0]) cut_outs();
}
