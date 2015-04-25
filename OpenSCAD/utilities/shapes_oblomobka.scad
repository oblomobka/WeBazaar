// Shapes v.02
// (C) @oblomobka - 2015.04
// GPL3

include <constants_oblomobka.scad>
include <functions_oblomobka.scad>
include <functions_ext.scad>

// Definición de un trapecio isosceles
module trapezium (	p1=20,		// longitud de una de las lineas paralelas del trapecio
					p2=10,		// longitud de la otra línea paralela del trapecio
					h=15        // altura - distancia entre lineas paralelas
					){

POINTS=[    [p1/2,-h/2],
            [p2/2,h/2],
            [-p2/2,h/2],
            [-p1/2,-h/2]];

PATHS=[[0,1,2,3]];

polygon (points=POINTS, paths=PATHS);
}


trapezium (20,10,20);