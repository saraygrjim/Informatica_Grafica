povray -W2000 -H1800 main.pov
if [ "$?" -eq 0 ]
then
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        mimeopen main.png 
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        open main.png 
    fi
fi
