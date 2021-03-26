#include "colors.inc"
#include "functions.inc"
#include "debug.inc"
#include "rand.inc"
#include "textures.inc"
#include "woods.inc"
#include "./textures.pov"
#include "obj/tree.pov"
#include "obj/forest.pov"
#include "obj/lightning.pov"

#declare s = seed(982143);

global_settings
{
  assumed_gamma 1.0
  ambient_light 1
}

// Camara -----------------------------------------------
#declare Camera_Location = < 30, 5,-100.00> ; 
#declare Camera_Look_At  = < 20,25,  0.00> ;
#declare Camera_Angle    =  100 ;

camera{ 
        location Camera_Location
        right    x*image_width/image_height
        angle    Camera_Angle
        look_at  Camera_Look_At
}

// Sol de color oscuro, simula un dia nublado 
light_source{< 3000,3000,-3000> color rgb<1,1,1>*0.2 shadowless}


// Cielo -------------------------------------------------
// Plano normal al vector unitario Y,
// con degradado en tonos oscuros 
plane { 
  <0,1,0>, 500 
  hollow 
  texture { bozo scale 1
          texture_map{ 
                [ 0.0  pigment{color rgbf<0.27,0.49,0.99,0.8>} ] // Azul  
                [ 0.5  pigment{color rgbf<0.27,0.49,0.99,0.6> }] // Mismo azul con menos transparencia
                [ 0.6  pigment{color rgbf<0.24,0.38,0.7,0.4> }]  // Azul mas oscuro
                [ 1.0  pigment{color rgbf<0.24,0.38,0.7,0.2> }] // Mismo azul con menos transparencia
                } 
          scale <500,1,1000>
        } 
  translate<-400,0,300> 
}


// Niebla -------------------------------------------------
fog { 
      fog_type   2 
      distance   400 // Densidad de la niebla
      color      White*0.9 
      fog_offset 0.1 // Offset en el horizonte
      fog_alt    30 // Altura de la niebla
      turbulence 1.8
    }

// Suelo --------------------------------------------------- 
plane { <0,1,0>, 0 
        texture{ Soil_Texture } 
}                                  

// Arboles con posicion frontal
object {
     // 25 arboles espaciados linealmente en el eje X entre la Z -50 y 50
    forest(25, -50, 50) 
}

// Arboles de fondo, para dar relleno
object {
     // 25 arboles espaciados linealmente en el eje X entre la Z -50 y 50
    forest(20, 50, 100)
    scale 0.9
}

// Rayo izquierdo
object {
    union {
        lightning(
            0,  //Profundidad inicial
            4.5,  // Tamaño
            -100, 300, 20, // Posicion inicial 
        )
    }
    translate y*2
    translate z*40
    hollow
    no_shadow
}


object {
    union {
        lightning(
            0,  //Profundidad inicial
            4.5,  // Tamaño
            90, 300, 20, // Position incial
        )
    }
    translate y*8
    translate z*40
    hollow
    no_shadow
}



