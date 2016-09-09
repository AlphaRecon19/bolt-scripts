#!/bin/zsh

for dir in app/cache/ app/database/ public/thumbs/ ; do
    find $dir -type d -print0 | xargs -0 chmod u+rwx,g+rwxs,o+rx-w
    find $dir -type f -print0 | xargs -0 chmod u+rw-x,g+rw-x,o+r-wx > /dev/null 2>&1
done

for dir in app/config/ extensions/ public/extensions/ public/files/ public/theme/ ; do
    find $dir -type d -print0 | xargs -0 chmod u+rwx,g+rwxs,o+rx-w
    find $dir -type f -print0 | xargs -0 chmod u+rw-x,g+rw-x,o+r-wx > /dev/null 2>&1
done


