#include "rand.inc"
#include "colors.inc"
//#include "../textures.pov"

#declare s_light = seed(0239802374);

#declare max_depth_light = 20;
#declare l_ratio_light  = 1.1;
#declare angle_max_light = 30;
#declare angle_min_light = -30;

#macro lightning(depth, l, px, py, pz)
    #if (depth < max_depth_light)
        #local l2 = l*l_ratio_light; // Longitud para el tramo actual a partir de la anterior

        // Angulos para el tramo actual a partir de los anteriores
        #local angx = RRand(angle_min_light, angle_max_light, s);
        #local angy = RRand(angle_min_light, angle_max_light, s);
        #local angz = RRand(angle_min_light, angle_max_light, s);        
        
        
        // Generamos la nueva posicion final del tramo a partir de la anterior 
        #local px2 = px + l2*sin(radians(angx));
        #local py2 = py - l2*cos(radians(angy));
        #local pz2 = pz + l2*sin(radians(angz));

        #if (depth = 0) // La luz se genera en la parte superior del rayo
            union {
                light_source{ // Luz que genera el rayo
                    <px, 400, 500>
                    color rgb <0.1765,0.5765,0.9529>*0.9
                    area_light <px, py, pz>, <px, py, pz>, 1, 1                    
                    adaptive 1
                    jitter
                }  

                cylinder  { // Parte interior del rayo 
                    <px, py, pz>, <px2, py2, pz2>, 0.2 
                    pigment{ color rgbf<1,1,1,1>} 
                    hollow
                    interior{ media{ emission <0,0,1>*7 }}  //color de dentro del rayo 
                }

                cylinder {  // Parte del rayo que deslumbra, misma posición, mayor radio
                    <px, py, pz>, <px2, py2, pz2>, 1 
                    pigment{ color rgbf<1,1,1,1>} 
                    hollow
                    interior{ media{ emission  <0.1765,0.5765,0.9529>*1 } }  //color de fuera del rayo    
                }

            }
        #end 
       
        #if (depth > 0 )
            union {
                cylinder  { // Parte interior del rayo 
                    <px, py, pz>, <px2, py2, pz2>, 0.2 
                    pigment{ color rgbf<1,1,1,1>}
                    hollow
                    interior{ media{ emission <0,0,1>*7 } }  //color de dentro del rayo
                }

                cylinder {  // Parte del rayo que deslumbra
                    <px, py, pz>, <px2, py2, pz2>, 1 // <x, y, z>
                    pigment{ color rgbf<1,1,1,1>} 
                    hollow
                    interior{ media{ emission  <0.1765,0.5765,0.9529>*1 }}  //color de fuera del rayo    
                }
            }
        #end
        
        // Genera una ramificacion siempre
        lightning(depth+1, l2, px2, py2, pz2)

        #local k = RRand(0, 1, s_light);
        #if (k < 0.15 & depth > 6) // A partir de uana profundidad marcada y de forma aleatoria genera una ramificación más 
           lightning(depth+1, l2, px2, py2, pz2)
        #end
    #end
#end