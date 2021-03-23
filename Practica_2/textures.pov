#include "woods.inc"
#include "colors.inc"
#include "textures.inc"

// sky textures --------------------------------------------------------
#declare T_Clouds  =
    texture {
            pigment { bozo
                turbulence 1.5
                octaves 10
                omega 0.5
                lambda 2.5
                color_map { [0.0 color rgbf<1, 1, 1, 1> ]
                            [0.2 color rgbf<0.85, 0.85, 0.85, 0.00>*1.5 ]
                            [0.5 color rgbf<0.95, 0.95, 0.95, 0.90>*1.12  ]
                            [0.6 color rgbf<1, 1, 1, 1> ]
                            [1.0 color rgbf<1, 1, 1, 1> ] 
                          }// color_map  
                     } // pigment 

            finish {ambient 0.95 diffuse 0.1}
            } // end of texture 

// tree textures --------------------------------------------------------
#declare leaf_T=
    texture{
            pigment { color DarkGreen } //Gold
            finish { specular .1 roughness .1 irid { 0.1 thickness 0.1 turbulence 0.1 } }
            } // end of texture 

#declare Leaves_Texture_1 = 
    texture{ pigment{ bozo 
                    color_map{
                    [0.0 color rgbf< 1,0.1,0.0, 0.2>*0.7 ]  
                    [1.0 color rgbf< 1,0.7,0.0, 0.2>*1 ]
                             } // color_map  
                    }  // pigment 
            normal { bumps 0.15 scale 0.05 }
            finish { phong 1 reflection 0.00}
            } // end of texture 

#declare Leaves_Texture_2 = 
    texture{ pigment{ color rgbf< 1,0.5,0.0, 0.4>*0.5}    
            normal { bumps 0.15 scale 0.05 }
            finish { phong 0.2 }
            } // end of texture

#declare Stem_Texture = 
    texture{ pigment{ color rgb< 0.75, 0.5, 0.30>*0.25 } 
            normal { bumps 0.75 scale <0.025,0.075,0.025> }
            finish { phong 0.2 reflection 0.00}         
            } // end of texture 

// Ground textures --------------------------------------------------------

// A green texture for grass, plants, trees, etc.
#declare Vege_Texture =
    texture {
            pigment{ color <0.2,0.5,0.1>*0.5} 
            normal { bumps 0.5 scale 0.005 } 
            } // end of texture 

// A brown texture for the soil, where the plants can't grow.
#declare Soil_Texture =
    texture {
            pigment {color <0.77,0.6,0.35>*0.7}
            normal {bumps 0.5 scale 0.05}
            finish {diffuse 0.9 phong 1.0}
            } // end of texture 

