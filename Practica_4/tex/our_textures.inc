#declare Pool_Tex = 
          texture{ pigment {rgb<0.95, 0.92, 0.85> }
          finish{
            brilliance 0.6
            ambient 0.6
          }  
} 


#declare Water_Material =  
material{    
  texture {
    pigment { rgbf <0.8, 1, 0.98, 0.9> }
    finish  {
        ambient 0.1
        diffuse 0.1
        reflection 0.1
        specular 0.8
        roughness 0.0003
        phong 1 
        phong_size 400
     }
  }
  interior {ior 1.33}
}

#declare Soil_pigment = pigment { rgb<0.77,0.6,0.35>*0.7}
// #declare Soil_function = {
//   pigment { 
//     Soil_pigment
//   }
// }

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

#declare RWall_Tex = 
    texture { 
    pigment{ 
      image_map { 
          jpeg "tex/wall.jpeg" 
          map_type 0  // Esfera 
      } 
      scale 10 
      rotate y*90
    }    
    finish { 
      brilliance 0.5  
      crand 0.05  
      specular 0.6 
      ambient 0.62 
      diffuse 0.6 
      phong 1 
    } 
}

#declare LWall_Tex = 
    texture { 
    pigment{ 
      image_map { 
          jpeg "tex/wall.jpeg" 
          map_type 0  // Esfera 
      } 
      scale 10 
      rotate y*-90
    }    
    finish { 
      brilliance 0.5  
      crand 0.05  
      specular 0.6 
      ambient 0.62 
      diffuse 0.6 
      phong 1 
    } 
}


#declare Wall_Tex = 
    texture { 
    pigment{ 
      image_map { 
          jpeg "tex/wall.jpeg" 
          map_type 0  // Esfera 
      } 
      scale 10 
    }    
    finish { 
      brilliance 0.5  
      crand 0.05  
      specular 0.6 
      ambient 0.62 
      diffuse 0.6 
      phong 1 
    } 
}

#declare Tile_Tex = 
  texture {
    pigment{
      image_map {
          jpeg "tex/tile.jpeg"
          map_type 0  // Esfera
      }
    }
    finish {
      brilliance 0.5 
      crand 0.05 
      ambient 0.62
      diffuse 0.6
      phong 1
    }
      // scale x*4
      // scale y*4
      rotate 90*y
  }