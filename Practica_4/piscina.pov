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
#include "obj/TOMLEAF.inc" 
#include "obj/tree2.inc"
#include "obj/TOMTREE-1.5.inc"  
#include "tex/our_textures.inc"


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

#declare Pool_X = 5.75;
#declare Pool_Y = 3.00;
#declare Pool_Z = 7.00;
#declare TreeBox_X1 = -3;
#declare TreeBox_X2 = -1;
#declare TreeBox_Z1 = Pool_Z;
#declare TreeBox_Z2 = Pool_Z+1;
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
 object{ Pool_Outer texture{Floor_Tex}}
 object{ Pool_Inner texture{Pool_Tex}} 
} 

#declare Right_Wall =
  box {
    <Pool_X+Border, 0, 0>, <Pool_X+2*Border, 10, Pool_Z+18> // <x, y, z> near lower left corner, <x, y, z> far upper right corner
  }

#declare Right_Border =
  box {
    <Pool_X+Border-0.05, 0, Pool_Z>, <Pool_X+2*Border, 0.2, Pool_Z+18> // <x, y, z> near lower left corner, <x, y, z> far upper right corner
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
  texture { Floor_Tex }
 }
 object{ Pool_Outer  
        texture{ Pool_Tex } 
       }
  box{  
    <TreeBox_X1,-2,TreeBox_Z1>, <TreeBox_X2,0.001,TreeBox_Z2> 
    texture { Pool_Tex}
  }
} 

// placing of the pool: TO BE MOVED 
object{ Pool }   

// transparent pool water //TODO: ADAPT 


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
  material { Water_Material }
  //  normal{ bumps 0.1
  //        scale <1,0.25,0.25>*0.6
  //        turbulence 0.1
  //      }
}

isosurface {
  function {
    y
  }
  threshold -0.1
  contained_by {
    box{
        <TreeBox_X1,-2,TreeBox_Z1>, <TreeBox_X2,0.001,TreeBox_Z2>
    }
  }
  accuracy 0.01
  max_gradient 2
  texture { Soil_Tex }
}

union {
  object{
    Front_Wall
  }
  object{
    Mid_Wall
  }
  texture { Wall_Tex }
}

object{
    Right_Wall
    texture { RWall_Tex }
}

object{
    Left_Wall
    texture { LWall_Tex }
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
  object{ Left_Border }
  object{ Front_Border }
  object{ Mid_Border }
  texture { Border_Tex }
}

union{
  object{ Right_Border }
  texture { RBorder_Tex }
}

//------------------tiles-----------
#declare Z1 = Pool_Z-1;
#declare Z2 = Pool_Z;

#for(i, 0, 7)
    box {
        <Pool_X+Border-0.02, 0, Z1-i>, <Pool_X+2*Border, 1, Z2-i> // <x, y, z> near lower left corner, <x, y, z> far upper right corner
        texture { Tile_Tex }
    }

    box {
        <Pool_X+Border-0.02, 1, Z1-i>, <Pool_X+2*Border, 2, Z2-i> // <x, y, z> near lower left corner, <x, y, z> far upper right corner
        texture { Tile_Tex }
    }

    box {
        <Pool_X+Border-0.02, 2, Z1-i>, <Pool_X+2*Border, 3, Z2-i> // <x, y, z> near lower left corner, <x, y, z> far upper right corner
        texture { Tile_Tex }
    }
#end


//-------------------tree-------------------
#declare Tree_01 = object{TREE double_illuminate hollow}
object{ Tree_01
        scale 10
        translate< (TreeBox_X2+TreeBox_X1)/2, 0, (TreeBox_Z2+TreeBox_Z1)/2>
      } //--------------------------------------------
//----------------------------------------------------


light_source{
  <Pool_X, 1, Pool_Z-2>
  color White
  spotlight
   radius 15
    //falloff 20
    tightness 10
  point_at <Pool_X+Border, 0, Pool_Z-2>
}
// 


#include "./obj/rock.inc"

object {
  rock
   texture {
    pigment { color rgb <0.75, 0.75, 0.75> }
    finish { ambient 0.1 diffuse 0.6 phong 0.0}
  }
  scale 0.25
  rotate z*30
  translate <Pool_X+Border-0.3, 0.1, Pool_Z-2>
}

object {
  rock
   texture {
    pigment { color rgb <0.75, 0.75, 0.75>*0.87 }
    finish { ambient 0.1 diffuse 0.6 phong 0.0}
  }
  scale 0.15
  translate <Pool_X+Border-0.3, 0.3, Pool_Z-2.05>
}

object {
  rock
   texture {
    pigment { color rgb <0.75, 0.75, 0.75> }
    finish { ambient 0.1 diffuse 0.6 phong 0.0}
  }
  scale 0.20
  translate <Pool_X+Border-0.3, 0.1, Pool_Z-2.4>
  // rotate x*-15
}

object {
  rock
   texture {
    pigment { color rgb <0.75, 0.75, 0.75>*0.87 }
    finish { ambient 0.1 diffuse 0.6 phong 0.0}
  }
  scale 0.15
  rotate z*10
  translate <Pool_X+Border-0.3, 0.25, Pool_Z-2.3>
}

object {
  rock
   texture {
    pigment { color rgb <0.75, 0.75, 0.75>*0.87 }
    finish { ambient 0.1 diffuse 0.6 phong 0.0}
  }
  scale 0.15
  rotate z*30
  translate <Pool_X+Border-0.3, 0.4, Pool_Z-2.15>
}

// object {
//   rock
//    texture {
//     pigment { color rgb <0.75, 0.75, 0.75> }
//     finish { ambient 0.1 diffuse 0.6 phong 0.0}
//   }
//   scale 0.25
//   translate <Pool_X+Border-0.3, 0.2, Pool_Z-2-0.5>
// }



