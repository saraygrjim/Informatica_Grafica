#declare max_depth = 6;   // Profundidad de la recursividad
#declare r_ratio   = 0.8; // Ratio en el que decrece el ratio de las ramas
#declare l_ratio   = 0.8; // Ratio en el que decrece el tamaño de las ramas
#declare angle_max = 80;  // Maximo angulo que puede girar una rama respecto a su rama padre
#declare angle_min = -80; // Minimo angulo que puede girar una rama respecto a su rama padre

// Crea una hoja en la posicion (px,py,pz) con el angulo (ax, ay, az)
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

// Crea una arbol en la posicion (px,py,pz) con el angulo (ax, ay, az), con radio r, longitud de rama l
// y un numero de hojas determinado por leaf_ratio
#macro tree(depth, r, l, px, py, pz, leaf_ratio)
    #if (depth < max_depth)
        #local r2 = r*r_ratio; // Calculo del nuevo radio
        #local l2 = l*l_ratio; // Calculo de la nueva longitud

        // A partir de la mitad de la profundiad reducir el angulo
        // y el radio
        #if (depth > max_depth/2) 
          #declare r_ratio = 0.6;
          #declare angle_max = 70;
          #declare angle_min = -70;
        #end
        
        // Si es una rama (profundidad mayor que 0)
        #if (depth > 0)
            // Se seleccionan angx, angy, angz aleatorios
            #local angx = RRand(angle_min, angle_max, s); 
            #local angy = RRand(angle_min, angle_max, s);
            #local angz = RRand(angle_min, angle_max, s);        
        #else // Si es el tronco (profundiad 0)
            #local angx = 0;
            #local angy = 0;
            #local angz = 0;
        #end
        
        // Calculo de las posiciones en funcion de los angulos
        #local px2 = px + l2*sin(radians(angx));
        #local py2 = py + l2*cos(radians(angy));
        #local pz2 = pz + l2*sin(radians(angz));

        // Construccion de la rama a traves de un cono
        // y una esfera para crear union entre ramas natural
        cone {
          <px, py, pz>, r
          <px2, py2, pz2>, r2
          texture{ Stem_Texture }
        }
        sphere {
            <px2, py2, pz2>, r2
            texture{ Stem_Texture }
            
        }
        
        // Ramificacion aleatoria:
        // Con probabilidad 0.8 seran 3 ramas.
        // Con probabilidad 0.2 seran 2 ramas.
        tree(depth+1, r2, l2, px2, py2, pz2, leaf_ratio)
        #local k = SRand(s);
        #if (k > 0.2)
          tree(depth+1, r2, l2, px2, py2, pz2, leaf_ratio)
          tree(depth+1, r2, l2, px2, py2, pz2, leaf_ratio)
        #else        
          tree(depth+1, r2, l2, px2, py2, pz2, leaf_ratio)
        #end

    #else // Si la profundidad es la ultima entonces se pueden pintar hojas
        // Determinar si se pintan hojas o no en funcion de leaf_ratio
        #local max_leafs = 0;
        #if (leaf_ratio <= 0.5)
          #local max_leafs = 0;
        #else
          #local max_leafs = 20;
        #end
        
        // Se pintan hojas de manera aleatoria alrededor de la posicion de la rama.
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
