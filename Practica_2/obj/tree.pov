#macro leaf(px, py, pz, ax, ay, az)
  object{
    union{
      cone{ <0,0,0>,0.1,<1,1,0>,0.1 no_shadow}
      sphere{ <2.7,10,0>,2 scale <1,0.1,0.5> no_shadow}
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
#declare angle_max = 80;
#declare angle_min = -80;

#macro tree(depth, r, l, px, py, pz, leaf_ratio)
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
          texture{ Stem_Texture }
        }
        sphere {
            <px2, py2, pz2>, r2 // <x, y, z>, radius
            texture{ Stem_Texture }
            
        }
        
        tree(depth+1, r2, l2, px2, py2, pz2, leaf_ratio)
        #local k = SRand(s);
        #if (k > 0.2)
          tree(depth+1, r2, l2, px2, py2, pz2, leaf_ratio)
          tree(depth+1, r2, l2, px2, py2, pz2, leaf_ratio)
        #else        
          tree(depth+1, r2, l2, px2, py2, pz2, leaf_ratio)
        #end
    #else
        #local max_leafs = 0;
        #if (leaf_ratio <= 0.5)
          #local max_leafs = 0;
        #else
          #local max_leafs = 20;
        #end
        
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