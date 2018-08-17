# requires
# brew install ffmpeg giflossy

if [[ $1 == '' ]]
then
    echo ERROR: please provide a video filename to process
    return
else
    input_file="$1"
fi

if [[ $2 == '' ]]
then
    output_file=out-$(eval date  "+%m-%d_%H-%M-%S" ).gif
else
    output_file="$2"
fi

start_time=0.0
duration=0

ffmpeg \
-ss $start_time \
-t $duration \
-i $input_file \
-filter_complex "[0:v] fps=20,scale=-2:-2,split [a][b];[a] palettegen [p];[b][p] paletteuse" \
$output_file

# echo INFO: compress GIF using giflossy and gifsicle
# gifsicle -O3 --lossy=50 --scale 0.8 -o $output_file $output_file