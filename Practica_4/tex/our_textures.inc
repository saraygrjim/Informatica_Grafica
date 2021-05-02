#declare Pool_Tex = 
  texture{ 
    pigment {rgb<0.95, 0.92, 0.85> }
    finish{
      brilliance 0.6
      ambient 0.6
    }  
  } 


#declare Water_Material =  
  material{ 
    texture {
      pigment { rgbf <0.66, 0.83, 0.75, 1>*0.5 }
      finish  {
          ambient 0
          diffuse 0.7
          reflection 0.35
          roughness 0.0003
        }
        normal {
            bumps
            scale <200,10,200>
        }
    }
    interior {ior 1.33}
  }
    
  
    
#declare Soil_Tex = 
  texture { 
    pigment{ 
      image_map { 
          jpeg "tex/soil.jpeg" 
          map_type 0  // Esfera 
      } 
      rotate x*90
    }    
    finish { 
      ambient 0.62 
    } 
  }

#declare Soil_pigment = pigment { rgb<0.77,0.6,0.35>*0.7}

#declare Pigment_01 =  
    pigment{ 
      scale <3,1,3>*0.12
      translate<1,0,0>
    } 

#declare Pigment_Function_01 = 
    function { 
        pigment { Pigment_01 }
    } 

//Right wall
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
      brilliance 0.3
      crand 0.05  
      specular 0.6 
      ambient 0.5 
      diffuse 0.9 
      phong 1 
    } 
  }

//Left Wall
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
      brilliance 0.3  
      crand 0.05  
      specular 0.6 
      ambient 0.5 
      diffuse 0.9 
      phong 1 
    } 
  }

// Front wall
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
      brilliance 0.3  
      crand 0.05  
      specular 0.6 
      ambient 0.5 
      diffuse 0.9 
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
      brilliance 0.6 
      crand 0.05 
      ambient 0.8
      diffuse 0.6
      phong 1
    }
      // scale x*4
      // scale y*4
      rotate 90*y
  }



#declare Floor_Tex = 
  texture {
    pigment{
      image_map {
          jpeg "tex/floor.jpeg"
          map_type 0  // Esfera
      }
    }
    finish{
      brilliance .6
      ambient 0.6
    }
    scale 5
    rotate 90*x
  }

#declare Border_Tex = 
  texture {
    pigment{
      image_map {
          jpeg "tex/floor.jpeg"
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
    scale 5
    // rotate 90*x
  }

#declare RBorder_Tex = 
  texture {
    pigment{
      image_map {
          jpeg "tex/floor.jpeg"
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
    scale 5
    rotate 90*y
  }