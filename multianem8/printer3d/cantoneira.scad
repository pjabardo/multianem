$fa = 1;
$fs = 0.4;

err = 0.0001;
esp = 3.0;
R = 1.5;

D = 9.5;

e = (D - 8.3)/2;
L = 190.0;
W = 190.0;
H = 80;
L1 = 12.0;



union(){
translate([-5, 0, 0])
rotate([0, -90, 0])
difference(){
union(){
    cube([esp, H, esp+L1]);
    cube([esp+L1, esp, esp+L1]);
    cube([esp+L1, H, esp]);
    
    translate([0, H-esp, 0])
    cube([esp+L1, esp, esp+L1]);
    
}

translate([esp+L1/2, esp+L1/2, -10])    
cylinder(h=20, r=1.5);

translate([esp+L1/2, H-esp-L1/2, -10])    
cylinder(h=20, r=1.5);

translate([esp+L1/2, -10, esp+L1/2])    
rotate([-90,0,0])
cylinder(h=20, r=1.5);

translate([esp+L1/2, H-10, esp+L1/2])    
rotate([-90,0,0])
cylinder(h=20, r=1.5);

translate([-10, esp+L1/2,  esp+L1/2])    
rotate([0, 90,0])
cylinder(h=20, r=1.5);

translate([-10, H-esp-L1/2,  esp+L1/2])    
rotate([0, 90,0])
cylinder(h=20, r=1.5);

}




difference(){
union(){
    cube([esp, H, esp+L1]);
    cube([esp+L1, esp, esp+L1]);
    cube([esp+L1, H, esp]);
    
    translate([0, H-esp, 0])
    cube([esp+L1, esp, esp+L1]);
    
}

translate([esp+L1/2, esp+L1/2, -10])    
cylinder(h=20, r=1.5);

translate([esp+L1/2, H-esp-L1/2, -10])    
cylinder(h=20, r=1.5);

translate([esp+L1/2, -10, esp+L1/2])    
rotate([-90,0,0])
cylinder(h=20, r=1.5);

translate([esp+L1/2, H-10, esp+L1/2])    
rotate([-90,0,0])
cylinder(h=20, r=1.5);

translate([-10, esp+L1/2,  esp+L1/2])    
rotate([0, 90,0])
cylinder(h=20, r=1.5);

translate([-10, H-esp-L1/2,  esp+L1/2])    
rotate([0, 90,0])
cylinder(h=20, r=1.5);

}


translate([-5, H+5, 0])
rotate([0, -90, 0])
difference(){
union(){
    cube([esp, H, esp+L1]);
    cube([esp+L1, esp, esp+L1]);
    cube([esp+L1, H, esp]);
    
    translate([0, H-esp, 0])
    cube([esp+L1, esp, esp+L1]);
    
}

translate([esp+L1/2, esp+L1/2, -10])    
cylinder(h=20, r=1.5);

translate([esp+L1/2, H-esp-L1/2, -10])    
cylinder(h=20, r=1.5);

translate([esp+L1/2, -10, esp+L1/2])    
rotate([-90,0,0])
cylinder(h=20, r=1.5);

translate([esp+L1/2, H-10, esp+L1/2])    
rotate([-90,0,0])
cylinder(h=20, r=1.5);

translate([-10, esp+L1/2,  esp+L1/2])    
rotate([0, 90,0])
cylinder(h=20, r=1.5);

translate([-10, H-esp-L1/2,  esp+L1/2])    
rotate([0, 90,0])
cylinder(h=20, r=1.5);

}


translate([0,H+5,0])
difference(){
union(){
    cube([esp, H, esp+L1]);
    cube([esp+L1, esp, esp+L1]);
    cube([esp+L1, H, esp]);
    
    translate([0, H-esp, 0])
    cube([esp+L1, esp, esp+L1]);
    
}

translate([esp+L1/2, esp+L1/2, -10])    
cylinder(h=20, r=1.5);

translate([esp+L1/2, H-esp-L1/2, -10])    
cylinder(h=20, r=1.5);

translate([esp+L1/2, -10, esp+L1/2])    
rotate([-90,0,0])
cylinder(h=20, r=1.5);

translate([esp+L1/2, H-10, esp+L1/2])    
rotate([-90,0,0])
cylinder(h=20, r=1.5);

translate([-10, esp+L1/2,  esp+L1/2])    
rotate([0, 90,0])
cylinder(h=20, r=1.5);

translate([-10, H-esp-L1/2,  esp+L1/2])    
rotate([0, 90,0])
cylinder(h=20, r=1.5);

}
}




