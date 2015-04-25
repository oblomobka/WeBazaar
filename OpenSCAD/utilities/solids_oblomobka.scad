// Solids v.01
// (C) @oblomobka - 2015.04
// GPL licene

include <constants_oblomobka.scad>
include <functions_oblomobka.scad>
include <functions_ext.scad>

use <transformations_oblomobka.scad>
use <shapes_oblomobka.scad>

///////////////////////////////
// PRISMAS Y CONOS
///////////////////////////////
{
// Piramide con base circunscrita en un círculo definido en las variables
module pyramid_circumscribed (	n=4,		// nº lados de la base de la pirámide	
								d1=20,		// diámetro del círculo donde se circunscribe la base
								d2=0,		// diámetro del círculo donde se circunscribe la punta
								h=10		// altura de la pirámide
								){

if(n%2==0){
	rotate([0,0,180/n])
		cylinder (r1=r_apothem(d1/2,n), r2=d2/2/cos(180/n), h=h, $fn=n);
	}
	else{
		rotate([0,0,90/n])
			cylinder (r1=r_apothem(d1/2,n), r2=d2/2/cos(180/n), h=h, $fn=n);
		}

}

// Prisma con base circunscrita en un círculo definido en las variables
module prism_circumscribed (	n=4,		// nº lados de la base del prisma
                                d=20,		// diámetro del círculo donde se circunscribe el prisma
                                h=10		// altura del prisma
                                ){
    if(n%2==0){
        rotate([0,0,180/n])
            cylinder (r=r_apothem(d/2,n), h=h, $fn=n);
        }
        else{
            rotate([0,0,90/n])
                cylinder (r=r_apothem(d/2,n), h=h, $fn=n);
            }
    }

// Piramide construida por la longitud del lado de la base y la punta
module pyramid_side (	n=4,		// nº lados de la base de la pirámide	
						s1=20,		// longitud del lado en la base
						s2=0,		// longitud del lado en la punta
						h=10		// altura de la pirámide
						){

if(n%2==0){
	rotate([0,0,180/n])
		cylinder (r1=r_side(s1,n), r2=r_side(s2,n), h=h, $fn=n);
	}
	else{
		rotate([0,0,90/n])
			cylinder (r1=r_side(s1,n), r2=r_side(s2,n), h=h, $fn=n);
		}

}

// Prisma construido por la longitud del lado
module prism_side (	    n=4,		// nº lados de la base del prisma
                        s=20,		// longitud del lado
                        h=10		// altura del prisma
                        ){
    if(n%2==0){
        rotate([0,0,180/n])
            cylinder (r=r_side(s,n), h=h, $fn=n);
        }
        else{
            rotate([0,0,90/n])
                cylinder (r=r_side(s,n), h=h, $fn=n);
            }
    }

// Cono acabado en una esfera
module cone_sphere (    d1=20,      // diámetro de la base
                        d2=30,      // diámetro de la esfera (punta)
                        h=35
                        ){

    $fn=50;

    hull(){
        translate([0,0,h-d2/2])
			sphere(r=d2/2);
			cylinder(r1=d1/2,r2=0,h=h-d2/2);
        }
}

}
///////////////////////////////
// TUBOS
///////////////////////////////
{
// Definido por el diámetro exterior y la pared del tubo
module tubeOT (d,t,h,n=50){	
	difference(){
        prism_circumscribed (n=n,d=d,h=h);
        translate([0,0,-h])
            prism_circumscribed (n=n,d=d-2*t,h=3*h);
		}
}

// Definido por el diámetro de la línea neutra y la pared del tubo
module tubeNT (d,t,h,n=50){
	difference(){
		prism_circumscribed (d=d+t,h=h,n=n);
        translate([0,0,-h])
            prism_circumscribed(d=d-t,h=3*h,n=n);
	}
}

// Definido por el diámetro interior y la pared del tubo
module tubeIT (d,t,h,n=50){
	difference(){
		prism_circumscribed (d=d+2*t,h=h,n=n);
        translate([0,0,-h])
            prism_circumscribed(d=d,h=3*h,n=n);
	}
}

// Definido por el diámetro exterior y el diámetro interior
module tubeOI (d1,d2,h,n=50){
	difference(){
		prism_circumscribed (d=d1,h=h,n=n);
        translate([0,0,-h])
            prism_circumscribed(d=d2,h=3*h,n=n);	
		}
}



// Tubo general
    // el parámetro 'mode' indica como se formará el tubo
        // mode=1 --> tube=[diametro exterior, pared, altura, numero caras]
        // mode=2 --> tube=[diametro linea neutra, pared, altura, numero caras]
        // mode=3 --> tube=[diametro interior, pared, altura, numero caras]
        // mode=4 --> tube=[diametro exterior, diametro interior, altura, numero caras]
    // El parámetro 'extreme' define como será el extremo cuando la figura es abierta (angle<360)
        // extreme=0(false) --> extremo plano
        // extreme=1(true) --> extremo redondeado
module tube(tube=[25,5,10,50],angle=360,mode=1,extreme=true,res=32){

// Según sea el modo de construcción del tubo los 4 valores que definen el array 'tube' representarán cosas distintas
d=tube[0];  
t=tube[1];
h=tube[2];
n=tube[3];
    
//res_tube=32; // valor auxiliar. Cuando la pieza es abierta (angle < 360º) no se aceptan figuras prismaticas (valores bajos de n) por lo que se fija un valor de resolución del tubo con esta variable.
    
if(angle<=0 || angle>=360){

	if(mode==1){
        tubeOT(d=d,t=t,h=h,n=n);
        }
	else{
        if(mode==2){
            tubeNT(d=d,t=t,h=h,n=n);
            }
        else{
            if(mode==3){
                tubeIT(d=d,t=t,h=h,n=n);
                }
            else{
                if(mode==4){
                    tubeOI(d1=d,d2=t,h=h,n=n);
                    }
                }
            }
        }
    }
else{

	if(mode==1){
		union(){
			sector(angle,d*3,h)tubeOT(d=d,t=t,h=h,n=res);
			if(extreme==true || extreme==1){
				translate([d/2-t/2,0,0])cylinder(r=t/2,h=h,$fn=res);
				translate([(d/2-t/2)*cos(angle),(d/2-t/2)*sin(angle),0])cylinder(r=t/2,h=h,$fn=res);;
				}
			}
		}
	else{
    
		if(mode==2){
			union(){
				sector(angle,(d+t)*3,h)tubeNT(d=d,t=t,h=h,n=res);
				if(extreme==true || extreme==1){
					translate([d/2,0,0])cylinder(r=t/2,h=h,$fn=res);
					translate([d/2*cos(angle),d/2*sin(angle),0])cylinder(r=t/2,h=h,$fn=res);
					}
				}
			}
		else{
			if(mode==3){
				union(){
					sector(angle,d*3,h)tubeIT(d=d,t=t,h=h,n=res);
					if(extreme==true || extreme==1){
						translate([d/2+t/2,0,0])cylinder(r=t/2,h=h,$fn=res);
						translate([(d/2+t/2)*cos(angle),(d/2+t/2)*sin(angle),0])cylinder(r=t/2,h=h,$fn=res);
						}
					}
                }
            else{
                if(mode==4){
                    union(){
                        sector(angle,d*3,h)tubeOI(d1=d,d2=t,h=h,n=res);
                        if(extreme==true || extreme==1){
                            translate([d/2-(d-t)/4,0,0])cylinder(r=(d-t)/4,h=h,$fn=res);
                            translate([(d/2-(d-t)/4)*cos(angle),(d/2-(d-t)/4)*sin(angle),0])cylinder(r=(d-t)/4,h=h,$fn=res);
                            }
                        }
                    }
                }
            }
        }
    }
}



}
///////////////////////////////
// TRAPECIOS EN REVOLUCIÓN
///////////////////////////////
{
// Definido por el diámetro exterior que contendrá el trapecio descrito en el array
module trapezium_revolution_OT (	d=40,
                                    trapezium=[4,10,5], // [p1,p2,h]
                                    res=24
                                    ){

$fn=res;	
rotate_extrude(){
	translate([d/2-max(trapezium[0],trapezium[1])/2,0,0])
		trapezium (p1=trapezium[0],p2=trapezium[1],h=trapezium[2]);
	}
}


// Definido por el diámetro de la línea neutra y las medidas del trapecio
module  trapezium_revolution_NT (	d=10,
                                    trapezium=[2,5,12], // [p1,p2,h]
                                    res=24
                                    ){
$fn=res;	
rotate_extrude(){
	translate([d/2,0,0])
		trapezium (p1=trapezium[0],p2=trapezium[1],h=trapezium[2]);
	}
}


module trapezium_revolution (    d=40,
                                 trapezium=[20,10,10],
                                 angle=360,
                                 mode=1,
                                 extreme=true,
                                 res=16){

if(angle<=0 || angle>=360){
	if(mode==1){trapezium_revolution_OT(d=d,trapezium=trapezium,res=res);}
	else{if(mode==2){trapezium_revolution_NT(d=d,trapezium=trapezium,res=res);}}
	}

else{
	if(mode==1){
		union(){
			sector(angle,d,trapezium[2])
				trapezium_revolution_OT(d=d,trapezium=trapezium,res=res);
			if(extreme==true || extreme==1){
				translate([d/2-max(trapezium[0],trapezium[1])/2,0,-trapezium[2]/2])
					cylinder(r1=trapezium[0]/2,r2=trapezium[1]/2,h=trapezium[2],$fn=res);
				translate([(d/2-max(trapezium[0],trapezium[1])/2)*cos(angle),(d/2-max(trapezium[0],trapezium[1])/2)*sin(angle),-trapezium[2]/2])
					cylinder(r1=trapezium[0]/2,r2=trapezium[1]/2,h=trapezium[2],$fn=res);
				}
			}
		}
	else{
		if(mode==2){
			union(){
				sector(angle,d+max(trapezium[0],trapezium[1]),trapezium[2])
					trapezium_revolution_NT(d=d,trapezium=trapezium,res=res);
				if(extreme==true || extreme==1){
					translate([d/2,0,-trapezium[2]/2])	
						cylinder(r1=trapezium[0]/2,r2=trapezium[1]/2,h=trapezium[2],$fn=res);
					translate([(d/2)*cos(angle),(d/2)*sin(angle),-trapezium[2]/2])
						cylinder(r1=trapezium[0]/2,r2=trapezium[1]/2,h=trapezium[2],$fn=res);
					}
				}
			}
		}
	}
}

}


