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
#declare front_pos = < 15, 24,-40.00> ; 
#declare front_look_at  = <6, 15, -5> ;
#declare front_angle    =  70 ;

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
        right    x*image_width/image_height 
        
}

light_source{
        <0 ,500,400> color White
        spotlight
        point_at  <0,0,0>
}

light_source{
        <15 ,4,10> color White*0.6
        shadowless
}

light_source{
        <-7 ,6,15> color White*0.6
        shadowless
}

// Suelo
plane { <0,1,0>, 0  
    texture {  pigment { color White*0.7}}
//     finish{phong 1
//     diffuse 0.35}
}


object { ambientador 
        scale y*0.85   }
object { bowl  translate<12,-2,-9>}
object { finalSphere  scale 0.7 translate<-6,0,-7> }
object { finalPrism scale 1.4 scale y*1.35 translate<-7,0,13> }
object { 
        box {
        <-1, -1, -1>, <1, 1, 1> 
        texture {pigment {color rgb<0.19,0.24,0.12>*0.1}}
        }
        scale x*1000 scale y*80 scale z*0.2
        translate<0,0,70>
        rotate <0,-20,0>
}
