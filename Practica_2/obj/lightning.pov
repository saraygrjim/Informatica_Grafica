#include "rand.inc"
#include "colors.inc"
//#include "../textures.pov"

#declare s_light = seed(390572458);

#declare max_depth_light = 20;
#declare l_ratio_light  = 1.1;
#declare angle_max_light = 30;
#declare angle_min_light = -30;

#macro lightning(depth, r, l, px, py, pz)
    #if (depth < max_depth_light)
        #local l2 = l*l_ratio_light;

        // #if (depth > max_depth_light/2)
        //   #declare angle_max_light = 10;
        //   #declare angle_min_light = -10;
        // #end

        #if (depth > -1)
            #local angx = RRand(angle_min_light, angle_max_light, s);
            #local angy = RRand(angle_min_light, angle_max_light, s);
            #local angz = RRand(angle_min_light, angle_max_light, s);        
        #else
            #local angx = 0;
            #local angy = 0;
            #local angz = 0;
        #end
        
        #local px2 = px + l2*sin(radians(angx));
        #local py2 = py - l2*cos(radians(angy));
        #local pz2 = pz + l2*sin(radians(angz));
        union {
            

            cone {
                <px, py, pz>, 0.2 // <x, y, z>, center & radius of one end
                <px2, py2, pz2>, 0.2 // <x, y, z>, center & radius of the other end
                // texture {
                //     pigment {color White}
                //      finish { ambient 1.5
                //             diffuse 1
                //      }
                // }
                pigment{ color rgbf<1,1,1,1>} //color Clear
                hollow
                interior{ media{ emission <0,0,1>*7 }}   
            }

            cone {
                <px, py, pz>, 1 // <x, y, z>, center & radius of one end
                <px2, py2, pz2>, 1 // <x, y, z>, center & radius of the other end
                // texture {
                //     pigment {color White}
                //      finish { ambient 1.5
                //             diffuse 1
                //      }
                // }
                pigment{ color rgbf<1,1,1,1>} //color Clear
                hollow
                interior{ media{ emission  <0.1765,0.5765,0.9529>*1 }}      
            }

        }
        
        lightning(depth+1, r, l2, px2, py2, pz2)
        #local k = RRand(0, 1, s_light);
        #if (k < 0.1 & depth > 10)
           lightning(depth+1, r, l2, px2, py2, pz2)
         #end
    #end
#end