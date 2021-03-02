povray -H1300 -W1800 main.pov
if [ "$?" -eq 0 ]
then
    mimeopen main.png 
fi
