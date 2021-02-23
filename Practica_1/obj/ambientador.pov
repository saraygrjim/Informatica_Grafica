global_settings{ assumed_gamma 1.0 }
#include "colors.inc"
#include "textures.inc"

#declare palo = cylinder{<4,2.5,4>,<4,13,4>,0.15 
        texture {pigment { DMFWood4} }
}

#declare caja_ambientador = difference {
    box{<0,0,0>, <8,10,8>
        texture {pigment { DMFWood4} }
    }
    cylinder{<4,5,0>,<4,5,8>,2.5 open
        texture {pigment { DMFWood4} }
    }
    cylinder{<4,10.001,4>,<4,9.8,4>,1.5 
        texture {pigment { DMFWood4} }
    }
    cylinder{<4,10,4>,<4,9,4>,1 open
        texture {pigment { DMFWood4} }
    }
}

#declare ambientador = union {
    object {
        caja_ambientador
        rotate <0,20,0>
    }
    object{
        palo
        rotate <5,20,0>  
    } 
    object{
        palo
        rotate <-5,20,0>  
    }
    object{
        palo
        rotate <5,20,5>  
    }   
}
