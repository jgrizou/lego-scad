// 5 Basic dimensions

hori_pitch=8; //The horizontal pitch, or distance between knobs:  8mm.

vert_pitch=9.6; //The vertical pitch, or height of a classic brick:  9.6mm.

play=0.1; //The horizontal tolerance:  0.1mm. This is half the gap between bricks in the horizontal plane.  The horizontal tolerance prevents friction between bricks during building.

axle_D=6*FLU; //This is also the diameter of axles and holes.  Actually a knob must be slightly larger and an axle slightly smaller (4.85 and 4.75 respectively, otherwise axles would not turn in bearing holes and knobs would not stick in them) but we will ignore this difference here.

hole_D=4.8;

knob_h=1.8; //The height of a knob:  1.8mm

// ###########################################

FLU =0.8; // Fundamental Lego Unit

knob_D=6*FLU; //=4.8mm
knob_id=3.75*FLU; //=3mm
knob_innerD=3.25*FLU; //=2.8mm für Löcher im Stein unter den Knobs

plate_h=4*FLU; //3.2mm
brick_w=10*FLU; //=8mm
Wall=1.5*FLU;   //=1.2mm
Wall_Technic=1.875*FLU; //=1.5mm

cont_w=0.6;
cont_b=0.3;

Inner_cyl1_D=3.75*FLU; //=3mm
Inner_cyl2_r=6.51371/2;
Inner_cyl2_wall=0.75;


// ############################################
// Technic Dimensions #########################

axle_base=7.25*FLU; //The distance of axle holes from the base: 5.8mm This is in fact a derived number.

recess_D=7.75*FLU; // =6.2mm The diameter of the recess of a Technics hole:  6.0mm and the recess amount of the same.
