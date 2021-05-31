// #include "colors.inc"
// camera {
//     location <6, 15, -50>
//     look_at <0, .8, 0>
//     angle 15
// }

// light_source{
//     <20,15,-60>, White
// }

// sky_sphere {
//     pigment{
//         gradient y
//         color_map{
//             [0 color White]
//             [1 color Blue]
//         }
//         scale 2
//         translate <0,1,0>
//     }
// }
#declare vase =
difference {   

    sor {
        10,
        <0, -3.1>
        <1, -3>
        <2, -2.3>
        <3, -1.3>
        <3.8, 0>
        <4, 1.3>
        <3.5, 2>
        <3.2, 2.5>
        <3.1, 3>
        <3, 5>
        scale 1/6
        translate <0 ,0.5, 0>
        pigment { 
           image_map {
               jpeg "textures/vase.jpg"
               map_type 2 
           }
        }
        finish { ambient 0.5 }

        translate <0 ,-0.5, 0>
        scale 6
    }

    cylinder {
        <0,0,0>,<0,3.2,0>, 3
        pigment { White }
        finish { ambient 0.4 }
    }
}