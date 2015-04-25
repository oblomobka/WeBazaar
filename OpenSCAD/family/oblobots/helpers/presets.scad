// presets [OBLOBOTS] 
// valores predeterminados para los volúmenes de un oblobot así como de los modos de represntación
// (c) Jorge Medal (@oblomobka) - Sara Alvarellos (@trecedejunio) 2015.04 v.12
// GPL license

/////////////////////////////////////////////
/////// REPRESENTACIÓN //////////////////////
/////////////////////////////////////////////

//-- MODOS DE REPRESENTACIÓN DE LAS PARTES 

ASSEMBLED=[0,1,0,0];
EXPLOSION=[0,1,1,1];
PRINTING=[1,0,0,2];


//-- ELECCIÓN DE LA PARTE REPRESENTADA	

ALL=[0];
LEGS=[1];
HIP=[2];
TRUNK=[3];
HEAD=[4];
ARMS=[5];
BADGES=[6];

BODY=[7];
CAPS=[8];

//-- COLORES

arms_color=[1,rands(100,200,1)[0]/255,0];
legs_color=[0,rands(100,200,1)[0]/255,1];
trunk_color=[rands(0,100,1)[0]/255,rands(150,225,1)[0]/255,rands(0,100,1)[0]/255];
head_color=[220/255,rands(0,100,1)[0]/255,20/255];
badges_color=[rands(0,255,1)[0]/255,rands(0,255,1)[0]/255,rands(0,255,1)[0]/255];
hip_color=[0,(rands(100,200,1)[0])/255,1];







