// pinnacle [architecture] v.1
// (c) Jorge Medal (@oblomobka) 2015.11
// GPL license

use <oblomobka/functions.scad>
use <oblomobka/shapes.scad>
use <oblomobka/solids.scad>

// Módulos
module pinnacle_side (  n=4,
                        h=40,
                        side1=30,
                        side2=3,
                        f=56 //[0:100]
                        ){
                            
h_sup=h/1.05;
h_inf=h/4;
factor_h=h_inf+f*((h_sup-h_inf)/100);
                            
union(){
    pyramid_side (n=n, s1=side1, s2=side2, h=factor_h);
    if(n%2==0){
        cylinder (r1=apothem_side(side1,n), r2=apothem_side(side2,n), h=h, $fn=n*2);
	}
	else{
		rotate([0,0,90/n])
			cylinder (r1=apothem_side(side1,n), r2=apothem_side(side2,n), h=h, $fn=n*2);
		}
    } 
}

module pinnacle_circumscribed (     n=4,
                                    h=40,
                                    d1=20,
                                    d2=0,
                                    f=50 //[0:100]
                                    ){
                            
h_sup=h/1.05;
h_inf=h/4;
factor_h=h_inf+f*((h_sup-h_inf)/100);
                                        
grieta=0;                                        
                            
union(){
    difference(){
        pyramid_circumscribed (n=n, d1=d1, d2=d2, h=factor_h);
        if(n%2==0){
        cylinder (d1=d1, d2=d2+grieta, h=h, $fn=n*2);
	}
	else{
		rotate([0,0,90/n])
			cylinder (d1=d1, d2=d2+grieta, h=h, $fn=n*2);
		}
    }
    if(n%2==0){
        cylinder (d1=d1, d2=d2, h=h, $fn=n*2);
	}
	else{
		rotate([0,0,90/n])
			cylinder (d1=d1, d2=d2, h=h, $fn=n*2);
		}
    } 
}

                    
// Ejemplos
translate([40,0,0])
    pinnacle_side(n=3,h=35,side1=25,side2=5,f=50);

pinnacle_circumscribed(n=4,h=40,d1=30,d2=3,f=80);