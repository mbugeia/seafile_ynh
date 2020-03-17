#=================================================
# SET ALL CONSTANTS
#=================================================

app=$YNH_APP_INSTANCE_NAME
[[ -e "../settings/manifest.json" ]] || [[ -e "../manifest.json" ]] && \
    seafile_version=$(ynh_app_upstream_version)

#=================================================
# DEFINE ALL COMMON FONCTIONS
#=================================================

install_source() {
    mkdir "$final_path/seafile-server-$seafile_version"
    if [[ $architecture == "i386" ]]
    then
        ynh_die --message "Error : this architecture is no longer supported by the upstream. Please create en issue here : https://github.com/YunoHost-Apps/seafile_ynh/issues to ask to discuss about a support of this architecture"
    fi
    ynh_setup_source "$final_path/seafile-server-$seafile_version" "$architecture"
}

install_dependance() {
	ynh_install_app_dependencies "python2.7 python-pip libpython2.7 python-setuptools python-ldap python-urllib3 python-simplejson python-imaging|python-pil python-mysqldb python-flup expect python-requests python-dev ffmpeg python-memcache \
        libjpeg62-turbo-dev zlib1g-dev" # For building pillow
    ynh_add_swap 2000
    # Note that we install imageio to force the dependance, without this imageio 2.8 is installed and it need python3.5
    sudo -u $seafile_user pip install --user --upgrade Pillow 'moviepy<1.0' 'imageio<2.8' certifi idna
    ynh_del_swap
}

set_permission() {
    chown -R $seafile_user:$seafile_user $final_path
    # check that this directory exist because in some really old install the data could still be in the main seafile directory
    test -e /home/yunohost.app/seafile-data && chown -R $seafile_user:$seafile_user /home/yunohost.app/seafile-data
}

ynh_clean_setup () {
	pkill -f seafile-controller
	pkill -f seaf-server
	pkill -f ccnet-server
	pkill -f seahub
}
