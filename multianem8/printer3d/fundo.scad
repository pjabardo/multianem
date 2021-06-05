$fa = 1;
$fs = 0.4;

err = 0.0001;
esp = 2.0;

d = 3.0;
L = 190.0;
W = 190.0;
L1 = 12.0;

// Dimensões da placa
Wb = 148.59;
Lb = 165.1;

gapy = (190-148.59) /2;

union(){
    difference(){
        translate([0,0,-esp+err])
        cube([L, W, esp]);
    
        translate([6, gapy+5.08, -10])
        cylinder(h=20, r=1.5);
        
        translate([6, gapy+Wb-5.08, -10])
        cylinder(h=20, r=1.5);

        translate([6+Lb-2*5.08, gapy+5.08, -10])
        cylinder(h=20, r=1.5);
           
        translate([6+Lb-2*5.08, gapy+Wb-5.08, -10])
        cylinder(h=20, r=1.5);
        
     }

    difference(){
       union(){
            cube([esp, L1+esp, L1]);
            cube([L1+esp, esp, L1]);
        }
     translate([L1+esp-6,-10, L1/2]) 
     rotate([-90,0,0])
     cylinder(h=20, r=1.5);

     translate([-10,L1+esp-6, L1/2]) 
     rotate([0,90,0])
     cylinder(h=20, r=1.5);
     
    }

translate([0,190,0])
rotate([0,0,-90])
    difference(){
       union(){
            cube([esp, L1+esp, L1]);
            cube([L1+esp, esp, L1]);
        }
     translate([L1+esp-6,-10, L1/2]) 
     rotate([-90,0,0])
     cylinder(h=20, r=1.5);

     translate([-10,L1+esp-6, L1/2]) 
     rotate([0,90,0])
     cylinder(h=20, r=1.5);
     
    }
    
translate([190,0,0])
rotate([0,0,90])
    difference(){
       union(){
            cube([esp, L1+esp, L1]);
            cube([L1+esp, esp, L1]);
        }
     translate([L1+esp-6,-10, L1/2]) 
     rotate([-90,0,0])
     cylinder(h=20, r=1.5);

     translate([-10,L1+esp-6, L1/2]) 
     rotate([0,90,0])
     cylinder(h=20, r=1.5);
     
    }
    
    
translate([190,190,0])
rotate([0,0,-180])
    difference(){
       union(){
            cube([esp, L1+esp, L1]);
            cube([L1+esp, esp, L1]);
        }
     translate([L1+esp-6,-10, L1/2]) 
     rotate([-90,0,0])
     cylinder(h=20, r=1.5);

     translate([-10,L1+esp-6, L1/2]) 
     rotate([0,90,0])
     cylinder(h=20, r=1.5);
     
    }
    
}
