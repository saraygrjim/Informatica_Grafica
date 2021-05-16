#declare Window_Glass = 
       texture{ pigment{ rgbf <0.98, 0.98, 0.98, 0.95> *0.85}
                finish { ambient 0.1 diffuse 0.1 reflection 0.2  
                         specular 0.8 roughness 0.0003 phong 1 phong_size 400}
}

#declare Frame_Texture =
      texture { pigment{color White*0.85}
                //normal {bumps 0.5 scale 0.005} 
                finish {ambient 0.15 diffuse 0.85 phong 1}
}

#declare Window_Hole_Texture =
      texture { pigment{color White*0.85}
                //normal {bumps 0.5 scale 0.005} 
                finish {ambient 0.15 diffuse 0.85 phong 1}
}

#declare Wall_Texture =
      texture { pigment{color White*0.75}
                //normal {bumps 0.5 scale 0.005} 
                finish {ambient 0.15 diffuse 0.85 phong 1}
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

#declare Window_Transform = transform{ rotate<0, 90,0> translate<R_x+Wall_D,0.001,R_z/2+1> } ;

#declare Window = 
    union{
        // Union of frames
        union{
            // Left frame 
            box{<0,B_y,-DF_z/2>,<DF_d,D_y,DF_z/2> }
            // Right frame 
            box{<0,B_y,-DF_z/2>,<DF_d,D_y,DF_z/2> scale<-1,1,1> translate<D_x,0,0>}
 
            // Bottom frame
            box{<0,0,-DF_z/2>,<D_x,DF_d,DF_z/2> translate<0,B_y,0>}
            // Upper frame
            box{<0,0,-DF_z/2>,<D_x,DF_d,DF_z/2> scale<1,-1,1> translate<0,D_y,0>}

            texture {Frame_Texture}   
        }  
     // Glass 
     box{ <D,D,-0.002>,<D_x-D,D_y-D,0.002> 
         texture {Window_Glass}
     }
    scale < 1,1,1>
    rotate<0,0,0>  translate<0,0,0>         
}   

#declare Window_Hole = 
    box{<0,B_y,-0.50>,<D_x,D_y,0.50>
    texture{ Window_Hole_Texture }   
}

