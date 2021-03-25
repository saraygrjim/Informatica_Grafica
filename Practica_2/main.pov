#include "colors.inc"
#include "functions.inc"
#include "debug.inc"
#include "rand.inc"
#include "textures.inc"
#include "woods.inc"
#include "./textures.pov"
#include "obj/tree.pov"
#include "obj/lightning.pov"

#declare s = seed(982143);

global_settings
{
  assumed_gamma 1.0
  ambient_light 1

}

#declare Camera_Location = < 30, 5,-100.00> ;  // front view
#declare Camera_Look_At  = < 20,25,  0.00> ;
#declare Camera_Angle    =  100 ;

camera{ // ultra_wide_angle // orthographic 
        location Camera_Location
        right    x*image_width/image_height
        angle    Camera_Angle
        look_at  Camera_Look_At
}

light_source{< 3000,3000,-3000> color rgb<1,1,1>*0.2 shadowless}                // sun 
//light_source{  <0, 20, -80>  color rgb<0.9,0.9,1>*0.1 shadowless}// flash


plane { 
  <0,1,0>, 500 
  hollow //!!!!
  texture { bozo scale 1
          texture_map{ 
                [ 0.0  pigment{color rgbf<0.27,0.49,0.99,0.8>} ]
                [ 0.5  pigment{color rgbf<0.27,0.49,0.99,0.6> }]
                [ 0.6  pigment{color rgbf<0.24,0.38,0.7,0.4> }] 
                [ 1.0  pigment{color rgbf<0.24,0.38,0.7,0.2> }] 
                } 
          scale <500,1,1000>
        } 
  translate<-400,0,300> 
}



fog { 
      fog_type   2
      distance   400
      color      White*0.9
      fog_offset 0.1
      fog_alt    17
      turbulence 1.8
    }

// ground ------------------------------------------------------------
plane { <0,1,0>, 0 
        texture{ Soil_Texture } 
      } // end of plane                                  
// end of ground

//Bucle para posicionar los arboles del bosque pero me he rayao mucho

#declare n_trees = 25;

#local ctr = 0;
#local px = -100;
#local pz = 0;
union {
  #while (ctr < n_trees)
    #local tmp = mod(ctr,3);
    #if (tmp = 0)
      #local leaf_ratio = 0;
    #else
      #local leaf_ratio = 1;
    #end

    #local pz = RRand(-50,50,s);
    
    union {
      tree(0, 2, 12, px, 0, pz, leaf_ratio)
    }

//    #local leaf_max = 20;
//    #local leaf_counter = 0;
//    #while (leaf_counter < leaf_max)
//        #local soil_x = px + RRand(-5,5,s); 
//        #local soil_z = pz + RRand(-5,5,s); 
//        leaf(soil_x, 0, soil_z, 0, 0, 0)
//        #local leaf_counter = leaf_counter + 1;
//    #end
//
    #local px = px + 10;
    #local ctr = ctr+1;
  #end
}

object {
    union {
        lightning(
            0,  //depth
            0.2,  // radius
            5,  // length
            -100, 300, 20, // initial point 
        )
    }
    translate y*5
    translate z*40
    hollow
    no_shadow
}


object {
    union {
        lightning(
            0,  //depth
            0.2,  // radius
            5,  // length
            90, 300, 20, // initial point 
        )
    }
    translate y*5
    translate z*40
    hollow
    no_shadow
}
light_source{ <0, 0, 0> 
               color rgb <0,0,1>*0.9
               area_light           
               <90, 0.1, 0> <90, 0.9, 0> //
               1, 5                    //
            }  

// #declare rayo1 =
//   union {
    
//         lightning(
//             0,  //depth
//             0.2,  // radius
//             5,  // length
//             90, 300, 20, // initial point 
//         )
//     }


// object {
//   rayo1
//   translate y*5
//   translate z*40
// }
