# Image Processing 

## Transferring files from legacy system to imagecat-staging

ssh into pulsys@imagecat-staging1.princeton.edu 

`ssh pulsys@imagecat-staging1.princeton.edu`

Look at the existing tmux sessions to determine if a new one will need to be created. The session we would like to see is 'image-transfer'

`tmux ls`

If you do not see 'image-transfer' then we will have to create a new tmux session.

```
tmux new -s image-transfer
bash
```

If we do see an existing tmux session called 'image-transfer' then we will just need to attach to an existing tmux session.

`tmux attach -t image-transfer`

To exit a tmux session, use the commands ctrl+b, then d.

Obtain the 'Image Catalog' password for this server in [LastPass](https://www.lastpass.com/)

## rsync images one disk at a time
 
`rsync -a --include=*.tiff --info=progress2 systems@imagecat2:/var/www/html/imagecat/disk2 /var/tmp/imagecat`

## Rename files and upload to s3 

1. ssh into imagecat-staging1 `ssh pulsys@imagecat-staging1.princeton.edu`
2. 

## Helpful tmux tips

If we need to delete a tmux session, we can run the following command:

`tmux kill-session -t <name>`