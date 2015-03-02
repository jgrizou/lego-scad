include <Lego dimensions.scad>

smooth=50;

// ###################################

KLOTZ(1, 2, 3, Tile=false, Technic=true); //X_Noppen, Y_Noppen, Höhe in Legolayer (*3,2), glatte Fliese=nein/ja, Technikstein =ja/nein)


// ###################################

module KLOTZ(X, Y, H){
difference(){
union(){
	difference(){
	translate([0,0,-plate_h/2*H]) cube([brick_w*X-play*2, brick_w*Y-play*2, plate_h*H], center=true);
	translate([0,0,-plate_h/2*H-1]) cube([brick_w*X-2*Wall_Technic, brick_w*Y-2*Wall_Technic, plate_h*H], center=true);

knob_innerD(X, Y);


	} // ende diff
if(Y>=2){
tech_cyl(Y-1);}
else {tech_cyl(Y);}

		if(X==1 && Y>1) // Wenn X=1 und Y>1 
			InnenZyl1(Y-1, H);
		if(Tile==false){
		NIP_Aussen(X, Y);}

} // ende Union
if(Y>=2){
tech_hole(Y-1);}
else {tech_hole(Y);}
}
} // ende Module


// Module ###########################

module NIP_Aussen(X, Y){
translate([(-brick_w*X)/2+brick_w/2, 0, 0])
for(f=[0:1:X-1])
translate([brick_w*f, -brick_w/2*Y+brick_w/2, 0])
for(i=[0:1:Y-1])
translate([0, brick_w*i, knob_h/2])
difference(){
cylinder(r=knob_D/2, h=knob_h, center=true, $fn=smooth);
cylinder(r=knob_id/2, h=knob_h+1, center=true, $fn=smooth);}
}

module knob_innerD(X, Y){
translate([(-brick_w*X)/2+brick_w/2, 0, -2.5])
for(f=[0:1:X-1])
translate([brick_w*f, -brick_w/2*Y+brick_w/2, 0])
for(i=[0:1:Y-1])
translate([0, brick_w*i, knob_h/2])
cylinder(r=knob_innerD/2, h=knob_h, center=true, $fn=smooth);
}

module InnenZyl1(Y, H){ //Höhe in Legohöhe
translate([0, (brick_w*Y)/2-brick_w/2, 0])
for(i=[0:1:Y-1])
translate([0, -brick_w*i, -plate_h/2*H])
cylinder(r=Inner_cyl1_D/2, h=plate_h*H, center=true, $fn=smooth/3);
}

module tech_hole(Y){
translate([0,(brick_w*Y)/2-brick_w/2, 0])
for(i=[0:1:Y-1])
translate([0, -brick_w*i, -vert_pitch+axle_base])
union(){
rotate([0,90,0]) cylinder(r=hole_D/2, h=brick_w, center=true, $fn=smooth);
translate([brick_w-0.9,0,0]) rotate([0,90,0]) cylinder(r=recess_D/2, h=brick_w, center=true, $fn=smooth);
mirror([1,0,0]){
translate([brick_w-0.9,0,0]) rotate([0,90,0]) cylinder(r=recess_D/2, h=brick_w, center=true, $fn=smooth);
}}}

module tech_cyl(Y){
translate([0,(brick_w*Y)/2-brick_w/2, 0])
for(i=[0:1:Y-1])
translate([0, -brick_w*i, -vert_pitch+axle_base])
rotate([0,90,0]) cylinder(r=recess_D/2, h=brick_w-Wall, center=true, $fn=smooth);
}