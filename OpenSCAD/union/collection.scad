// Muestrario [UNIONS] v.02
// (c) Jorge Medal (@oblomobka)  2015.08
// GPL license

include <../utilities/constants_oblomobka.scad>
include <helpers/presets.scad>
include <helpers/external_elements.scad>

use <../utilities/functions_oblomobka.scad>
use <../utilities/transformations_oblomobka.scad>
use <../utilities/solids_oblomobka.scad>

use <shaft.scad>
use <magnet.scad>
use <o_ring.scad>
use <pin.scad>
use <snap_fasteners.scad>
use <spike.scad>
use <suction_pad.scad>
use <total_joint.scad>

//create a dodecahedron by intersecting 6 boxes
module dodecahedron(height) {
    
angle_a=72;
angle_b=2*atan(PHI);     // PHI=(1+sqrt(5))/2;
    
    
        scale([height,height,height]) //scale by height parameter
            {
                intersection(){
                        //make a cube
                        cube([2,2,1], center = true); 
                        intersection_for(i=[0:4]) //loop i from 0 to 4, and intersect results
                        { 
                                //make a cube, rotate it 116.565 degrees around the X axis,
                                //then 72*i around the Z axis
                                rotate([0,0,72*i])
                                        rotate([angle_b,0,0])
                                        cube([2,2,1], center = true); 
                        }
                }
        }
}



// h del dodecaedrocorresponde con la esferainterior.
module POINT (h,face){

a=face[0];
b=face[1];
c=face[2];
    
//c == 0 ? h=h : h=h*-1;    

angle_b=2*atan(PHI);  
    
    //rotate([0,0,180*c])
    rotate([0,0,72*a])
    rotate([180*c+angle_b*b,0,0])
    translate([0,0,-h/2])
    children();
}

// Los 12 arrays que convierten el modulo POINT en el centro de cada cara del dodecaedro
// Servirán para posicionar elementos
FACE_1=[0,0,0];
FACE_2=[0,1,0];
FACE_3=[1,1,0];
FACE_4=[2,1,0];
FACE_5=[3,1,0];
FACE_6=[4,1,0];
FACE_7=[0,1,1];
FACE_8=[1,1,1];
FACE_9=[2,1,1];
FACE_10=[3,1,1];
FACE_11=[4,1,1];
FACE_12=[1,0,1];

h_dodecahedron=40;
h=4;
d=15;
p1=0.3;
p2=0.2;
n=50;
angle_b=2*atan(PHI);

// DODECAEDRO 1
rotate([0,0,30]){
color("green",1)
difference(){
    dodecahedron(h_dodecahedron);
    
    //POINT(h=h_dodecahedron, face=FACE_1)            
    //   shaft_base (shaft=[d,h],play=[p1,p2],polygonal=n);
    POINT(h=h_dodecahedron, face=FACE_2)            
        shaft_base (shaft=[15,5],play=[p1,p2],polygonal=8);
    POINT(h=h_dodecahedron, face=FACE_3)            
        shaft_base (shaft=[15,8],play=[p1,p2],polygonal=8);
    POINT(h=h_dodecahedron, face=FACE_4)            
        socket (pin=[12,15,SIMPLE]);
    POINT(h=h_dodecahedron, face=FACE_6)            
        shaft(shaft=[8,20],deep=0.5,play=0.2);
    POINT(h=h_dodecahedron, face=FACE_5)            
        shaft_base (shaft=[15,5],play=[p1,p2],polygonal=8);
    POINT(h=h_dodecahedron, face=FACE_7)            
        shaft_base (shaft=[15,5],play=[p1,p2],polygonal=8);
    POINT(h=h_dodecahedron, face=FACE_8)            
        shaft_base (shaft=[15,5],play=[p1,p2],polygonal=8);
    POINT(h=h_dodecahedron, face=FACE_9)            
        shaft_base (shaft=[15,8],play=[p1,p2],polygonal=8);
    POINT(h=h_dodecahedron, face=FACE_10)            
        shaft_base (shaft=[15,5],play=[p1,p2],polygonal=8);
    POINT(h=h_dodecahedron, face=FACE_11)            
        shaft_base (shaft=[15,5],play=[p1,p2],polygonal=8);
    POINT(h=h_dodecahedron, face=FACE_12)            
        shaft_base (shaft=[15,5],play=[p1,p2],polygonal=8);
               
}


{

    POINT(h=h_dodecahedron, face=FACE_2){            
        rotate([0,180,0]){    
        pin_o_ring_base (   ring=[9,1.7],
                            h_pin=12,
                            play=0.2,
                            base=[15,5,8]);
        color("black",0.8)
        translate([0,0,12-2-1.7-1.05])
            o_ring(d1=9,d2=1.7);
        translate([0,0,12-7-1-1.05])
            o_ring(d1=9,d2=1.7);
            }}
    POINT(h=h_dodecahedron, face=FACE_3)
        rotate([0,180,0])
        magnet_loose_base_close ( magnet=[6,2],
                            t=0.6,
                            play=0.6,
                            base=[15,8,8]);
    *POINT(h=h_dodecahedron, face=FACE_4)            
        shaft_base (shaft=[d,h],play=[p1,p2],polygonal=n);
    POINT(h=h_dodecahedron, face=FACE_5)            
        rotate([0,180,0])
        total_joint_sphere(pin=[15,4],mode=1,angle=180,play=0.1,polygonal=8,res=32);
    *POINT(h=h_dodecahedron, face=FACE_6)            
        shaft_base (shaft=[d,h],play=[p1,p2],polygonal=n);
    POINT(h=h_dodecahedron, face=FACE_8) 
        rotate([0,180,0])
        spike_base (spike=[8,13,0.6,80],base=[15,5,8]);
    POINT(h=h_dodecahedron, face=FACE_7){            
        rotate([0,180,0])    
        magnet_fixed_base ( magnet=[6,2],
                            play=[0.3,0,2],
                            base=[15,5,8]);
                magnet(6,2);}
    POINT(h=h_dodecahedron, face=FACE_9){
        rotate([0,180,0])
        suction_pad_base (suction_pad_head=[7,4,4,3],base=[15,8,8]);
        suction_pad (head=[7,4,4,2.5], suction=[20,7]);
    }
    POINT(h=h_dodecahedron, face=FACE_10)
        rotate([0,180,0]){
        snap_fasteners_base (model=PRYM_SNAP_FASTENERS_11, type=SOCKET, base=[15,5,8]);
        fastener( model=PRYM_SNAP_FASTENERS_11,type=SOCKET);
            }
    POINT(h=h_dodecahedron, face=FACE_11)
        rotate([0,180,0])
        pin (   pin=[9,15,TABNORMAL],
                base=[15,15,5,8],
                play=-0.1);
    POINT(h=h_dodecahedron, face=FACE_12) 
        rotate([0,180,0])
        total_joint_cone(pin=[15,4],mode=2,angle=360,play=0.1,polygonal=8,res=32);
}

}
