// from http://www.thingiverse.com/thing:35353

axle_spline_width = 2.0 - 0.2;
axle_diameter = 4.8 - 0.1;
axle_inner_keyhole_radius = 0.3; //keyhole the corners to try and make them square when printed

module lego_axle(height) {
  translate([0,0,height/2])
    difference() {
      union() {
        cube([axle_diameter,axle_spline_width,height],center=true);
        cube([axle_spline_width,axle_diameter,height],center=true);
      }//union
      for (A=[0,90,180,270]) {
        rotate([0,0,A]) {
          translate([axle_spline_width/1.75,axle_spline_width/1.75,0])
            cylinder(h=height+0.01,r=axle_inner_keyhole_radius,center=true, $fs=0.2);
      }
    }
  }
}

// Testing
echo("##########");
echo("In lego_axle.scad");
echo("This file should not be included, use ''use <filemane>'' instead.");
echo("##########");

p = 1;
nLayer = 1;
if (p==1) {
  lego_axle(10);
}
