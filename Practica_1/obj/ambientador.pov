global_settings{ assumed_gamma 1.0 }
#include "colors.inc"
#include "textures.inc"
#include "woods.inc"
#include "glass.inc"


#declare palo = cylinder{<5,3,3>,<5,25,3>,0.15 
        texture {T_Wood21 pigment { Green }}
}

#declare caja_ambientador = difference {
    box{<0,0,0>, <10,12,6>
        texture  {T_Wood7}
    }
    cylinder{<5,6,0>,<5,6,6>,3 open
         texture  {T_Wood7}
    }
    cylinder{<5,12.001,3>,<5,11.8,3>,1.5 
        texture  {T_Wood7}
    }
    cylinder{<5,12,3>,<5,9,3>,1 open
        texture  {T_Wood7}
    }
   
}

#declare ambientador = union {
    object {
        caja_ambientador
        rotate <0,0,0>
    }
    object{
        palo
        rotate <5,0,12>
        translate<2,0,0>
    } 
    object{
        palo
        rotate <6,0,-12>  
        translate<-2,0,-1>
    }
    object{
        palo
        rotate <12,0,8>  
        translate<1.5,0,-2>
    }   
    cylinder{<5,3,3>,<5,9,3>,1.7 open
        material {M_Glass}
    }
    cylinder{<5,3,3>,<5,4,3>,1.7
        scale 0.99
        material { texture { pigment { Col_Glass_Winebottle } 
        finish{ F_Glass1 } } interior { ior 1.5 } }
    }
    
}
