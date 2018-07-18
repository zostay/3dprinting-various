module rounded_cylinder(r,h,n) {
  rotate_extrude(convexity=1) {
    offset(r=n) offset(delta=-n) square([r,h]);
    square([n,h]);
  }
}

//cylinder(h=40, d=105, center=true);
difference() {
    rounded_cylinder(r=53, h=40, n=2);
    union() {
        translate([0, 0, 35/2])
            cylinder(h=35, d=84, center=true);
        translate([0, 0, 2.75/2])
            cylinder(h=4, d=88, center=true);
    }
}

translate([0, 0, 39.5])
import("Darth_Vader.stl");
//translate([-30, -30, 39.5])
//import("/Users/sterling/Documents/3dprinting/vader_finished.stl");