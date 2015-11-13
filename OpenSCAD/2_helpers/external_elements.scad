// external elements [UNIONS] v.01.3
// librería de elementos externos comerciales (botones automáticos, espigas de madera baterías, ...) 
// (c) Jorge Medal (@oblomobka) 2015.09 
// GPL license

// BOTONES AUTOMÁTICOS - Press Fastener (PF)
// Cada código corresponde a las medidas de un modelo

//XXX= [ xx,xx,xx,xx,xx,xx,xx,xx ];	        // [ 	diametro hembra,
                                            //		espesor hembra,
                                            //		diámetro alojamiento en hembra (aparece en los botones para coser),
                                            //		saliente del alojamiento en hembra (aparece en los botones para coser),
                                            //		diámetro macho,
                                            //		espesor macho
                                            //      diámetro cabeza,
                                            //		altura cabeza macho
                                            //      valor que determina el tipo de botón automático     0 -> hembra con cabeza (botones para coser)
                                            //                                                          1 -> hembra en forma de anillo]]

NULL=[0,0,0,0,0,0];				// no hay botón automático
PRYM_SNAP_FASTENERS_9 = [8.5,1.5,3,2.7, 8.1,0.6,2.4,3, 0];	        // marca PRYM - Snap fasteners 9mm  (boton para coser)
PRYM_SNAP_FASTENERS_11 = [10,1.4,3.5,3, 9.1,0.7,2.9,3.7, 0];	    // marca PRYM - Snap fasteners 11mm (boton para coser)
PRYM_SNAP_FASTENERS_17 = [17,3,7,5, 17,1,5,6, 0];                   // marca PRYM - Snap fasteners 17mm (boton para coser)
PRYM_RING_FASTENERS_11 = [10.9,1.6,6.8,2.2, 10.9,1.6,3.9,4.8, 1];    // marca PRYM - La parte hembra tiene forma de anillo 11mm 
PONTEJOS_RING_FASTENERS_12 = [11.7,1.6,6.4,2.5, 11.7,1.6,3.9,4.1, 1];// marca desconocida, comprado en pontejos - hembra con forma de anillo 

PLUG=1;
SOCKET=0;


// Espigas de madera - DOWEL

DOWEL_8=[8,40,0,0,0,0,1];
DOWEL_6=[6,30,0,0,0,0,1];

// TUBOS DE PLÁSTICO

PIPE_6=[6,20,0,0,0,0,1];

// Tornillería

//MX=[xx,xx,xx];		// 	[	altura de la tuerca,
                        //	[	diámetro de la tuerca (inscrita),
                        //	[	diámetro de la rosca	]
					
M3=[2.5,6.4,3.1];

// BATERÍAS CILÍNDRICAS

//XX= [ xx,xx ];		// [ 	diametro de la pila,
                        //		longitud de la pila	]
AA = [ 14.5, 50.5 ];
AAA = [ 10.5,44.5 ];
C = [ 26.2, 50 ];
D = [ 34.2, 61.5 ];