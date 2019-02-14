type="block"; // "bundle" OR "cylinder" OR "block"

bundle_width_count=4;
bundle_length_count=1;

battery_diameter=14;

battery_width=26;
battery_length=17;

battery_bundle_spacing=0;
battery_clearance=0.3;

battery_diameter_w_clearance=battery_diameter+battery_clearance;

battery_width_w_clearance=battery_width+battery_clearance;
battery_length_w_clearance=battery_length+battery_clearance;

bundle_width=bundle_width_count*battery_diameter+battery_bundle_spacing*(bundle_width_count-1)+battery_clearance*2;
bundle_length=bundle_length_count*battery_diameter+battery_bundle_spacing*(bundle_length_count-1)+battery_clearance*2;

battbox_count_wide=2;
battbox_count_long=24/bundle_width_count;
battbox_spacing=1;

battbox_edge_width=3;
battbox_base_thickness=5;

function battbox_dimension(sizing, count) =
    sizing*count+battbox_spacing*(count-1)+battbox_edge_width*2;

battbox_width_w_bundle=battbox_dimension(bundle_width, battbox_count_wide);
battbox_length_w_bundle=battbox_dimension(bundle_length,battbox_count_long);

battbox_width_w_cylinder=battbox_dimension(battery_diameter,battbox_count_wide);
battbox_length_w_cylinder=battbox_dimension(battery_diameter,battbox_count_long);

battbox_width_w_block=battbox_dimension(battery_width,battbox_count_wide);
battbox_length_w_block=battbox_dimension(battery_length,battbox_count_long);

function battbox_width() =
    type == "bundle"   ? battbox_width_w_bundle   :
    type == "cylinder" ? battbox_width_w_cylinder :
 /* type == "block" */   battbox_width_w_block;
function battbox_length() =
    type == "bundle"   ? battbox_length_w_bundle   :
    type == "cylinder" ? battbox_length_w_cylinder :
 /* type == "block" */   battbox_length_w_block;

battbox_height=30;

battery_cut_height=battbox_height*2;

socket_height=battbox_height * 2/3;
socket_diameter=3;
socket_setback=2;
socket_setback_width=2;
socket_offset=5;
socket_spacing=50;
socket_v_clearance=0.3;
socket_d_clearance=0.3;

module connector_tab() {
    cylinder(socket_height,d=socket_diameter);
}

module connector_socket() {
    cylinder(socket_height+socket_v_clearance,d=socket_diameter+socket_d_clearance);
}

module bundle_slot() {
    translate([0,0,battbox_base_thickness])
    union() {
        translate([battery_diameter/2,battery_diameter/2,0])
        cylinder(battery_cut_height,d=battery_diameter+battery_clearance*2);
        
        translate([bundle_width-battery_diameter/2,battery_diameter/2,0])
        cylinder(battery_cut_height,d=battery_diameter+battery_clearance*2);
        
        translate([battery_diameter/2,bundle_length-battery_diameter/2,0])
        cylinder(battery_cut_height,d=battery_diameter+battery_clearance*2);
        
        translate([bundle_width-battery_diameter/2,bundle_length-battery_diameter/2,0])
        cylinder(battery_cut_height,d=battery_diameter+battery_clearance*2);
        
        translate([0,battery_diameter/2,0])
        cube([bundle_width,bundle_length-battery_diameter,battery_cut_height]);
        
        translate([battery_diameter/2,0,0])
        cube([bundle_width-battery_diameter,bundle_length,battery_cut_height]);
    }
}

module cylinder_slot() {
    translate([battery_diameter_w_clearance/2,battery_diameter_w_clearance/2,battbox_base_thickness])
    cylinder(battery_cut_height,d=battery_diameter_w_clearance);
}

module box_slot() {
    translate([0,0,battbox_base_thickness])
    cube([battery_width_w_clearance,battery_length_w_clearance,battery_cut_height]);
}

module battery_box() {
    difference() {
        cube([battbox_width(),battbox_length(),battbox_height]);       
    
        for (w = [1:battbox_count_wide]) {
            for(l = [1:battbox_count_long]) {
                slot(w,l);
            }
        }
    }
}

module slot(w,l) {
    if (type == "bundle") {
        translate([battbox_edge_width+(bundle_width+battbox_spacing)*(w-1),battbox_edge_width+(bundle_length+battbox_spacing)*(l-1),0])
        bundle_slot();
    }
    
    else if (type == "cylinder") {
        translate([battbox_edge_width+(battery_diameter_w_clearance+battbox_spacing)*(w-1),battbox_edge_width+(battery_diameter_w_clearance+battbox_spacing)*(l-1),0])
        cylinder_slot();
    }
    else if (type == "block") {
        translate([battbox_edge_width+(battery_width_w_clearance+battbox_spacing)*(w-1),battbox_edge_width+(battery_length_w_clearance+battbox_spacing)*(l-1),0])
        box_slot();
    }
}

battery_box();