// Nova conjunto
translate([40,0,0])
union(){
translate([-5, 0, 0])
rotate([0, -90, 0])
difference(){
union(){
    cube([esp, H, esp+L1]);
    cube([esp+L1, esp, esp+L1]);
    cube([esp+L1, H, esp]);
    
    translate([0, H-esp, 0])
    cube([esp+L1, esp, esp+L1]);
    
}

translate([esp+L1/2, esp+L1/2, -10])    
cylinder(h=20, r=1.5);

translate([esp+L1/2, H-esp-L1/2, -10])    
cylinder(h=20, r=1.5);

translate([esp+L1/2, -10, esp+L1/2])    
rotate([-90,0,0])
cylinder(h=20, r=1.5);

translate([esp+L1/2, H-10, esp+L1/2])    
rotate([-90,0,0])
cylinder(h=20, r=1.5);

translate([-10, esp+L1/2,  esp+L1/2])    
rotate([0, 90,0])
cylinder(h=20, r=1.5);

translate([-10, H-esp-L1/2,  esp+L1/2])    
rotate([0, 90,0])
cylinder(h=20, r=1.5);

}




difference(){
union(){
    cube([esp, H, esp+L1]);
    cube([esp+L1, esp, esp+L1]);
    cube([esp+L1, H, esp]);
    
    translate([0, H-esp, 0])
    cube([esp+L1, esp, esp+L1]);
    
}

translate([esp+L1/2, esp+L1/2, -10])    
cylinder(h=20, r=1.5);

translate([esp+L1/2, H-esp-L1/2, -10])    
cylinder(h=20, r=1.5);

translate([esp+L1/2, -10, esp+L1/2])    
rotate([-90,0,0])
cylinder(h=20, r=1.5);

translate([esp+L1/2, H-10, esp+L1/2])    
rotate([-90,0,0])
cylinder(h=20, r=1.5);

translate([-10, esp+L1/2,  esp+L1/2])    
rotate([0, 90,0])
cylinder(h=20, r=1.5);

translate([-10, H-esp-L1/2,  esp+L1/2])    
rotate([0, 90,0])
cylinder(h=20, r=1.5);

}


translate([-5, H+5, 0])
rotate([0, -90, 0])
difference(){
union(){
    cube([esp, H, esp+L1]);
    cube([esp+L1, esp, esp+L1]);
    cube([esp+L1, H, esp]);
    
    translate([0, H-esp, 0])
    cube([esp+L1, esp, esp+L1]);
    
}

translate([esp+L1/2, esp+L1/2, -10])    
cylinder(h=20, r=1.5);

translate([esp+L1/2, H-esp-L1/2, -10])    
cylinder(h=20, r=1.5);

translate([esp+L1/2, -10, esp+L1/2])    
rotate([-90,0,0])
cylinder(h=20, r=1.5);

translate([esp+L1/2, H-10, esp+L1/2])    
rotate([-90,0,0])
cylinder(h=20, r=1.5);

translate([-10, esp+L1/2,  esp+L1/2])    
rotate([0, 90,0])
cylinder(h=20, r=1.5);

translate([-10, H-esp-L1/2,  esp+L1/2])    
rotate([0, 90,0])
cylinder(h=20, r=1.5);

}


translate([0,H+5,0])
difference(){
union(){
    cube([esp, H, esp+L1]);
    cube([esp+L1, esp, esp+L1]);
    cube([esp+L1, H, esp]);
    
    translate([0, H-esp, 0])
    cube([esp+L1, esp, esp+L1]);
    
}

translate([esp+L1/2, esp+L1/2, -10])    
cylinder(h=20, r=1.5);

translate([esp+L1/2, H-esp-L1/2, -10])    
cylinder(h=20, r=1.5);

translate([esp+L1/2, -10, esp+L1/2])    
rotate([-90,0,0])
cylinder(h=20, r=1.5);

translate([esp+L1/2, H-10, esp+L1/2])    
rotate([-90,0,0])
cylinder(h=20, r=1.5);

translate([-10, esp+L1/2,  esp+L1/2])    
rotate([0, 90,0])
cylinder(h=20, r=1.5);

translate([-10, H-esp-L1/2,  esp+L1/2])    
rotate([0, 90,0])
cylinder(h=20, r=1.5);

}
}



