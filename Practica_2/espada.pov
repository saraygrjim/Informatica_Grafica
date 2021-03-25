// PoVRay 3.7 Scene File "Light_Sword_1.pov"
// author: Friedrich A. Lohmueller, Oct-2008/Aug-2009 / Jan-2011
// email: Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//--------------------------------------------------------------------------
#version 3.7;
global_settings{assumed_gamma 1.0} 
#default{ finish{ ambient 0.1 diffuse 0.9 }} 
//--------------------------------------------------------------------------
//--------------------------------------------------------------------------
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
//--------------------------------------------------------------------------
// camera ------------------------------------------------------------------
#declare Camera_1 = camera {/*ultra_wide_angle*/ angle 65   // diagonal view
                            location  < 0.00, 0.50,-1.00>
                            right     x*image_width/image_height
                            look_at   < 0.00, 0.50, 0.00> }
camera{Camera_1}
// sun ---------------------------------------------------------------------
#local Sky_Dimmer = 0.25; 

light_source{<1500,2500,-2500> color White*0.9*Sky_Dimmer           media_interaction off}  // sun light
light_source{<0.00,0.50,-1.00> color rgb<0.9,0.9,1>*0.1*Sky_Dimmer  media_interaction off}  // flash light

// sky ---------------------------------------------------------------------
sky_sphere { pigment { gradient <0,1,0>
                       color_map { [0.00 rgb <1.0,1.0,1.0>*Sky_Dimmer]
                                   [0.30 rgb <0.0,0.1,1.0>*Sky_Dimmer]
                                   [0.70 rgb <0.0,0.1,1.0>*Sky_Dimmer]
                                   [1.00 rgb <1.0,1.0,1.0>*Sky_Dimmer] 
                                 } 
                       scale 2         
                     } // end of pigment
           } //end of skysphere
// fog ---------------------------------------------------------------------
fog{fog_type   2
    distance   50
    color      White*Sky_Dimmer
    fog_offset 0.1
    fog_alt    2.0
    turbulence 0.8}
// ground ------------------------------------------------------------------
plane{ <0,1,0>, 0 
       texture{ pigment{ color rgb <1.00,0.95,0.8>}
                normal { bumps 0.75 scale 0.025  }
                finish { phong 0.1 } 
              } // end of texture
     } // end of plane
//--------------------------------------------------------------------------
//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------




// --------------------------------------------------------------- Light_Sword macro
// ---------------------------------------------------------------------------------
#macro Light_Sword(  Blade_Length, 
                     Handle_Len, 
                     
                     Aura_R,   //
                     Center_R, //
                     Handle_R, // 
                     
                     Aura_Color,   //                                                        
                     Center_Color, //
                     Shining_Color // 
                   )
// ---------------------------------------------------------------------------------
#local D = 0.01;       
#local LS_Len = Blade_Length; 
// ---------------------------------------------------------------------------------
#ifndef( Handle_Texture )
#declare Handle_Texture =  
  texture{ pigment{ color rgb< 1, 1, 1>*0.15 } //  color Gray15
           normal { bumps 0.5 scale 0.05 }
           finish {  phong 1  }
         } // end of texture 
#end 
// ---------------------------------------------------------------------------------
// containers for media, using Merge_ON=1
#local Blade_Aura =  
 object{ Round_Cylinder(<0,0,0>, <0,Blade_Length,0>,Aura_R+Center_R ,  Aura_R-D, 1)  
       } // ------------------------------------------------------------------------
#local Blade_Center = // uses Merge_ON
 object{ Round_Cylinder(<0,0,0>, <0,Blade_Length-Aura_R,0>,Center_R ,Center_R-D, 1)  
       } // ------------------------------------------------------------------------
// ---------------------------------------------------------------------------------
union{ 
 light_source{ <0, 0, 0> 
               color rgb Shining_Color
               area_light           
               <0, 0.1, 0> <0, 0.9, 0> //
               1, 5                    //
             } //------------------------------------
 object{ Blade_Center  
         pigment{ color rgbf<1,1,1,1>} //color Clear
         hollow
         interior{ media{ emission Center_Color }}   
       } //------------------------------------------            
        
 object{ Blade_Aura 
         pigment{ color rgbf<1,1,1,1>} //color Clear
         hollow
         interior{ media{ emission  Aura_Color }}   
       } //------------------------------------------ 
 // Handle 
 union{ 
  object{ Round_Cylinder(<0,-Handle_Len,0>, <0,Center_R,0>,Handle_R ,Handle_R/3, 0)} 
  torus{ Handle_R,Handle_R/4 translate<0,0,0> } 
  texture{ Handle_Texture }
  } // end Handle
translate<0,Handle_Len/2,0>
} // end of union   
#end // --------------------------------------------------------------- end of macro  
// ---------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------






// ----------------------------------------------------------
// ----------------------------------------------------------
object{ Light_Sword( 1.0, // Blade_Length, 
                     0.15, // Handle_Len, 
                     
                     0.04,     // Aura_R,   
                     0.02,     // Center_R, 
                     0.025,     // Handle_R,  
                     
                     <1.0,0.3,0.8>*1.5,     // Aura_Color,  
                     <1.0,0.1,0.5>*7 , // Center_Color,
                     <0.5,0.0,0.3>*0.75      // Shining_Color
                   ) // --------------------------------

          scale<1,1,1>  rotate<0,0,-50>  translate<-0.30,0.20,0>  
       }  // end of object "Light_Sword" -------------------- 
// ----------------------------------------------------------
// ----------------------------------------------------------

