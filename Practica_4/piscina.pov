#version 3.7;
global_settings{ assumed_gamma 1.0 }
#default{ finish{ ambient 0.5 diffuse 0.9 }} 
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
light_source{<14,50,0> color rgb<1,0.9,0.8> parallel}

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

#declare Pool_X = 5.00;
#declare Pool_Y = 3.00;
#declare Pool_Z = 10.00;
#declare Pool_Inner_Size = <5,-2,8>;
#declare Border = 0.70;  

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
    <Pool_X+Border, 0, 0>, <Pool_X+2*Border+0.01, Pool_Y+10, Pool_Z+18> // <x, y, z> near lower left corner, <x, y, z> far upper right corner
  }
#declare Left_Wall =
box {
  <Pool_X-20, 0, 0>, <Pool_X-22, Pool_Y+10, Pool_Z+18> // <x, y, z> near lower left corner, <x, y, z> far upper right corner
}
#declare Front_Wall =
  box {
    <Pool_X+2*Border+0.01, Pool_Y+10, Pool_Z+17>, <Pool_X-20,0,Pool_Z+18> // <x, y, z> near lower left corner, <x, y, z> far upper right corner
  }

#declare Front_Wall2 =
  box {
    <Pool_X-21, Pool_Y+6.25, Pool_Z+12>, <3,0,Pool_Z+13> // <x, y, z> near lower left corner, <x, y, z> far upper right corner
  }


// ground : TO BE MOVED
difference{
 plane{ <0,1,0>, 0 
  texture {
    pigment { 
      rgb <0.9961, 0.9922, 0.9569>
    }
    finish{
      brilliance .6
      ambient 0.6
    }
    
  }
 }
 object{ Pool_Outer  
        texture{ Pool_Tex } 
        //  transform Pool_Transformation 
       } 
} 

// placing of the pool: TO BE MOVED 
object{ Pool 
        // transform Pool_Transformation 
        }   

// transparent pool water //TODO: ADAPT 
#declare Water_Material =  
material{    
 texture{ 
   pigment{ rgbf <0.3451,0.949,0.96,0.4627> }
   finish { diffuse 0.1 reflection 0.5  
            specular 0.8 roughness 0.0003 
            phong 1 phong_size 400}
 }
 interior{ ior 1.3 caustics 0.15  
 }
}

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
 material{ Water_Material }
//  transform  Pool_Transformation  
 
}

union {
  object{
      Right_Wall
      // rotate y*3
  }
  object{
      Left_Wall
      // rotate y*3
      // translate y*0.5
      // scale y*1.02
  }
  object{
    Front_Wall
    // translate x*2   
  }
  object{
    Front_Wall2
    // translate x*2   
  }

  texture{ 
    pigment { 
      //White
      Pink
    }
    finish {
      brilliance .6
      ambient 0.6
      // diffuse 1
      //specular 0.3
    }
   }
  // transform Pool_Transformation
  
}
