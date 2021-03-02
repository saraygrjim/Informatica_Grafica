global_settings{ assumed_gamma 1.0 } // Para renderizar lo mismo en macOS y Linux
#include "colors.inc"
#include "textures.inc"
#include "../obj/ambientador.pov"

/*
* Vista frontal 
*/
#declare front_pos = < 1, 15,-40.00> ;  
#declare front_look_at  = < 1, 2,  1.00> ;
#declare front_angle    =  0 ;

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
light_source{<2000,3000,2500> color White}

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

object {
    ambientador
}
