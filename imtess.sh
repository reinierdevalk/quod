# !/bin/bash
# 
# original script at http://stackoverflow.com/questions/11978986/ocr-getting-text-from-image-using-tesseract-3-0-and-imagemagick-6-6-5
#
# Usage:
# imtess.sh image suffix 

image=$1
suffix=$2  
tmp=${suffix%.*} # remove .txt from suffix: remove substring from '.' (see https://stackoverflow.com/questions/428109/extract-substring-in-bash)
suffix=$tmp

start_scale=113
end_scale=113
increment_scale=100
tmp_img=dst.tif
attempt=1
lang='deu' #+deu_frak'
path=$(dirname $1)"/"
filename=$(basename $1 .jpg)
outp="$path$filename$suffix" # .txt is added by Tesseract by default

for ((scale=$start_scale, attempt=$attempt; scale <= $end_scale ; scale=scale+$increment_scale, attempt++))
        do
                
                echo "imtess-log --- creating temporary image"
                convert $image $tmp_img

                # NB: the +repage is necessary to prevent "negative image positions unsupported" error 
                # message (see https://www.imagemagick.org/discourse-server/viewtopic.php?t=25961)
                echo "imtess-log --- deskewing image"
                convert $tmp_img -deskew 40% +repage $tmp_img  

                echo "imtess-log --- scaling image to $scale%"
                convert $tmp_img -scale $scale% $tmp_img      

#                echo "imtess-log --- thresholding image"
#                convert $tmp_img -threshold 50% $tmp_img

#                echo "imtess-log --- denoising image"
#                convert $tmp_img -noise 4 $tmp_img                
                
                echo "imtess-log --- OCRing image"
                tesseract $tmp_img $outp --oem 1 -l $lang 

        done

