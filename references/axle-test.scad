// Test objects for compatibility with LEGO(r) Technic axles
// and '+' shaped axle-holes
//
// NOTE regarding Patents: Since 1977 the LEGO Group has produced "Technic"
// elements with gear teeth, axles, axle-holes, and other features closely
// resembling the design(s) in this file, as part of their "Expert Builder"
// and "Technical Sets", now called "Technic" (see for example set 961,
// peeron.com/inv/sets/961-1?showpic=9288 ). By 1989 they had added pieces
// with rounded ends (see peeron.com/inv/sets/5264-1?showpic=8542 (set 5264
// from 1987) and peeron.com/inv/sets/5110-2?showpic=8543 (set 5110 from 1989))
// The object(s) produced by this SCAD file are different from real LEGO(r)
// elements, and any similarities of features, such as the shapes of axles
// and axle-holes, are functional in nature. The functions in question
// resemble those in LEGO patents that have already expired (or, if not
// patented, became prior art when the product(s) became available for
// purchase, i.e. 1989 at the latest). Nevertheless, one must not infringe
// on non-expired patents and any non-patent rights, such as LEGO(r)
// trademarks and brand identity. An example of such infringement would be
// to make objects and then try to "pass them off" as LEGO products. See
// for example the Kirkbi AG v. Ritvik Holdings Inc. case, (Supreme Court of
// Canada [2005] 3 S.C.R. 302).
//
// Originally created by Robert Munafo (mrob27 on Thingiverse)
//
// Instructions:
//  * Print this out on your 3D printer. It is two '+' shaped axles that taper
//    and are joined at the thickest end.
//
//  * Use a permanent marker to make some evenly-spaced marks. For example you
//    could make three marks on each half of the object, like this:
//   
//  1.4      1.6      1.8      2.0      2.2      2.0      1.8      1.6      1.4
//   +--------|--------|--------|--------X--------|--------|--------|--------+
//  end (thinnest)               middle (thickest)                     end (thinnest)
//
//    each '|' is a mark, and the numbers represent the nominal thickness (in
//    millimeters) at that point along the object.
//
// * Now try inserting both '+' shaped ends into a LEGO(r) element with a '+'
//   shaped hole. Because this object is tapered, it will not go in all the
//   way. Where it stops will depend on the precise details of how your 3D
//   printer creates objects shaped like this. Using the marks you made in step 2,
//   note where it stops, and convert this to a number. Use this number as the
//   value for the "X_thick" variable in other SCAD files that create
//   Technic-compatible axles.
//
// NOTE: The results you get here will not necessarily agree with the results you
// get for creating the HOLE that an axle fits into. Use the separate test object
// "xhole-test.scad" to calibrate how your printer deals with the inside dimensions
// of an '+' shaped hole.
//
//  20130106: first version.

jaggy_angle = 20;
lss = 7.99; // LEGO(r) Stud Spacing (see mrob.com/pub/mcg.html#lss )

// Outside diameter of axles is actually more like 4.8, but we want to make sure our
// test axles fit, so we make this a little smaller.
axle_diameter = 4.2;

// X_thick is the nominal thickness of one of the "arms" of the X-shaped cross
// section of a Technic axle. Using a micrometer, I measured about 1.8 millimeters.
//   However, if you use a 3D printer to make an object of a certain thickness, the
// actual result will be thicker or thinner than what you asked for. There are many
// factors that affect the results, including the type of material, the "resolution"
// of the printer, condition of the printer nozzle(s) and other key components,
// and perhaps even environmental factors such as ambient temperature.
//   So we make a tapered object, which can be used to figure out exactly how
// thick your 3D printer wants to make the object.

X_thick = 1.8;  // Nominal, "real" or "standard" dimension
min_X_thick = X_thick - 0.4;
max_X_thick = X_thick + 0.4;

// Make each end of the axle 8 studs long.
length = 8.0 * lss;

// We make two tapered axles, one is aligned with the X-Y-Z axes in a sensible way,
// but the other is skewed by 20 degrees to take advantage of jagged pixels.
// Jagged pixels give us more precise control over the actual thickness of an object.
for (j = [180, -jaggy_angle]) {
  rotate([0, j, 0]) {
    // The for(i) loop is to create two "rectangles" at right angles which combine to
    // make a '+'
    for (i = [j, j+90]) {
      rotate([i,0,0]) {
        // It only needs to taper along the length direction which is the X axis.
        // To make it taper we'll vary the Y coordinate a little bit. In the third
        // dimension (Z) there is no tapering so we can make our tapered shape by
        // simply extruding a trapezoid into the Z dimension.
        linear_extrude(height = axle_diameter,
                       center = true, convexity = 0, twist = 0) {
          polygon( points = [
            [-0.5,   -0.5 * max_X_thick],
            [length, -0.5 * min_X_thick],
            [length,  0.5 * min_X_thick],
            [-0.5,    0.5 * max_X_thick]
          ], convexity = 0);
        }
      }
    }
  }
}
