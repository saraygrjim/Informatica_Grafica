#include "colors.inc"
#include "functions.inc"
#include "debug.inc"
#include "rand.inc"
#include "textures.inc"
#include "woods.inc"
#include "./textures.pov"

#declare s = seed(982143);

#declare Camera_Location = < 0.00, 1.00,-100.00> ;  // front view
#declare Camera_Look_At  = < 0.00,11.50,  0.00> ;
#declare Camera_Angle    =  50 ;

camera{ // ultra_wide_angle // orthographic 
        location Camera_Location
        right    x*image_width/image_height
        angle    Camera_Angle
        look_at  Camera_Look_At
}

light_source{< 3000,3000,-3000> color rgb<1,1,1>*0.9}                // sun 
light_source{  <0, 20, -80>  color rgb<0.9,0.9,1>*0.1 shadowless}// flash


// sky ---------------------------------------------------------------------
union { // make sky planes: 

 plane { <0,1,0>, 500 hollow //!!!!
        texture { bozo scale 1
                  texture_map{ 
                       [ 0.0  T_Clouds ]
                       [ 0.5  T_Clouds ]
                       [ 0.6  pigment{color rgbf<1,1,1,1> }] 
                       [ 1.0  pigment{color rgbf<1,1,1,1> }] 
                      } 
                       scale <500,1,1000>} translate<-400,0,300> } 

 plane { <0,1,0> , 10000  hollow
        texture{ pigment {color rgb<0.24,0.38,0.7>*0.50}
                 finish {ambient 1 diffuse 0}}}
scale<1.5,1,1.25>  
rotate<0,0,0> translate<0,0,0>}                          
// end of sky


// fog on the ground -------------------------------------------------
fog { fog_type   2
      distance   250
      color      White*0.75
      fog_offset 0.1
      fog_alt    1.5
      turbulence 1.8
    }
// end of fog

// ground ------------------------------------------------------------
plane { <0,1,0>, 0 
        texture{ Soil_Texture } 
      } // end of plane                                  
// end of ground


// light_source {
//   <-250,500,150>, color White
//   spotlight
//   radius 10
//   falloff 600
//   jitter
// }

// light_source {
//   <0,40,-150>, color White
//   spotlight
//   radius 10
//   falloff 100
//   jitter
// }


// // sky ---------------------------------------------------------------
// plane{<0,1,0>,1 hollow  // 
      
//         texture{ pigment {color rgb<0.1,0.3,0.75>*0.7}
//                  #if (version = 3.7 )  finish {emission 1 diffuse 0}
//                  #else                 finish { ambient 1 diffuse 0}
//                  #end 
//                } // end texture 1

//         texture{ pigment{ bozo turbulence 0.75
//                           octaves 6  omega 0.7 lambda 2 
//                           color_map {
//                           [0.0  color rgb <0.95, 0.95, 0.95> ]
//                           [0.05  color rgb <1, 1, 1>*1.25 ]
//                           [0.15 color rgb <0.85, 0.85, 0.85> ]
//                           [0.55 color rgbt <1, 1, 1, 1>*1 ]
//                           [1.0 color rgbt <1, 1, 1, 1>*1 ]
//                           } // end color_map 
//                          translate< 3, 0,-1>
//                          scale <0.3, 0.4, 0.2>*3
//                         } // end pigment
//                  #if (version = 3.7 )  finish {emission 1 diffuse 0}
//                  #else                 finish { ambient 1 diffuse 0}
//                  #end 
//                } // end texture 2
//        scale 10000
//      } //-------------------------------------------------------------

// sky_sphere {
//   pigment {
//     gradient y
//     color_map {
//       [0.00 0.200 color rgb <0.1, 1, 0.1>
//                    color rgb <0.1, 0.4, 0.1>]
//       [0.200 0.300 color rgb <0.1, 0.4, 0.4>
//                    color rgb <0.1, 0.1, 0.8>]
//       [0.300 1.000 color rgb <0.1, 0.1, 0.6>
//                    color rgb <0, 0, 0>]
//     }
//     scale 2
//     translate -y
//   }
//   pigment {
//     bozo
//     turbulence 0.7
//     octaves 6
//     omega 0.7
//     lambda 2
//     color_map {
//         [0.0 0.1 color rgb <0.85, 0.85, 0.85>
//                  color rgb <0.75, 0.75, 0.75>]
//         [0.1 0.6 color rgb <0.75, 0.75, 0.75>
//                  color rgbt <1, 1, 1, 1>]
//         [0.6 1.0 color rgbt <1, 1, 1, 1>
//                  color rgbt <1, 1, 1, 1>]
//     }
//     scale <0.2, 0.05, 0.2>
//   }
// }

