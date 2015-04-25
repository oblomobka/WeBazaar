// multilegs[OBLOBOTS]
// (c) Jorge Medal (@oblomobka) 2015.04 - v.12
// GPL license

include <../helpers/presets.scad>
include <../helpers/limits.scad>

use <../../../utilities/functions_oblomobka.scad>
use <../../../utilities/solids_oblomobka.scad>

use <parts.scad>

module multi_legs 	(	n=3,
						d_hip=[37.7,15],
						h_hip=[14,15],
						l_leg=[25,15],
						ang_leg=[00,60]
						){

// Parámetros con límites (los límites están fijados en un archivo externo)

d1_hip=lim(d1_hip_minmax[0],d_hip[0],d1_hip_minmax[1]);
d2_hip=lim(d2_hip_minmax[0],d_hip[1],d1_hip-5);

h1_hip=lim(h1_hip_minmax[0],h_hip[0],h1_hip_minmax[1]);
h2_hip=lim(h2_hip_minmax[0],h_hip[1],h2_hip_minmax[1]);

n_multilegs=lim(n_multilegs_minmax[0],n,n_multilegs_minmax[1]);

l1_leg=lim(l1_leg_minmax[0],l_leg[0],l1_leg_minmax[1]);
l2_leg=lim(l2_leg_minmax[0],l_leg[1],l2_leg_minmax[1]);

ang1_leg=lim(ang1_leg_minmax[0],ang_leg[0],ang1_leg_minmax[1]);
ang2_leg=lim(ang2_leg_minmax[0],ang_leg[1],ang2_leg_minmax[1]);

// Parámetros auxiliares

d_thigh=sqrt(pow((d1_hip-d2_hip)/2,2)+pow(h2_hip,2)); 		// define la longitud del lado inclianado de la cadera
ang_hip=atan2(h2_hip,(d1_hip-d2_hip)/2);


//	Volumen
//difference(){
    union(){
        hip(d1=d1_hip,d2=d2_hip,h1=h1_hip,h2=h2_hip,n=n_multilegs);
        if(n_multilegs%2==0){
            for(i=[0:n_multilegs-1]){
                rotate([0,0,i*360/n_multilegs])
                    translate([d1_hip/2-(d1_hip-d2_hip)/4,0,h2_hip/2])
                        rotate([0,ang_hip,0])
                            sphere_leg(d_thigh=d_thigh,l_thigh=l1_leg,l_tibia=l2_leg,ang_1=ang1_leg,ang_2=ang2_leg);
                }
            }
        else{
            for(i=[0:n_multilegs-1]){
                rotate([0,0,270/n_multilegs+i*360/n_multilegs])
                    translate([d1_hip/2-(d1_hip-d2_hip)/4,0,h2_hip/2])
                        rotate([0,ang_hip,0])
                        sphere_leg(d_thigh=d_thigh,l_thigh=l1_leg,l_tibia=l2_leg,ang_1=ang1_leg,ang_2=ang2_leg);
                }
            }
        }

//	Modulos auxiliares

// 	Cadera
module hip(d1=37.7,d2=20,h1=5,h2=10,n=3){


	difference(){
		union(){
			hull(){
				translate([0,0,0])
					prism_circumscribed(d=d2,h=1,n=n);
				translate([0,0,h2])
					cylinder(r=d1/2,h=h1-2);
				}
			translate([0,0,h1+h2-2])
				cylinder(r1=d1/2,r2=(d1-4)/2,h=2);
			}
		translate([0,0,-1.5])
		prism_circumscribed(d=(d2-4),h=3,n=n,center=true);
		}
	}

// Leg
module sphere_leg(d_thigh=20,l_thigh=25,l_tibia=22,ang_1=0,ang_2=0){

d_knee=2*d_thigh/3;
d_foot=d_thigh/2;

rotate([90,0,0])
union(){
	hull(){
		sphere(r=d_thigh/2);
		rotate([0,0,-ang_1])
			translate([l_thigh,0,0])
				sphere(r=(d_knee)/2);
		}
	rotate([0,0,-ang_1])
		translate([l_thigh,0,0])
			hull(){
				sphere(r=(d_knee)/2);
				rotate([0,0,-ang_2])
					translate([l_tibia,0,0])
						sphere(r=(d_foot)/2);
				}
        }
    }
// Fin de módulos auxiliares
}



//////////////////////////////////
// EJEMPLOS
//////////////////////////////////

i=100;

translate([0,0,0])
multi_legs(	n=4,
			d_hip=[50,20],
			h_hip=[14,15],
			l_leg=[20,15],
			ang_leg=[20,25]);

translate([i,0,0])
multi_legs(	n=6,
			d_hip=[40,30],
			h_hip=[7,5],
			l_leg=[20,15],
			ang_leg=[0,45]);
            
translate([-i,0,0])
multi_legs(	n=5,
			d_hip=[32,20],
			h_hip=[2,5],
			l_leg=[10,15],
			ang_leg=[40,5]);


