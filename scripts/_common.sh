#=================================================
# SET ALL CONSTANTS
#=================================================

app=$YNH_APP_INSTANCE_NAME

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

install_source_7_0() {
    if ! [ -e $final_path/seafile-server-7.0.5 ]; then
        mkdir "$final_path/seafile-server-7.0.5"
        if [[ $architecture == "i386" ]]
        then
            ynh_die --message "Error : this architecture is no longer supported by the upstream. Please create en issue here : https://github.com/YunoHost-Apps/seafile_ynh/issues to ask to discuss about a support of this architecture"
        fi
        ynh_setup_source "$final_path/seafile-server-7.0.5" "$architecture"_7_0
    fi
}

install_dependance() {
    ynh_install_app_dependencies python3 python3-setuptools python3-pip python3-requests python3-dev \
        expect ffmpeg \
        memcached libmemcached-dev \
        libjpeg62-turbo-dev zlib1g-dev # For building pillow
    ynh_add_swap 2000
    # We need to do that because we can have some issue about the permission access to the pip cache without this
    set_permission
    # Note that we install imageio to force the dependance, without this imageio 2.8 is installed and it need python3.5
    sudo -u $seafile_user pip3 install --user --upgrade Pillow pylibmc captcha jinja2 sqlalchemy psd-tools \
        django-pylibmc django-simple-captcha python3-ldap \
        pylibmc django-pylibmc # Memcached support
    ynh_del_swap
}

set_permission() {
    chown -R $seafile_user:$seafile_user $final_path
    # check that this directory exist because in some really old install the data could still be in the main seafile directory
    # We also check at the install time when data directory is not already initialised 
    test -e /home/yunohost.app/seafile-data && chown -R $seafile_user:$seafile_user /home/yunohost.app/seafile-data
    # Well need to put this here because if test return false, set_permission also return false and the install fail
    true
}

ynh_clean_setup () {
	pkill -f seafile-controller
	pkill -f seaf-server
	pkill -f ccnet-server
	pkill -f seahub
}
