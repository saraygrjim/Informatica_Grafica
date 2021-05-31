#version 3.7;
global_settings{assumed_gamma 1.0} 
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
#include "obj/Window.pov"
#include "obj/Couch2.pov"
#include "obj/Pillows.pov"
#include "obj/table.pov"
#include "obj/TOMLEAF.inc" 
#include "obj/tree2.inc"
#include "obj/TOMTREE-1.5.inc"  
#include "obj/lamp.pov"
#include "obj/vase.pov" 
#include "obj/chair.pov" 

// #declare Camera_1 = 
// camera { angle 50    
//          location  < 2.20, 0.75, 0.05>
//          right     x*image_width/image_height
//          look_at   < 2.85, 0.75, 2.00> 
// }

#declare Camera_1 = 
camera { angle 50    
         location  < 2.20, 0.75, 0.05>
         right     x*image_width/image_height
         look_at   < 2.7, 0.75, 2.00> 
}

camera{Camera_1}

//---------------------------------- sun ----------------------------------
light_source{< 1200, 750, 400>  color White*1.2}   // keep sun below the clouds! 

//---------------------------------- sky ----------------------------------
// the dark blue
plane{ <0,1,0>,1 hollow  
       texture{ pigment { color rgb <0.20, 0.20, 1.0> }
                finish  { ambient 0.25 diffuse 0 } 
              }      
       scale 10000}
// the clouds 
plane{<0,1,0>,1 hollow  
       texture{pigment{ bozo turbulence 0.76
                        color_map { [0.5 rgbf<1.0,1.0,1.0,1.0> ]
                                    [0.6 rgb <1.0,1.0,1.0>     ]
                                    [1.0 rgb <0.5,0.5,0.5>     ]}
                       }
               finish { ambient 0.25 diffuse 0} 
              }      
       scale 800}

//----------------------------- fog in the far -----------------------------
fog{ 
    fog_type   2
    distance   1000
    color      rgb<1,1,1>*0.9
    fog_offset 0.1
    fog_alt    20
    turbulence 1.8
}
// fog{ fog_type   2 // ground fog 
//      distance   50
//      color      White
//      fog_offset 0.1
//      fog_alt    2.0
//      turbulence 0.8
//    }

//--------------------------------- ground ---------------------------------
plane { <0,1,0>, 0 
        texture { pigment{ color rgb<0.35,0.65,0.0>*0.72}
                  normal { bumps 0.75 scale 0.015  }
                  finish { phong 0.1 }
                }
}

#local D = 0.0001; 

// room dimensions 
#local R_x = 5.00;  
#local R_y = 2.50;
#local R_z = 7.00;


#local Wall_D = 0.25; 

// window dimensions 
#local D_x = 1.00; 
#local D_y = 2.00;
#local B_y = 0.5;


#local DF_d = 0.08; // outer door frame 
#local DF_z = 0.05; // outer door frame 


#declare Wall_Texture = 
  texture { 
    uv_mapping
    pigment{
        image_map {
        jpeg "textures/wall.jpeg"
        interpolate 2
      }
      scale 10
    } 
    // normal { bozo scale 0.1 }
    finish{ brilliance .6 }
  } 

//---------------------------- The room ---------------------------- 
// The room is the difference between an outter big box and a interior box
// there is also a hole for the window 
union{ 
    difference{ 
      box{<-Wall_D,-Wall_D,-Wall_D>,<R_x+Wall_D,R_y+Wall_D,R_z+Wall_D>}  
      box{<0,0,0>,<R_x,R_y,R_z> }  
      object{ Window_Hole transform Window_Transform} 
      texture { Wall_Texture } 

      hollow
    } // end difference 

    object{ Window transform Window_Transform} 


    //--------------------------------------------------------------
    // A low light_source inside the room 
    // without interaction with media 
    // to see what's in the room:
    light_source { <R_x/2, R_y-0.5,0.5>, 0.3 media_interaction off shadowless}

    // Scattering media box:
    box{ <0,0,0>, <R_x, R_y, R_z>
         pigment { rgbt 1 } 
         hollow
         interior{
           media{
             scattering { 1, 0.17 extinction 0.01 }
             samples 100, 500
           }
         }
    }

 
    translate<0,0.01,0>
    texture { Wall_Texture }
}


// --------------------- Floor ---------------------
#declare material_parquet = texture {
  uv_mapping
  pigment {
    image_map {
      jpeg "textures/parquet.jpeg" interpolate 4
    }

  }
  normal {
    uv_mapping
    bump_map {
      jpeg "textures/parquet.jpeg" interpolate 4 bump_size 2
    }
  }
  finish {
    ambient 0.0
    diffuse 0.8
    specular 0.6
    reflection { 0.1 }
  }
}


box {
  <0,0.01,0>, <R_x, 0.02, R_z> // <x, y, z> near lower left corner, <x, y, z> far upper right corner
  texture{
    material_parquet
  }
}


// --------------------- Couch ---------------------

object{
  couch
  // scale 0.85
  rotate y*180
  translate<R_x-2, 0, R_z-2>
  texture{
      pigment{
          image_map {
            jpeg "textures/Fabric_Couch.jpeg"
            interpolate 2
          }
          
      }
      finish {
        ambient .2
        diffuse .6
        specular .2
     }
  }
}


