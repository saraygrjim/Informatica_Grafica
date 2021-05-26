#include "metals.inc"

// Glass material
#declare Table_Material = material{
    texture{
        pigment{ rgbf<.98,.98,.98,0.4>}
        finish { 
            ambient 0.0
            diffuse 0.15
            reflection 0.2
            specular 0.6
            roughness 0.005
            reflection { 0.03, 1.0 fresnel on }
            conserve_energy
        }    
    }

    interior{ 
        ior 1.5
        fade_power 1001
        fade_distance 0.5
        fade_color <0.8,0.8,0.8>
    }
}

#macro Table( Table__Height ,Table__Half_Width_X,Table__Half_Width_Z,Table__Feet_Radius)

    #local CR = Table__Feet_Radius; 
    #local CX = Table__Half_Width_X - CR; 
    #local CZ = Table__Half_Width_Z - CR; 
    #local SH = Table__Height - CR; 

    #local SX = Table__Half_Width_X ; 
    #local SZ = Table__Half_Width_Z ; 
    #local ST = 2*CR ; 

    union{
        // Table frame
        union {
            // feet
            cylinder { <0,0,0>,<0,SH,0>, CR translate< CX,0,-CZ> } 
            cylinder { <0,0,0>,<0,SH,0>, CR translate<-CX,0,-CZ> }
            cylinder { <0,0,0>,<0,SH,0>, CR translate< CX,0, CZ> }
            cylinder { <0,0,0>,<0,SH,0>, CR translate<-CX,0, CZ> }
            // round borders
            cylinder { <-CX,0,  0>,< CX,0, 0>, CR  translate<0,SH, CZ> }
            cylinder { <-CX,0,  0>,< CX,0, 0>, CR  translate<0,SH,-CZ> }
            cylinder { <  0,0,-CZ>,<  0,0,CZ>, CR  translate< CX,SH,0> }
            cylinder { <  0,0,-CZ>,<  0,0,CZ>, CR  translate<-CX,SH,0> }
            // sphere joins
            sphere{ < CX,SH,-CZ>, CR  } 
            sphere{ <-CX,SH,-CZ>, CR  } 
            sphere{ < CX,SH, CZ>, CR } 
            sphere{ <-CX,SH, CZ>, CR } 

            texture {T_Chrome_4E}
        }
        // Table surface 
        object {
            box { <-CX, 0.00, -CZ>,< CX, 0, CZ>  translate<0,SH,0> }
            material {Table_Material}
        }
    }
#end  
