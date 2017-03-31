export EMAIL="matthew.huston-nr@raytheon.com"
export USER_FULL_NAME="Matthew Huston"
alias proxyon='export http_proxy=http://proxy.usfornax.ifornax.ray.com:80 && export https_proxy=${http_proxy} && export HTTP_PROXY=${http_proxy} && export HTTPS_PROXY=${http_proxy}'
alias proxyoff='export http_proxy= && export https_proxy= && export HTTPS_PROXY= && export HTTP_PROXY='
alias vimbash='vim ~/.bashrc'
alias chefdev='cd ~/dev/chef'
alias cgc="chef generate cookbook -C Raytheon -m $EMAIL -I raytheon"
alias cgr="chef generate recipe -C Raytheon -m $EMAIL"
alias cgl="chef generate lwrp -C Raytheon -m $EMAIL"
alias cgf="chef generate file -C Raytheon -m $EMAIL"
