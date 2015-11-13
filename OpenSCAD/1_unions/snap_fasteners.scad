// snap fasteners [UNIONS] v.04
// (c) Jorge Medal (@oblomobka)  2015.09
// GPL license

// Librerías que siguen una ruta relativa a este archivo
include <../2_helpers/external_elements.scad>
use <../2_helpers/external_elements_modules.scad>

// Librerías que deben instalarse en Built-In library location
// según https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Libraries 
// Se pueden encontrar aquí -> https://github.com/oblomobka/OpenSCAD/tree/master/libraries
include <oblomobka/constants.scad>
use <oblomobka/functions.scad>
use <oblomobka/transformations.scad>
use <oblomobka/solids.scad>

// BOTONES AUTOMÁTICOS
// representa el volumen del botn que se debe eliminar de la pieza donde pegara dando calor con un soldador
module snap_fasteners (    model=PRYM_SNAP_FASTENERS_11,
                           type=PLUG                    // type=PLUG -> tipo macho de la conexion
                                                        // type=SOCKET -> tipo hembra de la conexión
                                                        // (Press Fastenner) Tipo de botón automático
                           ){										
    $fn=50;

    h_plug=model[5];
    h_socket=model[1];
    h_socket_int=model[3];                           
    d_plug=model[4];
    d_socket=model[0];
    d_socket_int=model[2];                           
                               
    if(model[8]==0){
        if(type==0){    // socket
            translate([0,0,-0.1])
                cylinder (r=d_socket/2,h=h_socket*3/4);
            }
        else{           // plug
            if(type==1){
                translate([0,0,-0.1])
                    cylinder (r=d_plug/2,h=h_plug*3/4);
                }
            }
        }
    if(model[8]==1){
        if(type==0){    // socket
            translate([0,0,-0.1]){
                cylinder (r=d_socket/2,h=h_socket*3/4);
                cylinder (r=d_socket_int/2,h=h_socket_int+1);
            }
                
            }
        else{           // plug
            if(type==1){
                translate([0,0,-0.1])
                    cylinder (r=d_plug/2,h=h_plug*3/4);
                }
            }
        
    }
    
}


// El rebaje para el botón se realiza sobre una base que se puede introducir manualmente en una pieza
module snap_fasteners_base (   model=PRYM_SNAP_FASTENERS_11,
                               type=PLUG,                   // type=PLUG -> tipo macho de la conexion
                                                            // type=SOCKET -> tipo hembra de la conexión
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


// EJEMPLOS
i=25;
lado=20;

rotate([180,0,0])
fastener(   model=PRYM_SNAP_FASTENERS_11,
            type=PLUG);

difference(){
	translate([0,0,lado/2])
		cube([lado,lado,lado],center=true);
        snap_fasteners(model=PRYM_SNAP_FASTENERS_11, type=SOCKET);
        translate([0,0,lado])rotate([0,180,0])
            snap_fasteners(model=PRYM_SNAP_FASTENERS_17, type=SOCKET);
        translate([lado/2,0,lado/2])rotate([0,-90,0])
            snap_fasteners(model=PRYM_RING_FASTENERS_11, type=SOCKET);
        translate([0,lado/2,lado/2])rotate([90,90,0])
            snap_fasteners(model=PONTEJOS_RING_FASTENERS_12, type=PLUG);
        translate([-lado/2,0,lado/2])rotate([0,90,0])
            snap_fasteners(model=PRYM_SNAP_FASTENERS_17, type=PLUG);
        translate([0,-lado/2,lado/2])rotate([-90,90,0])
            snap_fasteners(model=PRYM_SNAP_FASTENERS_11, type=PLUG);
}


translate([0,i,0]){
    translate([i,0,0]){
        snap_fasteners_base (model=PRYM_SNAP_FASTENERS_11, type=SOCKET, base=[15,6,50]);
        *fastener( model=PRYM_SNAP_FASTENERS_11, type=SOCKET);
    }
    
    translate([0,0,0]){
        snap_fasteners_base (model=PRYM_SNAP_FASTENERS_11, type=PLUG, base=[15,6,50]);
        *fastener( model=PRYM_SNAP_FASTENERS_11, type=PLUG);
    }
    
    translate([2*i,0,0]){
        snap_fasteners_base (model=PONTEJOS_RING_FASTENERS_12, type=PLUG, base=[18,12,6]);
    }
    translate([3*i,0,0]){
        snap_fasteners_base (model=PONTEJOS_RING_FASTENERS_12, type=SOCKET, base=[18,12,6]);
    }
    translate([4*i,0,0]){
        snap_fasteners_base (model=PRYM_RING_FASTENERS_11, type=PLUG, base=[20,4,4]);
    }
    translate([5*i,0,0]){
        snap_fasteners_base (model=PRYM_RING_FASTENERS_11, type=SOCKET, base=[20,4,4]);
    }
}