object{
  pillows
  // rotate y*180
  // scale 0.85
  translate<R_x-2, 0, R_z-2>
  // scale 0.5
  pigment{
      image_map {
        jpeg "textures/pillows5.jpeg"
        interpolate 2
      }
      translate x*-0.2
      scale 0.9
    }
}

// --------------------- Chair ---------------------

#declare rotationChair = -50;
#declare scaleChair = 0.8;

object {
  totalBody
  scale scaleChair
  rotate y*rotationChair
  translate<R_x-3.7, 0.01, R_z-2.5>
  texture{
    pigment{
        image_map {
          jpeg "textures/Fabric_Couch.jpeg"
          interpolate 2
        }     
    }
    finish {
      ambient .2
      diffuse .6
      specular .2
    }
  }
}

object {
  legs
  scale scaleChair
  rotate y*rotationChair
  translate <R_x-3.7, 0, R_z-2.5>
  texture { Rosewood }
  finish {
    ambient 0.0
    diffuse 0.8
    specular 0.6
    reflection { 0.1 }
  }
}

object {
  totalPillow
  scale scaleChair
  rotate y*rotationChair
  translate<R_x-3.7, 0.01, R_z-2.5>
  texture{
    pigment{
        image_map {
          jpeg "textures/Fabric_Couch.jpeg"
          interpolate 2
        }     
    }
    finish {
      ambient .2
      diffuse .6
      specular .2
    }
  }
}


object {
  buttons
  scale scaleChair
  rotate y*rotationChair
  translate<R_x-3.7, 0.01, R_z-2.5>
  texture{
    pigment{
        image_map {
          jpeg "textures/pillows5.jpeg"
          interpolate 2
        }     
    }
    finish {
      ambient .2
      diffuse .6
      specular .2
    }
  }
}


// --------------------- Table ---------------------
object{ 
    Table( 0.3, // Table__Height, 
           0.8, // Table__Half_Width_X, 
           0.6, // Table__Half_Width_Z, 
           0.02  // Table__Feet_Radius, 
     )
     translate< R_x-2,0,R_z-3.5>
}

object{ 
    Table( 0.3, // Table__Height, 
           0.3, // Table__Half_Width_X, 
           0.3, // Table__Half_Width_Z, 
           0.02  // Table__Feet_Radius, 
     )
     translate< R_x-0.8,0,R_z-4.5>
}

// --------------------- Vase ---------------------
object {
    vase
    scale 0.04
    translate< R_x-0.8,0.4,R_z-4.5>
}
// --------------------- Tree ---------------------
#declare Tree_01 = object{TREE double_illuminate hollow}
object{ Tree_01
        scale 2
        translate< R_x+2, 0, R_z-0.5>
      } 

// --------------------- Frame object ---------------------
#declare frame = 
object{
    difference {
        box {
            <0, 0, 0>, <3, 4, 0.25> // <x, y, z> near lower left corner, <x, y, z> far upper right corner
        }
        box {
            <0.3, 0.3, -0.3>, <2.7, 3.7, 0.8> // <x, y, z> near lower left corner, <x, y, z> far upper right corner
        }
    }
}

#declare paint = 
box{
  <0.3, 0.3, 0>, <2.7, 3.7, 0.01>
}

// --------------------- Frame p1 ---------------------
object {
  frame
  scale 0.2
  translate <R_x-1.5, 1.2, R_z-0.1>
  texture { T_Wood12 }
}

object {
  paint
  texture{
    pigment{
        image_map {
          png "scenes/p1.png"
          map_type 0
        }
        scale 4
    }
  }
  scale 0.2
  translate <R_x-1.5, 1.2, R_z-0.07> 
}


// --------------------- Frame p3 ---------------------
object {
  frame
  rotate z*90
  scale 0.3
  translate <R_x-2, 1.4, R_z-0.1>
  texture { T_Wood17 }
}

object {
  paint
  rotate z*90
  texture{
    pigment{
        image_map {
          tiff "scenes/p3.tif"
          map_type 0
        }
        scale 3
    }
  }
  scale 0.3
  translate <R_x-2, 1.4, R_z-0.07>
}

// --------------------- Frame p4 ---------------------
object {
  frame
  rotate y*90
  scale 0.3
  translate <R_x-0.05, 1.1, R_z-0.75>
  texture { T_Wood17 }
}

object {
  paint
  rotate y*90
  texture{
    pigment{
        image_map {
          png "scenes/p4.png"
          map_type 0
        }
        scale 4
        rotate y*90
    }
  }
  scale 0.3
  translate <R_x-0.02, 1.1, R_z-0.75>

}

// --------------------- lamp ---------------------

cylinder {
  <0, 0, -1>, <0, 0, 1>, 0.005 // center of one end, center of other end, radius
  pigment{color Black}
  rotate x*90
  translate <R_x-1.94, 3.0, R_z-3>
}

object {
  lamp
  scale 0.001
  translate <R_x-2, 2.0, R_z-3>
  texture{ T_Brass_1A }
  // texture {T_Brass_1A}
  // finish { 
  //   brilliance 0 
  //   reflection 0 
  // }
}

light_source { 
  <0,0,0> color rgb<0.96, 0.93, 0.82>
  spotlight
  jitter
  radius 5
  falloff 14
  adaptive 1
  tightness 10
  looks_like{ 
    sphere{ 
      <0,0,0>,0.1
      texture { pigment { rgb<0.96, 0.93, 0.82> } }
      // finish { ambient 1 }
      finish {ambient 1 }
    }
  }
  translate <R_x-1.94,2.05, R_z-3>
}

