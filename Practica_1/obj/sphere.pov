global_settings{ assumed_gamma 1.0 } // Para renderizar lo mismo en macOS y Linux
#include "colors.inc"
#include "textures.inc"
#include "shapes.inc"
#include "rand.inc"
#declare Rand_1 = seed (12433);
/*
* Vista frontal 
*/
#declare front_pos = < 1, 10,-50.00> ;  
#declare front_look_at  = < 1, 5,  1.00> ;
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
light_source{<2000,3500,-2500> color White*0.9}

// Cielo
sky_sphere{ pigment{ gradient <0,1,0>
                     color_map{ [0   color rgb<1,1,1>*0.6         ]//White
                                [0.1 color rgb<0.24,0.34,0.56>*0.8]//~Navy
                                [0.9 color rgb<0.24,0.34,0.56>*0.8]//~Navy
                                [1.0 color rgb<1,1,1>*0.6         ]//White
                              }
                     scale 2 
                 }
} 

// Suelo
plane { <0,1,0>, 0  
      texture { NBglass pigment { color rgb <0.9,0.9,0.9>}}
      finish{phong 1
       diffuse 0.35}
}


#declare SoapBubbleTex = texture {
    pigment {Red}
        finish {
            Shiny
            diffuse 0.2
            //irid {0.3 thickness 0.5 turbulence 0.5}
            conserve_energy
        }
}  

#declare bubbleRadius=0.7;
#declare BigSphere = sphere {<0,8,0>, 8 texture{Ruby_Glass}}
#declare InnerSphere = sphere{<0,8,0>, 8-bubbleRadius}

union{
    object {BigSphere}
 #local Nr = 0;     // start
 #local EndNr = 50; // end
 #while (Nr< EndNr)

   
   sphere{VRand_In_Obj(InnerSphere, Rand_1), bubbleRadius 
           texture{ SoapBubbleTex}} 
 #local Nr = Nr + 1;  // next Nr
 #end // --------------- end of loop
 translate<0,0,0>
} // end of union