// Nova conjunto
translate([80,0,0])
union(){
translate([-5, 0, 0])
rotate([0, -90, 0])
difference(){
union(){
    cube([esp, H, esp+L1]);
    cube([esp+L1, esp, esp+L1]);
    cube([esp+L1, H, esp]);
    
    translate([0, H-esp, 0])
    cube([esp+L1, esp, esp+L1]);
    
}

translate([esp+L1/2, esp+L1/2, -10])    
cylinder(h=20, r=1.5);

translate([esp+L1/2, H-esp-L1/2, -10])    
cylinder(h=20, r=1.5);

translate([esp+L1/2, -10, esp+L1/2])    
rotate([-90,0,0])
cylinder(h=20, r=1.5);

translate([esp+L1/2, H-10, esp+L1/2])    
rotate([-90,0,0])
cylinder(h=20, r=1.5);

translate([-10, esp+L1/2,  esp+L1/2])    
rotate([0, 90,0])
cylinder(h=20, r=1.5);

translate([-10, H-esp-L1/2,  esp+L1/2])    
rotate([0, 90,0])
cylinder(h=20, r=1.5);

}




difference(){
union(){
    cube([esp, H, esp+L1]);
    cube([esp+L1, esp, esp+L1]);
    cube([esp+L1, H, esp]);
    
    translate([0, H-esp, 0])
    cube([esp+L1, esp, esp+L1]);
    
}

translate([esp+L1/2, esp+L1/2, -10])    
cylinder(h=20, r=1.5);

translate([esp+L1/2, H-esp-L1/2, -10])    
cylinder(h=20, r=1.5);

translate([esp+L1/2, -10, esp+L1/2])    
rotate([-90,0,0])
cylinder(h=20, r=1.5);

translate([esp+L1/2, H-10, esp+L1/2])    
rotate([-90,0,0])
cylinder(h=20, r=1.5);

translate([-10, esp+L1/2,  esp+L1/2])    
rotate([0, 90,0])
cylinder(h=20, r=1.5);

translate([-10, H-esp-L1/2,  esp+L1/2])    
rotate([0, 90,0])
cylinder(h=20, r=1.5);

}


translate([-5, H+5, 0])
rotate([0, -90, 0])
difference(){
union(){
    cube([esp, H, esp+L1]);
    cube([esp+L1, esp, esp+L1]);
    cube([esp+L1, H, esp]);
    
    translate([0, H-esp, 0])
    cube([esp+L1, esp, esp+L1]);
    
}

translate([esp+L1/2, esp+L1/2, -10])    
cylinder(h=20, r=1.5);

translate([esp+L1/2, H-esp-L1/2, -10])    
cylinder(h=20, r=1.5);

translate([esp+L1/2, -10, esp+L1/2])    
rotate([-90,0,0])
cylinder(h=20, r=1.5);

translate([esp+L1/2, H-10, esp+L1/2])    
rotate([-90,0,0])
cylinder(h=20, r=1.5);

translate([-10, esp+L1/2,  esp+L1/2])    
rotate([0, 90,0])
cylinder(h=20, r=1.5);

translate([-10, H-esp-L1/2,  esp+L1/2])    
rotate([0, 90,0])
cylinder(h=20, r=1.5);

}


translate([0,H+5,0])
difference(){
union(){
    cube([esp, H, esp+L1]);
    cube([esp+L1, esp, esp+L1]);
    cube([esp+L1, H, esp]);
    
    translate([0, H-esp, 0])
    cube([esp+L1, esp, esp+L1]);
    
}

translate([esp+L1/2, esp+L1/2, -10])    
cylinder(h=20, r=1.5);

translate([esp+L1/2, H-esp-L1/2, -10])    
cylinder(h=20, r=1.5);

translate([esp+L1/2, -10, esp+L1/2])    
rotate([-90,0,0])
cylinder(h=20, r=1.5);

translate([esp+L1/2, H-10, esp+L1/2])    
rotate([-90,0,0])
cylinder(h=20, r=1.5);

translate([-10, esp+L1/2,  esp+L1/2])    
rotate([0, 90,0])
cylinder(h=20, r=1.5);

translate([-10, H-esp-L1/2,  esp+L1/2])    
rotate([0, 90,0])
cylinder(h=20, r=1.5);

}
}





