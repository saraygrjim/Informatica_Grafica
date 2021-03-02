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
#declare front_pos = < 12, 25,-35.00> ;  
#declare front_look_at  = < 0, 7,  0> ;
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
        look_at  front_look_at
        right    x*image_width/image_height        
        //sky <0,0,2>
        //rotate <0,front_angle,0>
}

// Sol
//light_source{<500,3500,900> color White}
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
    texture {pigment {color White}}
}


plane { <0,0,1>, 50  
        texture {pigment {color rgb<0.19,0.24,0.12>*0.3}}
        //color rgb<56,74,32>
        rotate <0,-25,0>
}

object { ambientador 
        scale y*0.9  
        rotate <0, 4, 0> }
object { bowl  translate<12,-2,-9>}
object { finalSphere  scale 0.7 translate<-6,0,-7> }
object { finalPrism scale 1.4 scale y*1.4 translate<-5,0,13> }