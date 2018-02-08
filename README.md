# quod
`quod` (querying OCRed documents) is a prototype Python-based command line tool for OCRing and querying digitised documents. It can be used either to OCR images and subsequently query them, or only to query previously OCRed images. It is written for Mac OS.

## Usage
`quod` takes four compulsory arguments and is invoked using the following command:

    $ quod path query mrt ocr

where 
* `path` is the path containing the files to OCR and query; these files may either be directly inside the path, or inside separate subdirectories within the path;
*	`query` is the query string and may consist of multiple substrings, in which case it must be placed in quotation marks; 
*	`mrt` is the _match ratio threshold_, i.e., the minimum _match ratio_ (as calculated using the `difflib.SequenceMatcher` class) required for two strings to be considered equal;
*	`ocr` is a Boolean value that defines whether the images must be both OCRed and queried, in which case it is set to _true_, or only queried, in which case it is set to _false_ (the values _yes_ or _y_ and _no_ or _n_ are accepted alternatives).  

All arguments are case insensitive. 

The following command will, after first having OCRed all images in the directory _~/imgs_, query the resulting output files for the term _some query string_, using an MRT of 0.7:

    $ quod ~/imgs 'some query string' 0.7 true 
   
For each match found, the name of the corresponding image is returned.

## Installation
`quod` must be stored, together with the accompanying imtess.sh script, in the _~/bin_ directory. To do this, `cd` to the directory where both files are and do

    $ cp quod ~/bin
    $ cp imtess.sh ~/bin

Then, make `quod` executable:

    $ cd ~/bin 
    $ chmod +x quod

## Dependencies
To be able to run `quod`, you must have Python (v3.x) and Tesseract (https://github.com/tesseract-ocr/; v4.00.00 alpha gives significantly better results than v3.05.01, the latest stable version) installed on your computer. 


