// Transformations v.02
// (C) @oblomobka - 2015.04
// GPL3

// Transforma una forma en un sector de esa forma según un ángulo dado.

module sector(	angle, 		// es el ángulo del sector, lo que quedará de la forma original
				d=1000,		// valor auxiliar, será como mínimo igual al diámetro del cilindro que envuelve la forma original
				h=1000		// valor auxiliar, será como mínimo igual a la altura del cilindro que envuelve la forma original
				){

POINTS=[	[0,0,-h],
            [0,0,h],
            [d*cos(0*angle/4),d*sin(0*angle/4),-h],
            [d*cos(0*angle/4),d*sin(0*angle/4),h],
            [d*cos(1*angle/4),d*sin(1*angle/4),-h],
            [d*cos(1*angle/4),d*sin(1*angle/4),h],
            [d*cos(2*angle/4),d*sin(2*angle/4),-h],
            [d*cos(2*angle/4),d*sin(2*angle/4),h],
            [d*cos(3*angle/4),d*sin(3*angle/4),-h],
            [d*cos(3*angle/4),d*sin(3*angle/4),h],
            [d*cos(4*angle/4),d*sin(4*angle/4),-h],
            [d*cos(4*angle/4),d*sin(4*angle/4),h],
            ];

TRIANGLES=[	[0,1,2],
			[1,3,2],
			[2,3,4],
			[3,5,4],
			[4,5,6],
			[5,7,6],
			[6,7,8],
			[7,9,8],
			[8,9,10],
			[9,11,10],
			[10,11,0],
			[11,1,0],

			[5,3,1],
			[7,5,1],
			[9,7,1],
			[11,9,1],
			[0,2,4],
			[0,4,6],
			[0,6,8],
			[0,8,10]
			];

if(angle<=0 || angle>=360){
	children();
	}
	else{
		intersection(){
			polyhedron(points=POINTS,faces=TRIANGLES);
			children();
			}
		}
}

/////////////////////////////////////////////
// Ejemplo de uso de la tansformación sector()
sector (270)
    cylinder(r=40/2,h=20); 