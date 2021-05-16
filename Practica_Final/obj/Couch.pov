#include "shapes.inc"

#declare couch = merge {
    object{
        union {
            Round_Box(<0.1,0,0>,<-0.5,2,2>,0.2,0)

            Round_Box(<-0.4,0,0>,<-2.5,1,1.8>,0.2,1)
            Round_Box(<-2.4,0,0>,<-5,1,1.8>,0.2,1)

            Round_Box(<-4.9,0,0>,<-5.5,2,2>,0.2,0)

            Round_Box(<0,0,1.8>,<-2.5,2.7,2>,0.2,1)
            Round_Box(<-2.4,0,1.8>,<-5.5,2.7,2>,0.2,1)
            texture {
                pigment {color Green}
            }

        translate <0,0.5,0>
        }
   }
   object {
       cylinder {<0,0,0>,<0,0.7,0>,0.1}
       rotate <25,0,25>
   }
   object {
       cylinder {<0,0,0>,<0,0.7,0>,0.1}
       rotate <25,0,-25>
       translate <-5.5,0,0>
   }
}



