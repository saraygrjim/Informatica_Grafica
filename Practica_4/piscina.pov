#version 3.7;
global_settings{ 
  assumed_gamma 1.0 
  max_trace_level 10
}
#default{ 
  finish{ ambient 0.1 diffuse 0.9 }
}

#include "colors.inc"
#include "textures.inc"
#include "glass.inc"
#include "metals.inc"
#include "golds.inc"
#include "stones.inc"
#include "woods.inc"
#include "shapes.inc"
#include "shapes2.inc"
#include "functions.inc"
#include "math.inc"
#include "transforms.inc"

#declare Camera_0 = camera {angle 100
                            location  <2 , 2 ,0>
                            right     x*image_width/image_height
                            look_at   <2 , 2.5, 7>}
camera{ Camera_0 }

// sun
light_source{<238,700,-100> color White*0.7 parallel}
light_source{<2,10,0> color rgb<1,1,1>*0.2 shadowless}


// sky ------------------------------------
sphere{<0,0,0>,1 hollow
 texture{
  pigment{gradient <0,1,0>
          color_map{
           [0.0 color White]
           [0.8 color rgb<0.1,0.25,0.75>]
           [1.0 color rgb<0.1,0.25,0.75>] }
         } // end pigment
  finish {ambient 1 diffuse 0}
  } // end of texture
 scale 10000
 } // end of sphere -----------------------

#declare Pool_Tex = 
          texture{ pigment{ color White }
          finish{
            brilliance 0.6
            ambient 0.6
          }  
} 

#declare Pool_X = 5.75;
#declare Pool_Y = 3.00;
#declare Pool_Z = 7.00;
#declare Pool_Inner_Size = <5,-2,8>;
#declare Border = 1.00;  

#declare Pool_Transformation = 
  transform{ rotate<0,0,0> 
             translate<-2.5,0,-6>
           } 


#declare Pool_Inner = 
  box{<0,-Pool_Y,0>,<Pool_X,Pool_Y,Pool_Z>   
     }
#declare Pool_Outer = 
  box{<-Border, -Pool_Y-0.01, -Border> ,
      <Pool_X+Border,0.001,Pool_Z+Border> 
     }

#declare Pool = 
difference{
 object{ Pool_Outer texture{Pool_Tex}}
 object{ Pool_Inner texture{Pool_Tex}} 
} 

#declare Right_Wall =
  box {
    <Pool_X+Border, 0, 0>, <Pool_X+2*Border, 10, Pool_Z+18> // <x, y, z> near lower left corner, <x, y, z> far upper right corner
  }

#declare Right_Border =
  box {
    <Pool_X+Border-0.01, 0, 0>, <Pool_X+2*Border, 0.2, Pool_Z+18> // <x, y, z> near lower left corner, <x, y, z> far upper right corner
  }

#declare Left_Wall =
box {
  <Pool_X-15, 0, 0>, <Pool_X-17, 10, Pool_Z+18> // <x, y, z> near lower left corner, <x, y, z> far upper right corner
}

#declare Left_Border =
box {
  <Pool_X-15+0.01, 0, 0>, <Pool_X-17, 0.2, Pool_Z+18> // <x, y, z> near lower left corner, <x, y, z> far upper right corner
}

#declare Front_Wall =
  box {
    <Pool_X+2*Border+0.01, 10, Pool_Z+6.5>, <Pool_X-20,0,Pool_Z+7.5> // <x, y, z> near lower left corner, <x, y, z> far upper right corner
  }
  
#declare Front_Border =
  box {
    <Pool_X+2*Border+0.01, 0.2, Pool_Z+6.5-0.01>, <Pool_X-20,0,Pool_Z+7.5> // <x, y, z> near lower left corner, <x, y, z> far upper right corner
  }

#declare Mid_Wall =
  box {
    <Pool_X-21, 7, Pool_Z+3>, <5,0,Pool_Z+4> // <x, y, z> near lower left corner, <x, y, z> far upper right corner
  }

#declare Mid_Border =
  box {
    <Pool_X-21, 0.2, Pool_Z+3-0.01>, <5,0,Pool_Z+4> // <x, y, z> near lower left corner, <x, y, z> far upper right corner
  }

#declare Back_Wall =
  box {
    <Pool_X+2*Border+0.01, 10, -3>, <Pool_X-20,0,-4> // <x, y, z> near lower left corner, <x, y, z> far upper right corner
  }
  


// ground : TO BE MOVED
difference{
 plane{ <0,1,0>, 0 
  texture {
    T_Grnt0
    finish{
      brilliance .6
      ambient 0.6
    }
    
  }
 }
 object{ Pool_Outer  
        texture{ Pool_Tex } 
       } 
} 

// placing of the pool: TO BE MOVED 
object{ Pool }   

// transparent pool water //TODO: ADAPT 
#declare Water_Material =  
material{    
 texture{ 
    //pigment{ rgbf<.93,.95,.5,0.9>*0.95}
    pigment{ rgbf<0.77,1,0.76,1>}
     
          finish { ambient 0.0
                   diffuse 0.15
                   reflection 0.2
                   specular 0.6
                   roughness 0.005
                   reflection { 0.2, 1.0 fresnel on }
                   conserve_energy
                 }
           } // end of texture
         
          interior{ ior 1.33 
                    fade_power 1001
                    fade_distance 0.5
                    fade_color <0.8,0.8,0.8> 
                } // end of interior
        } // end of material

// pigment pattern for modulation  
// it will be applied as a function on y axis
// creating a wavy surface.
#declare Pigment_01 =  
 pigment{ //bumps 
          //turbulence 0
          scale <3,1,3>*0.12
          translate<1,0,0>
 } 

#declare Pigment_Function_01 = 
function { 
  pigment { Pigment_01 }
} 

isosurface {
 function{
   y
   +Pigment_Function_01(x,y,z).gray*0.2  
  } 
  threshold -0.25
 contained_by{ 
   box{<-Border,-Pool_Y-1.01,-Border>, 
       < Pool_X+Border,1, Pool_Z+Border> 
      } 
    } 
 accuracy 0.01
 max_gradient 2
 material{ M_Green_Glass }
 
}

union {
  object{
      Right_Wall
  }
  object{
      Left_Wall
    
  }
  object{
    Front_Wall
  }
  object{
    Mid_Wall
  }
  texture{ 
    pigment { 
       color White
      // Green
    }
    // finish { 
    //   brilliance 0.5
    //   specular 0.6
    //   crand 0.05 
    //   }    
      finish {
        brilliance 0.5 
        crand 0.05 
        ambient 0.62
        diffuse 0.6
        phong 1
      }
      normal {
        bumps 0.1
        scale 1.5
      }
   }

  
   
}

object {
  Back_Wall
  texture{ 
    pigment { 
      White
      // Green
    }
    finish {
      reflection {1}
    }
  }
}

union{
  object{ Right_Border }
  object{ Left_Border }
  object{ Front_Border }
  object{ Mid_Border }

  texture {T_Grnt0}
}