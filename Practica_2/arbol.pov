#include "colors.inc"
#include "functions.inc"

#declare ran = seed(28);


#declare radio_inicial = 2;
#declare radio_final = 0.01;
#declare reducccion_radio = 0.8517;

#declare longitud_inicial = 12;
#declare longitud_final = 0.1;
#declare reducccion_longitud = 0.8517;

#declare variacion_min_angulo = -30;
#declare variacion_max_angulo = 30;

#declare p_dos_ramas = 0.2;
#declare p_tres_ramas = 0.1;
#declare p_cuatro_ramas = 0.05;
#declare p_hoja = 0.02;

#declare max_profundiad = 45;
#declare p_cortar = 0.18;

background{
color rgb <0,0,0>
}

camera{
   location  <0, 20, -150>
   look_at   <0, 30, 0>
}

light_source {
  <-250,500,150>, color White
  spotlight
  radius 10
  falloff 600
  jitter
}

light_source {
  <0,40,-150>, color White
  spotlight
  radius 10
  falloff 100
  jitter
}

sky_sphere {
  pigment {
    gradient y
    color_map {
      [0.00 0.200 color rgb <0.1, 1, 0.1>
                   color rgb <0.1, 0.4, 0.1>]
      [0.200 0.300 color rgb <0.1, 0.4, 0.4>
                   color rgb <0.1, 0.1, 0.8>]
      [0.300 1.000 color rgb <0.1, 0.1, 0.6>
                   color rgb <0, 0, 0>]
    }
    scale 2
    translate -y
  }
  pigment {
    bozo
    turbulence 0.7
    octaves 6
    omega 0.7
    lambda 2
    color_map {
        [0.0 0.1 color rgb <0.85, 0.85, 0.85>
                 color rgb <0.75, 0.75, 0.75>]
        [0.1 0.6 color rgb <0.75, 0.75, 0.75>
                 color rgbt <1, 1, 1, 1>]
        [0.6 1.0 color rgbt <1, 1, 1, 1>
                 color rgbt <1, 1, 1, 1>]
    }
    scale <0.2, 0.05, 0.2>
  }
}



#declare textura=
texture{
  pigment { color <0.5,0.27,0.14> }
  normal { bumps 0.4 scale 0.05 }
  finish { crand 0.1 specular .1 roughness .1 irid { 0.1 thickness 0.1 turbulence 0.1 } }
}

#declare textura_hoja=
  texture{
    pigment { color <0,0.7,0> }
    finish { diffuse 0.4 specular .1 roughness .1 irid { 0.1 thickness 0.1 turbulence 0.1 } }
  }

#macro hoja(px, py, pz, ax, ay, az)
object{
  union{
    cone{ <0,0,0>,0.1,<1,1,0>,0.1}
    sphere{ <2.7,10,0>,2 scale <1,0.1,0.5> }
    texture{ textura_hoja }
  }
  scale <0.4,0.4,0.4>
  rotate <ax,ay,az>
  translate <px,py,pz>
}
#end

#macro arbol(px, py, pz, ax, ay, az, l, r, n)
  #declare p = rand(ran);
  #declare cortar = n / max_profundiad * p_cortar;
  #if ( p > cortar & l > longitud_final & r > radio_final & n < max_profundiad)
    #local l2 =  l * reducccion_longitud ;
    #local r2 =  r * reducccion_radio ;
    #local ax2 = ( ax + rand(ran) * ( variacion_max_angulo - variacion_min_angulo ) + variacion_min_angulo ) ;
    #local ay2 = ( ay + rand(ran) * ( variacion_max_angulo - variacion_min_angulo ) + variacion_min_angulo ) ;
    #local az2 = ( az + rand(ran) * ( variacion_max_angulo - variacion_min_angulo ) + variacion_min_angulo ) ;
    #local px2 = px + l2 * sin(radians(ax2));
    #local py2 = py + l2 * cos(radians(ay2));
    #local pz2 = pz + l2 * sin(radians(az2));
    cone{
     <px,py,pz>,r,
     <px2,py2,pz2>,r2
      texture{textura}
    }
    sphere{ <px2,py2,pz2>,r2 texture{textura}}
    arbol(px2, py2, pz2, ax2, ay2, az2, l2, r2, n+1)
    #local p = rand(ran);
    #if ( p < p_cuatro_ramas )
      arbol(px2, py2, pz2, ax2, ay2, az2, l2, r2, n+1)
    #end
    #if ( p < p_cuatro_ramas + p_tres_ramas + p_dos_ramas )
      arbol(px2, py2, pz2, ax2, ay2, az2, l2, r2, n+1)
    #end
    #if ( p < p_cuatro_ramas + p_tres_ramas + p_dos_ramas )
      arbol(px2, py2, pz2, ax2, ay2, az2, l2, r2, n+1)
    #end
  #else
    #declare p = rand(ran);
    #if ( p <p_hoja )
      hoja(px2, py2, pz2, ax2, ay2-45, az2+45)
    #end
    #declare p = rand(ran);
    #if ( p <p_hoja )
      hoja(px2, py2, pz2, ax2, ay2, az2)
    #end
    #declare p = rand(ran);
    #if ( p <p_hoja )
      hoja(px2, py2, pz2, ax2-45, ay2+45, az2-45)
    #end
    #declare p = rand(ran);
    #if ( p < p_hoja )
      hoja(px2, py2, pz2, ax2+45, ay2+45, az2-45)
    #end
  #end
#end


sphere{ <0,-1000,0>,1000 
  texture {
    pigment {color ForestGreen }
    normal { bumps 1 scale 0.1 }
    finish { diffuse 0.5 crand 0.05 specular .1 roughness .01 irid { 0.1 thickness 0.1 turbulence 0.1 } }
  }
}

object{ 
  union{
    arbol(0.0,0.0,0.0, 0,0,0, longitud_inicial, radio_inicial, 0)
  }
}

