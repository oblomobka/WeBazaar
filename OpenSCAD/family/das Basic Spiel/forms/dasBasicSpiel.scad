// DAS BASIC SPIEL - SINA Spielzeug 
// http://www.shop.sina-spielzeug.de/basic-game-p-1446.html
// Code for OpenSCAD: Jorge Medal (@oblomobka) 2015.04 - v.00
// GPL license

// Parts
module dreieck_DBS (side=25){
    POINTS=[    [0,0,0],
                [side/2,0,0],
                [0,side*tan (60)/2,0],
                [0,0,side],
                [side/2,0,side],
                [0,side*tan (60)/2,side]];
    
    FACES=[     [0,1,3],
                [1,4,3],
                [3,4,5],
                [5,2,0],
                [0,3,5],
                [1,2,4],
                [5,4,2],
                [0,2,1]];
    
    polyhedron( points=POINTS,
                faces=FACES
                );
}

module grosses_quadrat_DBS (side=25){
    cube ([side,side/2,side]);
}

module kleines_quadrat_DBS (side=25){
    cube ([side/2,side/2,side]);
}

module halb_kreis_DBS (d=25){
    $fn=50;
    
    difference(){
        cylinder(r=d/2,h=d);
        translate([0,d,d/2])
            cube([2*d,2*d,2*d],center=true);
    }      
}

module viertel_kreis_DBS (d=25){
    $fn=50;
    
    intersection(){
        cylinder(r=d/2,h=d);
        translate([d,d,d/2])
            cube([2*d,2*d,2*d],center=true);
    }
}



// Set
module dasBasicSpiel (dimension=25){

gap1=2;         // gap between parts
gap2=0.5;       // gap between subparts
    
// triangles
color("olive")
    translate([gap2/2,0,0])
        dreieck_DBS(side=dimension);
color("olive")    
    translate([-gap2/2,0,0])
        mirror(0,0,0)
            dreieck_DBS(side=dimension);
    
// quadrats
color("darkred")
    translate([0,dimension*tan(60)/2+gap1,0]){
        translate([-dimension/2,0,0])
            grosses_quadrat_DBS (side=dimension);
        translate([-dimension/2-gap2/2,dimension/2+gap2,0])
            kleines_quadrat_DBS (side=dimension);
        translate([gap2/2,dimension/2+gap2,0])
            kleines_quadrat_DBS (side=dimension);
    }
    
// kreis
color("darkblue")
    translate([0,dimension*tan(60)/2+3*dimension/2+gap2+2*gap1,0]){
        translate([0,0,0])
            halb_kreis_DBS (d=dimension);
        translate([gap2/2,gap2,0])
            viertel_kreis_DBS (d=dimension);
        translate([-gap2/2,gap2,0])
            mirror(0,0,0)
            viertel_kreis_DBS (d=dimension);
    }
}



// Sample
dasBasicSpiel(dimension=25);
