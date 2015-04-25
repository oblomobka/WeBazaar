// shaft [UNIONS] v.01
// (c) Jorge Medal (@oblomobka)  2015.04
// GPL license

include <../utilities/constants_oblomobka.scad>
include <helpers/presets.scad>
include <helpers/external_elements.scad>

use <../utilities/functions_oblomobka.scad>
use <../utilities/transformations_oblomobka.scad>
use <../utilities/solids_oblomobka.scad>

/////////////////////////////////
// HUECO PARA UNIONES EN PIEZAS SUELTAS
/////////////////////////////////
// Prisma para sustraer de una forma.
// Se sebe colocar donde se vaya que colocar la union
module shaft_base (	shaft=[15,4],		// Medidas generales de la union [diámetro de la base, altura de la base]
                    play=[0.5,0.2],	    // [juego del diámetro, juego de altura]
                    polygonal=50)	    // Forma del contenedor de la union. Cilindrico por defecto. El valor marca el polígono (circunscrito en la circunferencia de diametro_total pin[0]
							{

d=shaft[0];
h=shaft[1];
d_play=play[0];			
h_play=play[1];			

translate([0,0,-0.1])
	prism_circumscribed(n=polygonal,d=d+d_play,h=h+0.1+h_play);
}


/////////////////////////////////
// HUECO
/////////////////////////////////

// Crea un agujero para introducir todo tipo de tubos comunes como uniones(espigas de madera, muelles, tubos de pecera, lápices, ...)

module shaft (  shaft=[6,30],   // [diametro, longitud]
                deep=0.5,       // entre 0 - 1 || parte de la longitud que se aplicará sobrela pieza
                play=0          // juego entre piezas, define lo apretado u holgado que entra la union
                ){
                    
l=shaft[1];            
d=shaft[0]+0.25+play;       

translate([0,0,-0.1])
	union(){
		pyramid_circumscribed (d1=d+2,d2=d,h=1,n=6);
		translate([0,0,0.9])
			prism_circumscribed (d=d,h=l*lim(0,deep,1)+0.5,n=6);
		}	
}


/////////////////////////////////
// EJEMPLOS
/////////////////////////////////
i=30;


translate([0,0,0]){
    translate([0,0,0])
        shaft_base (shaft=[15,4], play=[0.5,0.2], polygonal=4   );

    translate([i,0,0])
        shaft_base (shaft=[20,2], play=[0.5,0.2], polygonal=8   );

    translate([2*i,0,0])
        difference(){
            translate([0,0,20/2])
                cube([20,20,20],center=true);
            translate([0,0,20])
                rotate([0,180,0])
                    shaft_base (shaft=[10,10], play=[0.5,0.2], polygonal=50   );
            }

    translate([3*i,0,0])
        shaft_base (shaft=[12,5], play=[0.5,0.2], polygonal=7   );
}


translate([0,i,0]){
    rotate([0,180,0])
    difference(){
        cylinder(r=15,h=20);
                shaft(shaft=[8,40],deep=0.4,play=0);
    }
    
  }
