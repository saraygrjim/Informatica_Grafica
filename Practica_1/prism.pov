#include "colors.inc"
#include "shapes.inc"
#include "textures.inc"
// #include "Woods.inc"
// #include "stones.inc"
#include "glass.inc"
// #include "metals.inc"


camera {
    // location <-30,25,10>

    // Planta
    // location <0,20,0>
    // look_at <0,0,0> 

    //Perfil
    // location <0, 5, 11>
    // look_at <0, 3.5, 0>

    //Vista alta
    location <-8, 15, 11>
    look_at <0, 2, 0>

    //Base de la figura
    // location <0,-20,0>
    // look_at <0,0,0> 
}

light_source {
  <1000,1000,-1000>, rgb <1,0.75,0> //an orange light
  }

#declare prisma_triangular =

    prism {
        linear_sweep
        linear_spline
        0, // sweep the following shape from here ...
        7, // ... up through here
        3, // the number of points making up the shape ...
        <-5,-2.88>, <5,-2.88>, <0,5.78>
        material { M_Glass }
    }

#declare prisma_hexagonal_exterior =
    prism {
        linear_sweep
        linear_spline
        0, // sweep the following shape from here ...
        11, // ... up through here
        6, // the number of points making up the shape ...
        <-2.93,5.09>, <2.93,5.09>, <5.84, 0>, <2.93, -5.09>, <-2.93, -5.09>, <-5.84, 0>
        material{ M_Glass }
    }


#declare prisma_hexagonal_interior =
    intersection {
        object { 
            prisma_triangular 
        }
        object { 
            prisma_triangular
            rotate <0,180,0>  
             
        }
    }

#declare prisma_hexagonal =
    prism {
        linear_sweep
        linear_spline
        0, // sweep the following shape from here ...
        5, // ... up through here
        6, // the number of points making up the shape ...
        <-2.2,3.82>, <2.2,3.82>, <4.41, 0>, <2.2, -3.82>, <-2.2,-3.82>, <-4.41, 0>
        material{ M_Glass }
    }

#declare triagulares =
    union {
        object { 
            prisma_triangular
            translate 1.1*y
        }
        object { 
            prisma_triangular
            rotate <0,180,0>  
        }
    }





#declare triangulares_sin_puntas =
    intersection {
        object { prisma_hexagonal_exterior }
        object { triagulares }
    }


#declare final_con_relleno =
    union {
        object { triangulares_sin_puntas }
        object { 
            prisma_hexagonal 
            translate 1.1*y
        }

    }


object {
    difference {
        object { 
            final_con_relleno
        }
        object { 
            prisma_hexagonal_interior 
            scale <0,1.4,0> 
            translate 2.5*y
        }

    }
}





background {
    rgb <0.9,0.9,0.9> 
}