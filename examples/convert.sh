wavfile=$(echo "$1" | cut -f 1 -d '.').wav
ffmpeg -f s16le -ar 48k -ac 1 -i $1 $wavfile
echo aplay $wavfile to play the file.  
