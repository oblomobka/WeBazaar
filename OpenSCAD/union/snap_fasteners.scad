// snap fasteners [UNIONS] v.02
// (c) Jorge Medal (@oblomobka)  2015.04
// GPL license


include <../utilities/constants_oblomobka.scad>
include <helpers/presets.scad>
include <helpers/external_elements.scad>

use <../utilities/functions_oblomobka.scad>
use <../utilities/transformations_oblomobka.scad>
use <../utilities/solids_oblomobka.scad>

//////////////////////////////////////
// BOTONES AUTOMÁTICOS
//////////////////////////////////////

// representa el volumen del botn que se debe eliminar de la pieza donde pegara dando calor con un soldador
module snap_fasteners (    model=PRYM_SNAP_FASTENERS_11,
                           type=PLUG                    // type=plug -> tipo macho de la conexion
                                                        // type=socket -> tipo hembra de la conexión
                                                        // (Press Fastenner) Tipo de botón automático
                           ){										
$fn=50;

h=model[5];
d=model[0];
play=0.7;       // este ajuste hace una diferencia entre colocar el boton macho y el boton hembra. Puede variar segun el modelo

if(type==0){
    translate([0,0,-0.1])
		cylinder (r=d/2,h=h);
	}
else{
    if(type==1){
    translate([0,0,-0.1-play])
		cylinder (r=d/2,h=h);
	}}
}


// El rebaje para el botón se realiza sobre una base que se puede introducir manualmente en una pieza
module snap_fasteners_base (   model=PRYM_SNAP_FASTENERS_11,
                               type=PLUG,                   // type=plug -> tipo macho de la conexion
                                                                // type=socket -> tipo hembra de la conexión
                               base=[15,4,8]
                                    ){                     
                            
$fn=50;                            

difference(){
    // Dibuja la base
    union(){
        translate([0,0,-base[1]])pyramid_circumscribed(n=base[2],d2=base[0],d1=base[0]-1,h=1);
        translate([0,0,-base[1]+1])prism_circumscribed(n=base[2],d=base[0],h=base[1]-1);
        }
    // Resta el iman
    rotate([0,180,0])    
        snap_fasteners (model=model, type=type);
    }
                           
}


// Botón automático, No vale para imprimir, sólo representación
module fastener (   model=PRYM_SNAP_FASTENERS_11,
                    type=SOCKET
                    ){
    
$fn=24;

d1_socket=model[0];
h1_socket=model[1];
d2_socket=model[2];
h2_socket=model[3];
d1_plug=model[4];
h1_plug=model[5];
d2_plug=model[6];
h2_plug=model[7];
                        

if(type==0){
    color("grey",1)
    translate([0,0,-h1_socket])
		tubeOI (d1=d1_socket,d2=d2_socket-1,h=h1_socket);
	}
else{
    color("grey",1)
    if(type==1){
     translate([0,0,-h1_plug])
        cylinder (r=d1_plug/2,h=h1_plug);
     translate([0,0,h2_plug-d2_plug/2])
        sphere(d2_plug/2);
        cylinder (r=(d2_plug-0.5)/2,h=h2_plug-d2_plug/2);
        }
    }
}
    



//////////////////////////////////////
// EJEMPLOS
//////////////////////////////////////
i=20;
lado=20;

*fastener( model=PRYM_SNAP_FASTENERS_11,
           type=PLUG);

difference(){
	translate([0,0,lado/2])
		cube([lado,lado,lado],center=true);
        snap_fasteners(model=PRYM_SNAP_FASTENERS_11, type=PLUG);
        translate([0,0,lado])rotate([0,180,0])
            snap_fasteners(model=PRYM_SNAP_FASTENERS_11, type=SOCKET);
        translate([lado/2,0,lado/2])rotate([0,-90,0])
            snap_fasteners(model=PRYM_SNAP_FASTENERS_11, type=SOCKET);
        translate([0,lado/2,lado/2])rotate([90,90,0])
            snap_fasteners(model=PRYM_SNAP_FASTENERS_11, type=PLUG);
        translate([-lado/2,0,lado/2])rotate([0,90,0])
            snap_fasteners(model=PRYM_SNAP_FASTENERS_11, type=SOCKET);
        translate([0,-lado/2,lado/2])rotate([-90,90,0])
            snap_fasteners(model=PRYM_SNAP_FASTENERS_11, type=PLUG);
}

translate([0,i,0]){
    translate([2*i,0,0]){
        snap_fasteners_base (model=PRYM_SNAP_FASTENERS_11, type=SOCKET, base=[15,6,50]);
        fastener( model=PRYM_SNAP_FASTENERS_11,
           type=SOCKET);
    }
    
    translate([0,0,0]){
        snap_fasteners_base (model=PRYM_SNAP_FASTENERS_11, type=PLUG, base=[15,6,50]);
        fastener( model=PRYM_SNAP_FASTENERS_11,
           type=PLUG);
    }
    
    
}
