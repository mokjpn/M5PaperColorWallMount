// M5PaperColor landscape wall holder with thumbtack recesses
// Units: mm
//
// Device reference:
// M5Stack PaperColor product size: 70.8 x 103.9 x 8.5 mm

$fn = 128;

// --- Device and fit ---
device_w = 103.9;
device_h = 70.8;
device_d = 8.5;

fit_clearance_w = 0.6;
fit_clearance_d = 3.0;

pocket_w = device_w + fit_clearance_w;
pocket_d = device_d + fit_clearance_d;

// --- Holder body ---
side_wall = 5.0;
back_wall = 7.0;
bottom_lip = 7.5;

// Keep the same 12.7 mm exposed top edge as the M5Paper S3 holder.
top_exposed = 12.7;
top_overcut = 2.5;
eps_front = 0.2;

outer_w = pocket_w + side_wall * 2;
outer_d = back_wall + pocket_d;
outer_h = device_h - top_exposed;

cut_w = pocket_w;
cut_h = outer_h - bottom_lip + top_overcut;
cut_d = pocket_d + eps_front;

cut_x0 = side_wall;
cut_x1 = side_wall + cut_w;

// --- Front stopper tabs ---
stop_x = 5.0;
stop_y = 3.0;
stop_z = 20.0;

// --- Thumbtack recesses on the back side ---
hole_diam = 15.0;
hole_r = hole_diam / 2;
hole_depth = 5.0;

// Scaled for the landscape PaperColor width while keeping generous side margins.
hole_dx = 33.0;

pin_diam = 1.4;
pin_r = pin_diam / 2;
pin_depth = back_wall + 0.2;

module main_body() {
    difference() {
        cube([outer_w, outer_d, outer_h], center=false);

        // Front pocket. The top is intentionally over-cut to make insertion easy.
        translate([cut_x0, back_wall, bottom_lip])
            cube([cut_w, cut_d, cut_h], center=false);
    }
}

module front_stoppers() {
    translate([cut_x0, outer_d - stop_y, 0])
        cube([stop_x, stop_y, stop_z], center=false);

    translate([cut_x1 - stop_x, outer_d - stop_y, 0])
        cube([stop_x, stop_y, stop_z], center=false);
}

module thumbtack_recess(x_offset) {
    translate([outer_w / 2 + x_offset, back_wall, outer_h / 2])
        rotate([90, 0, 0])
            cylinder(h=hole_depth, r=hole_r, center=false);
}

module thumbtack_pin_hole(x_offset) {
    translate([outer_w / 2 + x_offset, back_wall, outer_h / 2])
        rotate([90, 0, 0])
            cylinder(h=pin_depth, r=pin_r, center=false);
}

difference() {
    union() {
        main_body();
        front_stoppers();
    }

    thumbtack_recess(-hole_dx);
    thumbtack_recess(hole_dx);

    thumbtack_pin_hole(-hole_dx);
    thumbtack_pin_hole(hole_dx);
}
