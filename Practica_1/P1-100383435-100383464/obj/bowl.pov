global_settings{ assumed_gamma 1.0 } // Para renderizar lo mismo en macOS y Linux
#include "colors.inc"
#include "shapes.inc"
#include "textures.inc"
#include "stones.inc"

#declare base =
    sor {
        4, <4,0>, <2.75,2.1>, <2.7,4>, <4.8,4.4>
        // open
        sturm
        texture{ pigment{color White}
            finish {ambient 0.1
                 diffuse 0.9
                 phong 1}
       }
        finish {
            phong 1
            phong_size 80
        }

    }

#declare cup =
    difference {
        sphere { 
            <0, 8, 0>, 4.8
            scale x*1.1

            texture{ pigment{color White}
                finish {ambient 0.1
                 diffuse 0.9
                 phong 1}
            }

            finish {
                phong 1
                phong_size 80
            }

        }  

        sphere { 
            <0, 8, 0>, 4.7

            scale x*1.1

           texture{ pigment{color White}
                finish {ambient 0.1
                 diffuse 0.9
                 phong 1}
            }

            finish {
                phong 1
                phong_size 80
            }
        } 

        box { 
            <-8, 7.5, -5>, <10, 15, 5> 
        }
    }

#declare bowl =
    union {
        object { base }
        object { cup }
    }

 