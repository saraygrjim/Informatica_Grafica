#include "colors.inc"
#include "colors.inc"
#include "shapes.inc"
#include "textures.inc"
#include "Woods.inc"
#include "stones.inc"
#include "glass.inc"
#include "metals.inc"


camera {
    location <10,10,-20>
    look_at <0,10,0> 
}

light_source {
    <0, 0, -15>
    color rgb <1, 1, 1>
}


#declare base =
    sor {
        4, <4,0>, <2.75,2.1>, <2.7,4>, <4.8,4.4>
        // open
        sturm
        texture {
            T_Grnt16
        }
        finish {
            phong 1
            phong_size 80
        }

    }

#declare cuello =
    difference {
        sphere { 
            <0, 8, 0>, 5
            scale x*1.1

            texture {
                T_Grnt16
            }

            finish {
                phong 1
                phong_size 80
            }

        }  

        sphere { 
            <0, 8, 0>, 4.9

            scale x*1.1

            texture {
                T_Grnt16
            }

            finish {
                phong 1
                phong_size 80
            }
        } 

        box { 
            <-8, 6.8, -5>, <10, 15, 5> 
        }
    }

#declare cuenco =
    union {
        object { base }
        object { cuello }
    }

object { 
    cuenco
}

background { 
    color Black
}
 