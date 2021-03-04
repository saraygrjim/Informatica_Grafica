povray -H2300 -W2100 main.pov
if [ "$?" -eq 0 ]
then
    mimeopen main.png 
fi
