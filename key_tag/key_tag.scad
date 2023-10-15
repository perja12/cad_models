/*
 * Code for generating key tags with Material Design icons from
 * https://pictogrammers.com/library/mdi/
 *
 * Created for the Flash Contest on printables.com.
 * The file symbols.csv contains the symbol to use, rotation and scaling.abs
 * The csv file is then read by render.sh which will call openscad with this
 * file as input to create stl files. 
 */

$fa = 1;
$fs = 0.4;

base_radius = 15;
split_ring_radius = 4;
split_ring_inner_radius = 2;
thickness = 1.8;
engraving_height = 0.4;
rim_width = 2;

module base() {
    cylinder(thickness, base_radius, base_radius, center=true);
}

module pocket() {
    translate([0, 0, (thickness/2)+((thickness/2)-engraving_height)]) {
        cylinder(h=2, r=base_radius - rim_width, center=true);
    }
}

module attachment_point_base() {
translate([base_radius, 0, 0]) {
        cylinder(h=thickness, r=split_ring_radius, center=true);
        }
}

module attachment_point_hole() {
    translate([base_radius, 0, 0]) {
        cylinder(20, split_ring_inner_radius,split_ring_inner_radius, center=true);
        }
}

module symbol(symbol, rotate=0, symbol_scale) {
    translate([0, 0, thickness-(thickness+engraving_height)/2]) {
        scale([symbol_scale, symbol_scale, 1]) {
            linear_extrude(engraving_height, center=true) {
                rotate([0, 0, rotate]) {
                    import(file = symbol, center = true);
                }
            }
        }
    }
}

difference() {
    union() {
        difference() {
            base();
            pocket();
        }

        attachment_point_base();
    }
    attachment_point_hole();
}


module print(name="", rotation=0, symbol_scale=1) {
    symbol(symbol=name, rotate=rotation, symbol_scale=symbol_scale);
}

// Set defaults for variables that will be overriden when called from render.sh
symbol_name = "mdi_svg/battery-sync.svg";
symbol_rotation = -90;
symbol_scale = 2;

print(name=symbol_name, rotation=symbol_rotation, symbol_scale=symbol_scale);




