#version 3.7;
global_settings{ assumed_gamma 1.0 }
#default{ finish{ ambient 0.1 diffuse 0.9 }} 
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

#declare Camera_0 = camera {angle 75 
                            location  <0.0 , 3.0 ,-9.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , -1.0, 0.0>}
camera{ Camera_0 }

// sun
light_source{<-3500,1000,-1500> color rgb<1,0.9,0.8> }

#declare Pool_Tex = 
          texture{ pigment{ color rgb<1,1,1> }  
                   finish { phong 0.50 }
                 } 

#declare Pool_X = 5.00;
#declare Pool_Y = 2.00;
#declare Pool_Z = 8.00;
#declare Pool_Inner_Size = <5,-2,8>;
#declare Border = 0.50;  

#declare Pool_Transformation = 
  transform{ rotate<0,0,0> 
             translate<-2.5,0.10,-6>
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

// ground : TO BE MOVED
difference{
 plane{ <0,1,0>, 0 }
 object{ Pool_Outer  
        texture{ Pool_Tex } 
         transform Pool_Transformation 
       } 
} 

// placing of the pool: TO BE MOVED 
object{ Pool 
        transform Pool_Transformation }   

// transparent pool water //TODO: ADAPT 
#declare Water_Material =  
material{    
 texture{ 
   pigment{ rgbf <0.92,0.99,0.96,0.45> }
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
 pigment{ bumps 
          turbulence 0.20
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
 contained_by{ 
   box{<-Border,-Pool_Y-1.01,-Border>, 
       < Pool_X+Border,1, Pool_Z+Border> 
      } //
    } 
 accuracy 0.01
 max_gradient 2
 material{ Water_Material }
 transform  Pool_Transformation  
}

