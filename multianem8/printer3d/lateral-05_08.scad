$fa = 1;
$fs = 0.4;

err = 0.0001;
esp = 2.0;
R = 1.5;

D = 9.5;

e = (D - 8.3)/2;
L = 190.0;
W = 190.0;
H = 70;
L1 = 12.0;
fh = 0.6;

union(){
difference(){
    cube([W, H, esp]);
    
    translate([esp+L1/2, esp+L1/2,-10])
    cylinder(h=20, r=1.5);

    translate([W - esp-L1/2, esp+L1/2,-10])
    cylinder(h=20, r=1.5);

    translate([esp+L1/2, H-esp-L1/2,-10])
    cylinder(h=20, r=1.5);

    translate([W-esp-L1/2, H-esp-L1/2,-10])
    cylinder(h=20, r=1.5);



    translate([50,H*fh, -10])
    difference(){
        cylinder(h=20, r=D/2);

        translate([D/2-e, -D/2, -10])
        cube([D,D,40]);

        translate([-1.5*D+e, -D/2, -10])
        cube([D,D,40]);
    }

    translate([80,H*fh, -10])
    difference(){
        cylinder(h=20, r=D/2);

        translate([D/2-e, -D/2, -10])
        cube([D,D,40]);

        translate([-1.5*D+e, -D/2, -10])
        cube([D,D,40]);
    }

    translate([110,H*fh, -10])
    difference(){
        cylinder(h=20, r=D/2);

        translate([D/2-e, -D/2, -10])
        cube([D,D,40]);

        translate([-1.5*D+e, -D/2, -10])
        cube([D,D,40]);
    }

    translate([140,H*fh, -10])
    difference(){
        cylinder(h=20, r=D/2);

        translate([D/2-e, -D/2, -10])
        cube([D,D,40]);

        translate([-1.5*D+e, -D/2, -10])
        cube([D,D,40]);
    }
    
  //   translate([30, 55,-10])   
  //  cube([130,10,20]);


}
translate([50-D/3,H*fh-2*D, 0])
linear_extrude(1.6*esp)
    text("5");

translate([80-D/3,H*fh-2*D, 0])
linear_extrude(1.6*esp)
    text("6");

translate([110-D/3,H*fh-2*D, 0])
linear_extrude(1.6*esp)
    text("7");

translate([140-D/3,H*fh-2*D, 0])
linear_extrude(1.6*esp)
    text("8");

}


