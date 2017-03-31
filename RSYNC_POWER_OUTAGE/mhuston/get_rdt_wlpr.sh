#!/bin/bash
export http_proxy=http://proxy.usfornax.ifornax.ray.com:80 && export https_proxy=${http_proxy} && export HTTP_PROXY=${http_proxy} && export HTTPS_PROXY=${http_proxy}
now=$(date +"%m_%d_%Y")
wget --no-check-certificate -O - http://www.reddit.com/r/wallpapers.rss | grep -Eo 'http://i.imgur.com[^&]+jpg' | head -1 | xargs wget -O background_$now.jpg
