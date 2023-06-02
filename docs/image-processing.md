# Image Processing 

ssh into systems@imagecat2.princeton.edu 

`ssh systems@imagecat2.princeton.edu`

Obtain the 'Image Catalog' password for this server in [LastPass](https://www.lastpass.com/)

Once you are have ssh into the shell, navigate to the imagecat sub-directory 

`cd /var/www/html/imagecat`

The images are located on the disk directories (numbered 1-14). 

We want to extract ONLY the original .tiff images and import these to an AmazonS3 bucket. 

They will be extracted to a local drive, where then the images will be moved to the S3 bucket. The images are currently housed on a local machine in the following path:

`cp *.tiff ../../../output/disk14/0001/A1002`

The PUL-iiif server will allow the user to render the images and interact with them as needed. 
