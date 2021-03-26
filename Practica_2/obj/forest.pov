// Coloca n arboles espaciados linealmente en el eje X
// y aleatoriamente en el eje Z acotado entre [z_initial-z_end]
#macro forest(n_trees, z_initial, z_end)

    #local ctr = 0;
    #local px = -100; // Se comienza en la x=-100
    #local pz = 0; 

    union {
      #while (ctr < n_trees)
         // Uno de cada 3 arboles no tendra hojas
        #local tmp = mod(ctr,3);
        #if (tmp = 0)
          #local leaf_ratio = 0;
        #else
          #local leaf_ratio = 1;
        #end

        // Posicion Z aleatoria
        #local pz = RRand(z_initial,z_end,s);
        
        union {
            // Arbol con radio 2 y longitud de rama 12 (inicialmente)
            // En la posicion (px, 0, pz) 
            // Tendrá hojas si leaf_ratio es 1
          tree(0, 2, 12, px, 0, pz, leaf_ratio)
        }
        // Posicion x se incrementa linealmente
       #local px = px + 10;
        #local ctr = ctr+1;
      #end
    }
#end

