global_settings{ assumed_gamma 1.0 } // Para renderizar lo mismo en macOS y Linux
#include "colors.inc"
#include "shapes.inc"
#include "textures.inc"
#include "glass.inc"


#declare triangularPrism =
    prism {
        linear_sweep
        linear_spline
        0, // sweep the following shape from here ...
        7, // ... up through here
        3, // the number of points making up the shape ...
        <-5,-2.88>, <5,-2.88>, <0,5.78>
        material{ M_Glass }
    }

#declare hexagonalPrismBig =
    prism {
        linear_sweep
        linear_spline
        0, // sweep the following shape from here ...
        11, // ... up through here
        6, // the number of points making up the shape ...
        <-2.93,5.09>, <2.93,5.09>, <5.84, 0>, <2.93, -5.09>, <-2.93, -5.09>, <-5.84, 0>
        material{ M_Glass }
    }


#declare hexagonalPrismIn =
    intersection {
        object { 
            triangularPrism 
        }
        object { 
            triangularPrism
            rotate <0,180,0>  
             
        }
    }

#declare hexagonalPrismOut =
    prism {
        linear_sweep
        linear_spline
        0, // sweep the following shape from here ...
        5, // ... up through here
        6, // the number of points making up the shape ...
        <-2.2,3.82>, <2.2,3.82>, <4.41, 0>, <2.2, -3.82>, <-2.2,-3.82>, <-4.41, 0>
        material{ M_Glass }
    }

#declare triangularPrismUnion =
    merge {
        object { 
            triangularPrism
            translate 1.05*y
        }
        object { 
            triangularPrism
            rotate <0,180,0>  
        }
    }

#declare triangularPrismNoVertex =
    intersection {
        object { hexagonalPrismBig }
        object { triangularPrismUnion }
    }


#declare prismBlock =
    merge {
        object { triangularPrismNoVertex }
        object { 
            hexagonalPrismOut 
            translate 1.1*y
        }

    }

#declare finalPrism = 
    difference {
        object { 
            prismBlock
        }
        object { 
            hexagonalPrismIn 
            scale <1.005,1.4,1.005> 
            translate 2.5*y
        }

    }


