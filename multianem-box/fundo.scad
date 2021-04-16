$fa = 1;
$fs = 0.4;

esp = 3.0;
d = 0.001;
W = 88.9;
l = 5.08;
H = 102.0;
LL = 187.16;
Lmax=210;

union(){
    translate([0,0,-3+d])
        cube([Lmax, W+50,3]);
    
    translate([2+2+l,25,0])
    difference(){
        cylinder(h=20, r=4);
        cylinder(h=20+2*d, r=2.9/2);
    }
translate([2+2+l,25+W,0])
    difference(){
        cylinder(h=20, r=4);
        cylinder(h=20+2*d, r=2.9/2);
    }
translate([2+2+l+LL,25+W,0])
    difference(){
        cylinder(h=20, r=4);
        cylinder(h=20+2*d, r=2.9/2);
    }

translate([2+2+l+LL,25, 0])
    difference(){
        cylinder(h=20, r=4);
        cylinder(h=20+2*d, r=2.9/2);
    }
        
difference(){
    cube([12,12,H]);
    translate([2, 10, -d])
        cube([2+d, 2+d, H+2*d]);
    translate([10, 2, -d])
        cube([2+d, 2+d, H+2*d]);
    translate([5,5,-d])
        cylinder(h=H+2*d, r=2.9/2);
    
}

translate([0,W+50,0])
rotate([0,0,-90])
difference(){
    cube([12,12,H]);
    translate([2, 10, -d]){
        cube([2+d, 2+d, H+2*d]);
    }
translate([10, 2, -d]){
        cube([2+d, 2+d, H+2*d]);
    }
        
    translate([5,5,-d]){
        cylinder(h=H+2*d, r=2.9/2);
    }
}


translate([Lmax,0,0])
rotate([0,0,90])
difference(){
    cube([12,12,H]);
    translate([2, 10, -d]){
        cube([2+d, 2+d, H+2*d]);
    }
translate([10, 2, -d]){
        cube([2+d, 2+d, H+2*d]);
    }
        
    translate([5,5,-d]){
        cylinder(h=H+2*d, r=2.9/2);
    }
}

translate([Lmax,W+50,0])
rotate([0,0,180])
difference(){
    cube([12,12,H]);
    translate([2, 10, -d]){
        cube([2+d, 2+d, H+2*d]);
    }
translate([10, 2, -d]){
        cube([2+d, 2+d, H+2*d]);
    }
        
    translate([5,5,-d]){
        cylinder(h=H+2*d, r=2.9/2);
    }
}



}