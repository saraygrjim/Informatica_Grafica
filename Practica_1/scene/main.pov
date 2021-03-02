global_settings{ assumed_gamma 1.0 } // Para renderizar lo mismo en macOS y Linux
#include "colors.inc"
#include "textures.inc"
#include "../obj/ambientador.pov"
#include "../obj/bowl.pov"
#include "../obj/sphere.pov"
#include "../obj/prism.pov"


/*
* Vista frontal 
*/
#declare front_pos = < 9, 25,-40.00> ;  
#declare front_look_at  = < 1, 2,  1.00> ;
#declare front_angle    =  0 ;

/*
* Vista aerea 
*/
#declare up_pos = < 1, 80, 0> ;  
#declare up_look_at  = < 1, 2,  1.00> ;
#declare up_angle    =  0 ;

/* 
* Vista cenital 
*/
#declare top_pos = < 1, 30, -3> ;  
#declare top_look_at  = < 0, 0, 0> ;
#declare top_angle    =  0 ;

camera{ location front_pos
        angle    front_angle
        look_at  front_look_at
        
}

// Sol
light_source{<2000,3500,-2500> color White*0.9}

// Cielo
sky_sphere{ pigment{ gradient <0,1,0>
                     color_map{ [0   color Black]//White
                                [0.1 color Black]//~Navy
                                [0.9 color Black]//~Navy
                                [1.0 color Black]//White
                              }
                     scale 2 
                 }
} 

// Suelo
plane { <0,1,0>, 0  
    texture { NBglass pigment { color White}}
    finish{phong 1
    diffuse 0.35}
}

// plane { <-0.2,0,1>, 30  
//     color rgb<24,49,42>
// }

object { ambientador scale y*0.9  }
object { bowl scale 0.9 translate<10,0,-9>}
object { finalSphere  scale 0.6 translate<-6,0,-7> }
object { finalPrism scale 1.4 scale y*1.4 translate<-6,0,15> }
