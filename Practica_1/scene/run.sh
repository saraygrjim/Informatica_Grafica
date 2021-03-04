povray -H2300 -W2100 main.pov
if [ "$?" -eq 0 ]
then
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        mimeopen main.png 
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        open main.png 
    fi
fi
