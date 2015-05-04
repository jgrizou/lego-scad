width_in_studs  = 1;
length_in_studs = 4;

module tooth() {
  $fn = 20;
  brick_height        = 9.64;
  brick_width         = 7.96;
  stud_diameter       = 4.88;
  stud_height         = 1.82;
  plate_height        = brick_height/3;
  wall_thickness      = 1.23;
  height_in_plates    = 1;
  tooth_base_width    = 2.3;
  tooth_tip_width     = 0.87;
  tooth_height        = 2.06;
  tooth_top           = 5.79;
  tooth_tip_radius    = 0.15;
  teeth_per_brick     = 2.5;
  half_pegs_per_brick = 2;
  gap_width           = 0.884;
  peg_diam            = 3.05;
  inner_peg_diam      = 1.51;

  //render()
  x_a = -((tooth_tip_width/2) - tooth_tip_radius);
  x_b = (tooth_tip_width/2) - tooth_tip_radius;
  translate([(gap_width+tooth_base_width)/2,0,0.65])
  rotate([0,0,180])
  translate([0,-(brick_width * width_in_studs)/2,tooth_height + 1]) {
    difference() {
      hull() {
        translate([x_a,0,tooth_height]) rotate([90,0,0]) cylinder(r=tooth_tip_radius,   h=(brick_width * width_in_studs), center=true);
        translate([x_b,0,tooth_height]) rotate([90,0,0]) cylinder(r=tooth_tip_radius,   h=(brick_width * width_in_studs), center=true);
        translate([0,0,0])              rotate([90,0,0]) cylinder(r=tooth_base_width/2, h=(brick_width * width_in_studs), center=true);
      }
      translate([0,0,-1]) cube(size=[gap_width + tooth_base_width, brick_width * width_in_studs + 1, 1.9], center=true);
    }
  }
}

module peg() {
  $fn = 20;
  brick_height        = 9.64;
  brick_width         = 7.96;
  stud_diameter       = 4.88;
  stud_height         = 1.82;
  plate_height        = brick_height/3;
  wall_thickness      = 1.23;
  height_in_plates    = 1;
  tooth_base_width    = 2.3;
  tooth_tip_width     = 0.87;
  tooth_height        = 2.06;
  tooth_top           = 5.79;
  tooth_tip_radius    = 0.15;
  teeth_per_brick     = 2.5;
  half_pegs_per_brick = 2;
  gap_width           = 0.884;
  peg_diam            = 3.05;
  inner_peg_diam      = 1.51;

  difference() {
    difference() {
      translate([0,(brick_width/2),(2.73/2)]) cylinder(r=(peg_diam/2), h=2.73, center=true);
      translate([0,(brick_width/2),(2.73/2)]) cylinder(r=inner_peg_diam/2, h=10, center=true);
    }
  }
}


module rack() {
  brick_height        = 9.64;
  brick_width         = 7.96;
  stud_diameter       = 4.88;
  stud_height         = 1.82;
  plate_height        = brick_height/3;
  wall_thickness      = 1.23;
  height_in_plates    = 1;
  tooth_base_width    = 2.3;
  tooth_tip_width     = 0.87;
  tooth_height        = 2.06;
  tooth_top           = 5.79;
  tooth_tip_radius    = 0.15;
  teeth_per_brick     = 2.5;
  half_pegs_per_brick = 2;
  gap_width           = 0.884;
  peg_diam            = 3.05;
  inner_peg_diam      = 1.51;

  teeth       = (length_in_studs * teeth_per_brick);
  tooth_width = tooth_base_width + gap_width;
  shift       = length_in_studs * (teeth_per_brick * tooth_width)/2;
  base_length = (length_in_studs * brick_width)/2;

  for ( i = [0 : teeth-1]) {
    translate([i * (tooth_base_width + gap_width), 0, 0]) tooth();
  }

  difference() {
    cube(size=[(brick_width * length_in_studs), (brick_width * width_in_studs), 3.73]);
    translate([wall_thickness,wall_thickness,-1]) cube(size=[(brick_width * length_in_studs) - (wall_thickness*2), (brick_width * width_in_studs) - (wall_thickness*2), 3.73]);
    // shave a bit off the beginning and end of the brick
    translate([-1.98,-1,0]) cube(size=[2, (brick_width * width_in_studs)+2, 10]);
    translate([(brick_width * length_in_studs) - 0.02,-1,0]) cube(size=[2, (brick_width * length_in_studs)+2, 10]);
  }

  peg_rows = (length_in_studs * half_pegs_per_brick/2);
  peg_cols = (width_in_studs * half_pegs_per_brick/2);

  difference() {
    union() {
      translate([brick_width/2,-brick_width/2,0])
      for ( row = [0 : peg_rows-1]) {
        for ( col = [0 : peg_cols]) {
          translate([row * brick_width, col * brick_width, 0]) peg();
        }
      }

      translate([0,0,0])
      for ( row = [0 : peg_rows]) {
        for ( col = [0 : peg_cols-1]) {
          translate([row * brick_width, col * brick_width, 0]) peg();
        }
      }
    }
    //chop off excess pegs on the walls
    difference() {
      translate([-2,-2,-1]) cube(size=[(brick_width * length_in_studs)+4, (brick_width * width_in_studs)+4, 10]);
      translate([wall_thickness,wall_thickness,-2]) cube(size=[(brick_width * length_in_studs) - (wall_thickness*2), (brick_width * width_in_studs) - (wall_thickness*2), 10]);
    }
  }
}

rack();