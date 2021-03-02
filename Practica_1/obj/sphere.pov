global_settings{ assumed_gamma 1.0 } // Para renderizar lo mismo en macOS y Linux
#include "colors.inc"
#include "textures.inc"
#include "shapes.inc"
#include "rand.inc"
#include "glass.inc"
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

#declare OrangeBubble = material { 
        texture { 
            pigment { Col_Glass_Orange } 
            finish{ F_Glass1 } } 
            interior { ior 1.5 } 
    }

#declare bubbleRadius=0.4;
#declare BigSphere = sphere {
    <0,8,0>, 8 
    material { OrangeBubble }
}
#declare InnerSphere = sphere{<0,8,0>, 8-bubbleRadius}

#declare finalSphere = 
    union{
        object {BigSphere}
    #local Nr = 0;     // start
    #local EndNr = 120; // end
    #while (Nr< EndNr)

    
    sphere{VRand_In_Obj(InnerSphere, Rand_1), RRand(0.1,bubbleRadius,Rand_1) 
            material{ OrangeBubble}} 
    #local Nr = Nr + 1;  // next Nr
    #end // --------------- end of loop
    translate<0,0,0>
    } // end of union
