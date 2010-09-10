module base() {
  //This is Rapman base
  axis_m5 = dxf_cross(file = "tool_holder.dxf", 
                      layer = "axis_m5");
  difference() {
    union() {
      linear_extrude(file = "tool_holder.dxf", 
                     layer = "base", height = 5, 
                     convexity = 2, $fn=100);
      linear_extrude(file = "tool_holder.dxf", 
                     layer = "limit", height = 5, 
                     convexity = 2);
      translate([axis_m5[0], axis_m5[1], 1]) 
        cylinder(h=16, r=7);
      translate([axis_m5[0]-5,axis_m5[1]+25,5]) 
        rotate([90,0,-13]) cylinder(h=22,r=2);
      translate([axis_m5[0]+8,axis_m5[1]+36,5]) 
        rotate([90,0,-13]) cylinder(h=30,r=2);
      translate([axis_m5[0]+16,axis_m5[1]+32,5]) 
        rotate([90,0,-13]) cylinder(h=35,r=2);
      translate([axis_m5[0]+26,axis_m5[1]+45,5]) 
        rotate([90,0,-13]) cylinder(h=45,r=2);
    }
    translate([axis_m5[0],axis_m5[1],-10]) 
      cylinder(h=40, r=2.5);    
    translate([0,0,-1]) 
      linear_extrude(file = "tool_holder.dxf", 
                     layer = "m5", height = 7, 
                     convexity = 2);
    translate([0,0,11]) 
      linear_extrude(file = "tool_holder.dxf", 
                     layer = "m5", height = 7, 
                     convexity = 2);
    translate([0,0,-10]) 
      linear_extrude(file = "tool_holder.dxf", 
                     layer = "turnhole", height = 55, 
                     convexity = 2);
  }
}

module base_hole() {
    translate([0,0,-10]) 
      linear_extrude(file = "tool_holder.dxf", 
                     layer = "attachement", height = 18, 
                     convexity = 2);
    translate([0,0,5]) 
      linear_extrude(file = "tool_holder.dxf", 
                     layer = "attachementm5", height = 6, 
                     convexity = 2);
}

module m4_hole(alpha) {
  axis_m4 = dxf_cross(file="dremel.dxf", 
                      layer="axis_m4");	
  rotate([90,0,alpha])
    union() {
      linear_extrude(file="dremel.dxf", 
                     layer = "m4_hole",
                     height = 8, convexity = 2);
      translate([axis_m4[0],axis_m4[1],1]) 
        cylinder(h=39, r=2, $fn=10);
    }
}

module drive() {
  difference() {
    cube([25,51,28]);
    translate([24,30,10]) cylinder(r=11, h=6+1);
    translate([-1,16,5]) m4_hole(90);
    translate([-1,16,13+5]) m4_hole(90);
    translate([-1,18+25,5]) m4_hole(90);
    translate([-1,18+25,13+5]) m4_hole(90);

    translate([13,30,22]) cylinder(r=11, h=6+1);
    translate([13,30,-1]) cylinder(r=11, h=6+1);
    translate([13,30,-1]) cylinder(r=4.5, h=35);

  }
}

module motor_holder() {
  difference() {
    translate([-57,0,0]) cube([57,51,5]);
    translate([-57+5,14,0]) cube([16,3,6]);
    translate([-57+5+31,14,0]) cube([16,3,6]);
    translate([-57+5,14+31,0]) cube([16,3,6]);
    translate([-57+5+31,14+31,0]) cube([16,3,6]);

    translate([-57+5+31,14+17,0]) cylinder(r=10, h=6);
    translate([-57+5+15,14+17,0]) cylinder(r=10, h=6);
 
    translate([-39,21,0]) cube([20,20,6]);
  }
}

module main() {
difference() {
  union() {
    drive();
    motor_holder();
    translate([13,0,13]) rotate([270,0,0]) rotate([0,0,240]) 
      base();
  }
  translate([13,100,13]) rotate([90,0,0]) 
    cylinder(r=2, h=190, $fn=100);
  translate([13,0,13]) rotate([270,0,0]) rotate([0,0,240]) 
      base_hole();
}
}

rotate([90,0,0]) main();