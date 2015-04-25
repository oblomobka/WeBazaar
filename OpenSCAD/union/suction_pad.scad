// suction_pad [UNIONS] v.01
// (c) Jorge Medal (@oblomobka)  2015.04
// GPL license

include <../utilities/constants_oblomobka.scad>
include <helpers/presets.scad>
include <helpers/external_elements.scad>

use <../utilities/functions_oblomobka.scad>
use <../utilities/transformations_oblomobka.scad>
use <../utilities/solids_oblomobka.scad>

//////////////////////////////////////
// PIN (+)
//////////////////////////////////////
module suction_pad_shaft (  suction_pad_head=[7,4,4,3]){
    
$fn=50;
d_head=suction_pad_head[0];
h_head=suction_pad_head[1];
d_neck=suction_pad_head[2];
h_neck=suction_pad_head[3];
play=0.3;
    
union(){
    translate([0,0,h_neck-0.5])
        cylinder(r=d_head/2+play ,h=h_head+play );
    translate([0,0,(h_neck-0.5)/2])
        cylinder(r=(d_neck+1)/2+play ,h=h_neck );
    translate([0,0,-h_neck+0.1])
        cylinder(r1=d_head/2 ,r2=(d_neck+1)/2+play ,h=h_neck+(h_neck-0.5)/2 );
}  
}

module suction_pad_base (   suction_pad_head=[7,4,4,3],
                            base=[15,6,8])
                            {
    
$fn=50;
d_head=suction_pad_head[0];
h_head=suction_pad_head[1];
d_neck=suction_pad_head[2];
h_neck=suction_pad_head[3];
    
d_base=max(d_head+2,base[0]);
h_base=max(h_head+h_neck,base[1]);
n_base=lim(3,base[2],50);    

    
difference(){
    // Dibuja la base
    union(){
        translate([0,0,-h_base])pyramid_circumscribed(n=n_base,d2=d_base,d1=d_base-1,h=1);
        translate([0,0,-h_base+1])prism_circumscribed(n=n_base,d=d_base,h=h_base-1);
        }
    // Resta el hueco para la ventosa
    rotate([0,180,0])    
        suction_pad_shaft (suction_pad_head=suction_pad_head  );
    }
}


module suction_pad (head=[7,4,4,2.5], suction=[20,7]){


$fn=50;
d_head=head[0];
h_head=head[1];
d_neck=head[2];
h_neck=head[3];
    
d_suction=suction[0];
h_suction=suction[1];
    
 color("white",0.8)
   translate([0,0,-0.3]) 
    union(){
    translate([0,0,0])
        cylinder(r=d_neck/2,h=h_neck+0.1 );
    translate([0,0,h_neck])
        cylinder(r1=d_head/2,r2=(d_neck-1)/2 ,h=h_head );
    translate([0,0,-1])
        cylinder(r=(d_head+2)/2,,h=1 );
    difference(){
        translate([0,0,-h_suction])
        cylinder(r1=d_suction/2,r2=(d_head)/2 ,h=h_suction);
        translate([0,0,-h_suction-0.5])
        cylinder(r1=d_suction/2,r2=(d_neck)/2 ,h=h_suction-2);
    }
    
}  
}

//////////////////////////////////////
// EJEMPLOS
//////////////////////////////////////

i=30;

*suction_pad (head=[7,4,4,2.5], suction=[20,7]);

translate([0,0,0]){
    sector(270)
    translate([0,0,0])
        difference(){
            cylinder(r=15,h=10);
            suction_pad_shaft (suction_pad_head=[7,4,4,3]  );
            }
            
            suction_pad (head=[7,4,4,3], suction=[20,7]);
    translate([i,0,0])
        suction_pad_shaft (suction_pad_head=[12,6,5,3]  );

}

translate([0,i,0]){
    sector(270)
    translate([3*i,0,0]){
        suction_pad_base (suction_pad_head=[7,4,4,3],base=[15,8,50]);
    rotate([0,180,0])    
        suction_pad (head=[7,4,4,3], suction=[20,7]);
    }
    translate([i,0,0]){
        suction_pad_base (suction_pad_head=[12,6,5,3],base=[20,6,8]);
        rotate([0,180,0])    
            suction_pad (head=[12,6,5,3], suction=[30,9]);
    }
    translate([2*i,0,0]){
        suction_pad_base (suction_pad_head=[7,4,4,3],base=[12,3,5]);
        rotate([0,180,0])    
            suction_pad (head=[7,4,4,3], suction=[25,6]);
    }
    translate([0*i,0,0]){
        suction_pad_base (suction_pad_head=[7,4,4,3],base=[8,6,7]);
        rotate([0,180,0])    
            suction_pad (head=[7,4,4,3], suction=[20,7]);
    }
}
