include <Lego dimensions.scad>;

Kontaktstelle=0.6;

smooth=50; //Rundungen

// ###################################

KLOTZ(1, 4, 3, Tile=false); //X_Noppen, Y_Noppen, Höhe in Legolayer (*3,2), glatte Fliese=nein/ja)


// ###################################

module KLOTZ(X, Y, H){
union(){
	difference(){
	translate([0,0,-plate_h/2*H]) cube([brick_w*X-play*2, brick_w*Y-play*2, plate_h*H], center=true);
	translate([0,0,-plate_h/2*H-1]) cube([brick_w*X-2*Wall, brick_w*Y-2*Wall, plate_h*H], center=true);

knob_innerD(X, Y);
	}
//kleine Seiteninnen_stege Y Richtung
	translate([X*brick_w/2-Wall,(brick_w*Y)/2-brick_w/2,0])
	for(i=[0:1:Y-1]){
	translate([0,-brick_w*i,-plate_h/2*H])
	cube([Kontaktstelle, Kontaktstelle+0.125, plate_h*H], center=true);
	}
mirror([1,0,0]){
	translate([X*brick_w/2-Wall,(brick_w*Y)/2-brick_w/2,0])
	for(i=[0:1:Y-1]){
	translate([0,-brick_w*i,-plate_h/2*H])
	cube([Kontaktstelle, Kontaktstelle+0.125, plate_h*H], center=true);
	}
}
//kleine Seiteninnen_stege X Richtung
	translate([(brick_w*X)/2-brick_w/2, Y*brick_w/2-Wall, 0])
	for(i=[0:1:X-1]){
	translate([-brick_w*i, 0,-plate_h/2*H])
	cube([Kontaktstelle+0.125, Kontaktstelle, plate_h*H], center=true);
	}
mirror([0,1,0]){
	translate([(brick_w*X)/2-brick_w/2, Y*brick_w/2-Wall, 0])
	for(i=[0:1:X-1]){
	translate([-brick_w*i, 0,-plate_h/2*H])
	cube([Kontaktstelle+0.125, Kontaktstelle, plate_h*H], center=true);
	}
}

if(X==1 && Y>1) // Wenn X=1 und Y>1 
	InnenZyl1(Y-1, H);

if(X==2 && Y>=1) //Nur bei 2x2 Steinen
	InnenZyl2(X-1, Y-1, H);

if(X>=2 && Y>2 && H>2){ // Bei allen anderen Größen größer als 2x2 kommen innen Stege hinzu
	Steg_innen(X, Y, H);
	Steg_aussen(X, Y, H);
	}
}
if(Tile==false){
NIP_Aussen(X, Y);
}
}

//#########################################

module NIP_Aussen(X, Y){
translate([(-brick_w*X)/2+brick_w/2, 0, 0])
for(f=[0:1:X-1])
translate([brick_w*f, -brick_w/2*Y+brick_w/2, 0])
for(i=[0:1:Y-1])
translate([0, brick_w*i, knob_h/2])
cylinder(r=knob_D/2, h=knob_h, center=true, $fn=smooth);
}

module knob_innerD(X, Y){
translate([(-brick_w*X)/2+brick_w/2, 0, -2.5])
for(f=[0:1:X-1])
translate([brick_w*f, -brick_w/2*Y+brick_w/2, 0])
for(i=[0:1:Y-1])
translate([0, brick_w*i, knob_h/2])
cylinder(r=knob_innerD/2, h=knob_h, center=true, $fn=smooth);
}

module InnenZyl2(X, Y, H){ //Höhe in Legohöhe
translate([(brick_w*X)/2-brick_w/2, (brick_w*Y)/2-brick_w/2, 0])
for(f=[0:1:X-1])
translate([-brick_w*f, 0, -plate_h*H/2])
for(i=[0:1:Y-1])
translate([0, -brick_w*i, 0])
	difference(){
	cylinder(r=Inner_cyl2_r, h=plate_h*H, center=true, $fn=smooth);
	cylinder(r=Inner_cyl2_r-Inner_cyl2_wall, h=plate_h*H+1, center=true, $fn=smooth);
	}
}

module InnenZyl1(Y, H){ //Höhe in Legohöhe
translate([0,(brick_w*Y)/2-brick_w/2,0])
for(i=[0:1:Y-1])
translate([0,-brick_w*i,-plate_h/2*H])
cylinder(r=Inner_cyl1_D/2, h=plate_h*H, center=true, $fn=smooth/3);
}

module Steg_innen(X, Y, H){ // Innensteg wenn länger Y>2
translate([(brick_w*X)/2-brick_w, (brick_w*Y)/2-brick_w/2, 1])
for(f=[0:1:X-2])
translate([-brick_w*f, 0, -plate_h*H/2])
for(i=[0:1:Y-2])
translate([0, -brick_w*i, 0])
union(){
	translate([(1.5/2)+Inner_cyl2_r-Inner_cyl2_wall/2, -brick_w/2, 0])
	cube([1.5, Inner_cyl2_wall, plate_h*H-3], center=true);
mirror(1,0,0){
	translate([(1.5/2)+Inner_cyl2_r-Inner_cyl2_wall/2, -brick_w/2, 0])
	cube([1.5, Inner_cyl2_wall, plate_h*H-3], center=true);
}}}

module Steg_aussen(X, Y, H){
	translate([X*brick_w/2-Wall/2-2,(brick_w*Y)/2-brick_w, 1])
	for(i=[0:1:Y-2]){
	translate([0,-brick_w*i,-plate_h/2*H])
	cube([4, Inner_cyl2_wall, plate_h*H-3], center=true);
	}
mirror([1,0,0]){
	translate([X*brick_w/2-Wall/2-2,(brick_w*Y)/2-brick_w, 1])
	for(i=[0:1:Y-2]){
	translate([0,-brick_w*i,-plate_h/2*H])
	cube([4, Inner_cyl2_wall, plate_h*H-3], center=true);
	}
}}
	