// // plane{ <0,1,0>,0 
// //   texture {
// //     pigment {color ForestGreen }
// //     normal { bumps 1 scale 0.1 }
// //     //finish { diffuse 0.5 crand 0.05 specular .1 roughness .01 irid { 0.1 thickness 0.1 turbulence 0.1 } }
// //   }
// }




#macro leaf(px, py, pz, ax, ay, az)
object{
  union{
    cone{ <0,0,0>,0.1,<1,1,0>,0.1}
    sphere{ <2.7,10,0>,2 scale <1,0.1,0.5> }
    texture{ Leaves_Texture_1 }   
    interior_texture{ Leaves_Texture_2 }   
  }
  scale <0.4,0.4,0.4>
  rotate <ax,ay,az>
  translate <px,py,pz>
}
#end

#declare max_depth = 6;
#declare r_ratio   = 0.8;
#declare l_ratio   = 0.8;
#declare angle_max = 105;
#declare angle_min = -105;

#macro tree(depth, r, l, px, py, pz)
    #if (depth < max_depth)
        #local r2 = r*r_ratio;
        #local l2 = l*l_ratio;

        #if (depth > max_depth/2)
          #declare r_ratio = 0.6;
          #declare angle_max = 70;
          #declare angle_min = -70;
        #end

        #if (depth > 0)
            #local angx = RRand(angle_min, angle_max, s);
            #local angy = RRand(angle_min, angle_max, s);
            #local angz = RRand(angle_min, angle_max, s);        
        #else
            #local angx = 0;
            #local angy = 0;
            #local angz = 0;
        #end
        
        #local px2 = px + l2*sin(radians(angx));
        #local py2 = py + l2*cos(radians(angy));
        #local pz2 = pz + l2*sin(radians(angz));
        cone {
            <px, py, pz>, r // <x, y, z>, center & radius of one end
            <px2, py2, pz2>, r2 // <x, y, z>, center & radius of the other end
            // texture { pigment { color Brown }} 
            // texture {
            //   pigment { DMFWood5} 
            //   normal { bumps 0.4 scale 0.05 }
            //   finish { roughness .1  }
            // }
            texture{ Stem_Texture }
        }
        sphere {
            <px2, py2, pz2>, r2 // <x, y, z>, radius
            texture{ Stem_Texture }
            // texture { pigment { color Brown }}
            // texture {
            //   pigment { DMFWood5} 
            //   normal { bumps 0.4 scale 0.05 }
            //   finish { roughness .1  }
            // }
        }  

        tree(depth+1, r2, l2, px2, py2, pz2)
        #local k = SRand(s);
        #if (k > 0.2)
          tree(depth+1, r2, l2, px2, py2, pz2)
          tree(depth+1, r2, l2, px2, py2, pz2)
        #else        
          tree(depth+1, r2, l2, px2, py2, pz2)
        #end
    #else
        #declare max_leafs = RRand(20, 40, s);
        #local ctr = 0;
        #while (ctr < max_leafs)
          #local leaf_x = RRand(px-5, px+5, s);
          #local leaf_y = RRand(py-5, py+5, s);
          #local leaf_z = RRand(pz-5, pz+5, s);
          #local leaf_ang_y = RRand(-30, 30, s);
          #local leaf_ang_z = RRand(-30, 30, s);
          
          leaf(leaf_x, leaf_y, leaf_z, angx, angy+leaf_ang_y, angz+leaf_ang_z)

          #local ctr = ctr+1;
        #end
       
    #end
#end

// Blucle para posicionar los arboles del bosque pero me he rayao mucho

// #declare n_trees = 10
// #macro position(depth, r, l)
//   #local ctr = 0
//   #local px = 0
//   #local py = 0
//   #local pz = 0
//   #while (ctr < n_trees)
//     tree(depth, r, l, px, 0, pz)
//     #local ctr = ctr+1;
//   #end
// #end


object {
    union {
        tree(
            0,  //depth
            2,  // radius
            12,  // length
            0, 0, 0, // initial point 
        ) 
    }
}

object {
    union {
        tree(
            0,  //depth
            2,  // radius
            12,  // length
            -40, 0, 30, // initial point 
        )
        rotate <0,20,0> 
        translate <0, -1, 0>
    }
}