///////////////////////////////
// TOROS
///////////////////////////////
{
// Definido por el diámetro exterior y el diámetro del círculo en revolución
module torusOD (d1,d2,res){
$fn=res;	
rotate_extrude(){
	translate([d1/2-d2/2,0,0])
		circle(r=d2/2);
	}
}

// Definido por el diámetro de la línea neutra y el diámetro del círculo en revolución
module torusND (d1,d2,res){
$fn=res;	
rotate_extrude(){
	translate([d1/2,0,0])
		circle(r=d2/2);
	}
}
// Definido por el diámetro interior y el diámetro del círculo en revolución
module torusID (d1,d2,res){
$fn=res;	
rotate_extrude(){
	translate([d1/2+d2/2,0,0])
		circle(r=d2/2);
	}
}
// Definido por el diámetro exterior y el diámetro interior
module torusOI (d1,d2,res){
$fn=res;	
d=(d1-d2)/2;
rotate_extrude(){
	translate([d1/2-d/2,0,0])
		circle(r=d/2);
	}
}
// Toro general
    // el parámetro 'mode' indica como se formará el toro
        // mode=1 --> toro=[diametro exterior, diametro circulo en revolucion]
        // mode=2 --> toro=[diametro linea neutra, diametro circulo en revolucion]
        // mode=3 --> toro=[diametro interior, diametro circulo en revolucion]
        // mode=4 --> toro=[diametro exterior, diametro interior]
    // El parámetro 'extreme' define como será el extremo cuando la figura es abierta (angle<360)
        // extreme=0(false) --> extremo plano
        // extreme=1(true) --> extremo redondeado

module torus(torus=[20,5],angle=360,mode=1,extreme=true,res=32){

d1=torus[0];  
d2=torus[1];

if(angle<=0 || angle>=360){
	if(mode==1){torusOD(d1,d2,res=res);}
	else{if(mode==2){torusND(d1,d2,res=res);}
	else{if(mode==3){torusID(d1,d2,res=res);}
    else{if(mode==4){torusOI(d1,d2,res=res);}}}
	}}

else{
	if(mode==1){
		union(){
			sector(angle,d1,d2/2)torusOD(d1,d2,res=res);
			if(extreme==true || extreme==1){
				translate([d1/2-d2/2,0,0])sphere(d2/2,$fn=res);
				translate([(d1/2-d2/2)*cos(angle),(d1/2-d2/2)*sin(angle),0])sphere(d2/2,$fn=res);
				}
			}
		}
	else{
		if(mode==2){
			union(){
				sector(angle,d1+d2,d2/2)torusND(d1,d2,res=res);
				if(extreme==true || extreme==1){
					translate([d1/2,0,0])sphere(d2/2,$fn=res);
					translate([d1/2*cos(angle),d1/2*sin(angle),0])sphere(d2/2,$fn=res);
					}
				}
			}
		else{
			if(mode==3){
				union(){
					sector(angle,d1,d2/2)torusID(d1,d2,res=res);
                    if(extreme==true || extreme==1){
                        translate([d1/2+d2/2,0,0])sphere(d2/2,$fn=res);
                        translate([(d1/2+d2/2)*cos(angle),(d1/2+d2/2)*sin(angle),0])sphere(d2/2,$fn=res);
                        }
					}
				}
            else{
			if(mode==4){
                union(){
					sector(angle,d1,(d1-d2)/4)torusOI(d1,d2,res=res);
					if(extreme==true || extreme==1){
						translate([d1/2-(d1-d2)/4,0,0])sphere((d1-d2)/4,$fn=res);
						translate([(d1/2-(d1-d2)/4)*cos(angle),(d1/2-(d1-d2)/4)*sin(angle),0])sphere((d1-d2)/4,$fn=res);
						}
					}
				}
			}
		}
	}
}

}
}
///////////////////////////////
// EJEMPLOS
///////////////////////////////
{
i=50;
// EJEMPLO DE TOROS
translate([0,-2*i,0]){

translate([0,0,0])
torus(torus=[40,6],angle=210,mode=1,extreme=true,res=50);

translate([i,0,0])
torus(torus=[40,6],angle=120,mode=2,extreme=true,res=50);
    
translate([-i,0,0])
torus(torus=[40,6],angle=260,mode=3,extreme=true,res=50);

translate([2*i,0,0])
torus(torus=[40,24],angle=150,mode=4,extreme=true,res=50);

}

// EJEMPLOS DE TRAPECIOS EN REVOLUCIÓN
translate([0,-i,0]){

translate([0,0,0])
trapezium_revolution (d=25,trapezium=[9,6,4],angle=150,mode=2,extreme=1,res=50);

}
// EJEMPLOS DE TUBOS
translate([0,i,0]){
    
translate([0,0,0])
   tube(tube=[15,3,26],angle=290,mode=3,extreme=1,res=32);

translate([-i,0,0])    
    tubeOT (d=20,t=3,h=25,n=6);
    
translate([-2*i,0,0])    
    tubeNT (d=40,t=1,h=8);
    
translate([2*i,0,0])    
    tubeIT (d=20,t=6,h=16,n=5);
    
translate([i,0,0])    
    tubeOI (d1=20,d2=14,h=25,n=50);

}

// EJEMPLOS DE PRISMAS Y CONOS
translate([0,0,0]){

%prism_circumscribed(n=8,d=30,h=10);
rotate([0,0,180/8])
    cylinder (d=30,h=20,$fn=8);

translate([-i,0,0])
    pyramid_circumscribed(n=5,d1=30, d2=20, h=10);

translate([1*i,0,0])
    prism_side (n=5,s=10,h=15);

translate([2*i,0,0])
    pyramid_side (n=6, s1=25, s2=10, h=25);

translate([-2*i,0,0])
    cone_sphere (d1=30,d2=5,h=10);
}
}