// Nova conjunto
translate([120,0,0])
union(){
translate([-5, 0, 0])
rotate([0, -90, 0])
difference(){
union(){
    cube([esp, H, esp+L1]);
    cube([esp+L1, esp, esp+L1]);
    cube([esp+L1, H, esp]);
    
    translate([0, H-esp, 0])
    cube([esp+L1, esp, esp+L1]);
    
}

translate([esp+L1/2, esp+L1/2, -10])    
cylinder(h=20, r=1.5);

translate([esp+L1/2, H-esp-L1/2, -10])    
cylinder(h=20, r=1.5);

translate([esp+L1/2, -10, esp+L1/2])    
rotate([-90,0,0])
cylinder(h=20, r=1.5);

translate([esp+L1/2, H-10, esp+L1/2])    
rotate([-90,0,0])
cylinder(h=20, r=1.5);

translate([-10, esp+L1/2,  esp+L1/2])    
rotate([0, 90,0])
cylinder(h=20, r=1.5);

translate([-10, H-esp-L1/2,  esp+L1/2])    
rotate([0, 90,0])
cylinder(h=20, r=1.5);

}




difference(){
union(){
    cube([esp, H, esp+L1]);
    cube([esp+L1, esp, esp+L1]);
    cube([esp+L1, H, esp]);
    
    translate([0, H-esp, 0])
    cube([esp+L1, esp, esp+L1]);
    
}

translate([esp+L1/2, esp+L1/2, -10])    
cylinder(h=20, r=1.5);

translate([esp+L1/2, H-esp-L1/2, -10])    
cylinder(h=20, r=1.5);

translate([esp+L1/2, -10, esp+L1/2])    
rotate([-90,0,0])
cylinder(h=20, r=1.5);

translate([esp+L1/2, H-10, esp+L1/2])    
rotate([-90,0,0])
cylinder(h=20, r=1.5);

translate([-10, esp+L1/2,  esp+L1/2])    
rotate([0, 90,0])
cylinder(h=20, r=1.5);

translate([-10, H-esp-L1/2,  esp+L1/2])    
rotate([0, 90,0])
cylinder(h=20, r=1.5);

}


translate([-5, H+5, 0])
rotate([0, -90, 0])
difference(){
union(){
    cube([esp, H, esp+L1]);
    cube([esp+L1, esp, esp+L1]);
    cube([esp+L1, H, esp]);
    
    translate([0, H-esp, 0])
    cube([esp+L1, esp, esp+L1]);
    
}

translate([esp+L1/2, esp+L1/2, -10])    
cylinder(h=20, r=1.5);

translate([esp+L1/2, H-esp-L1/2, -10])    
cylinder(h=20, r=1.5);

translate([esp+L1/2, -10, esp+L1/2])    
rotate([-90,0,0])
cylinder(h=20, r=1.5);

translate([esp+L1/2, H-10, esp+L1/2])    
rotate([-90,0,0])
cylinder(h=20, r=1.5);

translate([-10, esp+L1/2,  esp+L1/2])    
rotate([0, 90,0])
cylinder(h=20, r=1.5);

translate([-10, H-esp-L1/2,  esp+L1/2])    
rotate([0, 90,0])
cylinder(h=20, r=1.5);

}


translate([0,H+5,0])
difference(){
union(){
    cube([esp, H, esp+L1]);
    cube([esp+L1, esp, esp+L1]);
    cube([esp+L1, H, esp]);
    
    translate([0, H-esp, 0])
    cube([esp+L1, esp, esp+L1]);
    
}

translate([esp+L1/2, esp+L1/2, -10])    
cylinder(h=20, r=1.5);

translate([esp+L1/2, H-esp-L1/2, -10])    
cylinder(h=20, r=1.5);

translate([esp+L1/2, -10, esp+L1/2])    
rotate([-90,0,0])
cylinder(h=20, r=1.5);

translate([esp+L1/2, H-10, esp+L1/2])    
rotate([-90,0,0])
cylinder(h=20, r=1.5);

translate([-10, esp+L1/2,  esp+L1/2])    
rotate([0, 90,0])
cylinder(h=20, r=1.5);

translate([-10, H-esp-L1/2,  esp+L1/2])    
rotate([0, 90,0])
cylinder(h=20, r=1.5);

}
}



