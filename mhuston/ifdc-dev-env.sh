#!/usr/bin/env bash

export dev_env_install=(install.sh)
export dry_run=false
export verbose=''

is_verbose() {
  if [[ -n "${verbose}" ]]; then
    return 0
  else
    return 1
  fi
}

main() {
  target_dir="$(readlink -f /tmp)"
  [[ -d ${target_dir} ]] || mkdir $verbose -p $target_dir
  cd $target_dir

  # install VPN client
  if [[ ! -d /opt/sslvpn-plus/naclient ]]; then
    if [[ ! -d ${target_dir}/linux_phat_client ]]; then
      echo "For your usfornax (IFDC) account,"
      smbget $verbose -u "usfornax/$USER" smb://fs-gps-ocx-eim.usfornax.ifornax.ray.com/c$/GPS_OCX_EIM_export/linux_phat_client.tgz
      tar $verbose xzf linux_phat_client.tgz
    fi
    cd linux_phat_client && sudo ./install_linux_phat_client.sh
  fi
  
  # connect to VPN
  [[ -z "${verbose}" ]] || /opt/sslvpn-plus/naclient/login status
  if [[ -z "$(/opt/sslvpn-plus/naclient/login status | grep 'GPS-OCX-EIM')" ]]; then
    echo "For your usfornax (IFDC) account, "
    /opt/sslvpn-plus/naclient/login login -profile GPS-OCX-EIM -user $USER
    [[ $? == 1 ]] || exit $?
  fi

  # /etc/hosts
  [[ -n "$(grep 'chef-server' /etc/hosts)" ]] || sudo sh $verbose -c "echo \"10.1.1.100 chef-server\" >> /etc/hosts"
  [[ -n "$(grep 'gitlab-server' /etc/hosts)" ]] || sudo sh $verbose -c "echo \"10.1.1.103 gitlab-server\" >> /etc/hosts"
  [[ -n "$(grep 'jenkins-server' /etc/hosts)" ]] || sudo sh $verbose -c "echo \"10.1.1.3 jenkins-server\" >> /etc/hosts"

  # install dev-env
  git_branch="jtaylor1_pass_defect"
  [[ -d ${target_dir} ]] || mkdir $verbose -p ${target_dir}
  cd ${target_dir}
  [[ -d dev-env ]] || git clone $verbose http://gitlab-server/gps-ocx-support/dev-env.git
  cd dev-env
  git remote set-url origin http://gitlab-server/gps-ocx-support/dev-env.git
  if [[ "$(git rev-parse --abbrev-ref HEAD)" != $git_branch ]]; then
    git fetch
    git checkout --track origin/${git_branch}
  else
    git pull $verbose
  fi
  for c in ${dev_env_install[@]}; do
    ./${c} $verbose
  done

  # remaining manual steps
  firefox -new-window "http://gitlab-server/gps-ocx-support/styleguide/wikis/Environment" &
}

usage() {
  echo "usage: $0 [OPTIONS]"
  echo "  -s, --system-only    Install only system components; don't modify the user's home directory."
#  echo "  --dry-run            Print what would be done; don't modify anything."
  echo "  -v, --verbose"
  echo "  -h, --help           Display this help and exit."
}

if [[ "${BASH_SOURCE}" == "$0" ]]; then
  while [ "$1" != "" ]; do
    case $1 in
      -s | --system-only )  export dev_env_install=(install_mounts.sh install_software.sh)
                            ;;
      -v | --verbose )      export verbose='--verbose'
                            ;;
      --dry-run )           export dry_run=true
                            ;;
      -h | --help )         usage
                            exit
                            ;;
      * )                   usage
                            exit 1
    esac
    shift
  done

  main "$@"
fi
