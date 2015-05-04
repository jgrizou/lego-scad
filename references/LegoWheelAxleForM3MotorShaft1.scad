// Axle/Hub for Lego wheel.
// Connects M3 motor shaft on Tajima motor/gearbox kit to Lego splined axle wheel.
//
// Printed at 0.2mm layers on UP!. Build 45degree overhangs with no support
//
// Motor shaft hole can be HEX, ROUND, or ROUND with FLAT

// Using metal hex threaded standoff for M3 connection
// standoff is M3x10mm x5mm across flats JAYCAR HP0900
// standoff is press fit into hex hole. Hole has domed ceiling so prints without support
//
// Lego axle design has keyholing to get cleaner inner corners than a simple cross, on the UP
// Has provision for two Flanges that can directly engage the inner surfaces of the wheel rim to provide support
// as the printed axle is prone to shearing under load.
// It is intended that the flange/s are interference fit into the hub parts,
// and that the wheel is forced all the way down the axle to the flange so the axle is not cantilevered
// Intended for insertion from the deep side of the wheel hub

//-------- Dimension Constants ------------
//R???? = radius, L???? = length; Note small numbers added to dimensions are used to trim for exact fit with your printer (eg +0.1)

	LSpline=8.5 + 2; //Spline is the Lego Axle part

	//AQUA  Flange1 closest to spline
	RFlange=(8 +0.1)/2; //Flange1 is adjacent to the axle spline
	LFlange=4.3;

	//TEAL Flange 2 is optional where it needs a large ring spaced off the axle by Flange1

//Type2 Hub - Red/Orange Balloon tyres, double flange; Also works for Black wheels
	RFlange2=(16+0.1)/2;
	LFlange2=6;

// Type1 Hub - Black, flat tyres, only 1 small flange
	//RFlange2=RFlange;
	//LFlange2=0.01;

	HoleOS=0.6/2; // Oversize holes to get to correct size. (UP usually makes holes small)
	HoleIsHex=false;
	HoleFlat=0; //For round motor hole with flat on one side. Depth of flat from outside
     LHole=10        ;  //Hex threaded insert dimensions
     RHole=5/2 + HoleOS; //For hex holes is distance across flats (apothem)

	//MAGENTA  Shaft is part holding hex from motor end
	RShaft =12/2;
     LShaft=LHole+ 5;

	RHex=Apothem2Radius(RHole,6) ; //dimension across diagonals


//-----
function Apothem2Radius(apothem,n) = apothem / cos(180/n);

//use <MCAD/lego_compatibility.scad> //axle shape and dimensions not usable.
use <MCAD/regular_shapes.scad>

//-------------------- Lego Axle ----------------------
axle_spline_width=2.0 - 0.2;
axle_diameter=4.8 - 0.1;
axle_inner_keyhole_radius=0.3; //keyhole the corners to try and make them square when printed

module axle(height) {
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
				}//rot
			}//for
		}//translate diff
}//module

//----------------------------- Main ---------------------------------
difference() {
	union() { //the solid bits
//color('red") cylinder(r1=RHole*1.25,r2=RHole,h=RHole*0.2);  //entry countersink
		color("magenta") cylinder(h = LShaft, r=RShaft, $fn=50);
		translate([0,0,LShaft]) {
			color("teal") cylinder(h=LFlange2+0.01, r=RFlange2, $fn=50); //Flange2 itself
			if (RFlange2>RShaft)   //make 45 degree cone so no support material is needed
				translate([0,0,-(RFlange2-RShaft)])
					color("teal")  cylinder(h=RFlange2-RShaft, r1=RShaft,r2=RFlange2, $fs=1); //
			translate([0,0,LFlange2]) {
				color("aqua") cylinder(h=LFlange+0.01, r=RFlange, $fs=1);
				translate([0,0,LFlange])
					axle(height=LSpline);
			}
		}
	}//union

	union() { //the holes
		translate([0,0,-0.01]) {
			cylinder(r1=RHole*1.2,r2=RHole*0.8,h=RHole*0.4,center=false);  //entry countersink
			if (HoleIsHex) {
				hexagon_prism(height=LHole,radius=RHex); //hole for hex spacer
			}else{
				intersection() { //to put a flat on side of round shafts
					cylinder(r=RHole,h=LHole,$fn=20);
					translate([-RHole, -RHole - HoleFlat, 0]) cube([2*RHole, 2*RHole,LHole]);
				}//intersect
			}//if
	                        translate([0,0,LHole-0.01])
	                        	cylinder(h=RHole, r1=RHole,r2=0.5    ); //put a cone on top of hole so no support needed
		}
	}//union
} //diff
