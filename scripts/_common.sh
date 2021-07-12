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
    ynh_install_app_dependencies python3 python3-setuptools python3-pip python3-requests python3-dev libmariadb-dev-compat libmariadb-dev \
        expect ffmpeg \
        memcached libmemcached-dev \
        python3-scipy python3-matplotlib \
        libjpeg62-turbo-dev zlib1g-dev  # For building pillow
    ynh_add_swap 2000
    # We need to do that because we can have some issue about the permission access to the pip cache without this
    chown -R $seafile_user:$seafile_user $final_path

    # Note that we install imageio to force the dependance, without this imageio 2.8 is installed and it need python3.5
    sudo -u $seafile_user pip3 install --user --no-warn-script-location --upgrade future mysqlclient pymysql Pillow pylibmc captcha jinja2 sqlalchemy psd-tools django-pylibmc django-simple-captcha python3-ldap
    # TODO add dependance when upgrade to seafile 8: django==2.2.*
    ynh_del_swap
}

mv_expect_scripts() {
    expect_scripts_dir=$(mktemp -d)
    cp expect_scripts/* $expect_scripts_dir
    chmod u=rwx,o= -R $expect_scripts_dir
    chown $seafile_user -R $expect_scripts_dir
}

set_permission() {
    chown -R $seafile_user:$seafile_user $final_path
    chmod -R g-wx,o= $final_path
    setfacl -m user:www-data:rX $final_path
    setfacl -m user:www-data:rX $final_path/seafile-server-$seafile_version
    setfacl -m user:www-data:rX $final_path/seafile-server-latest/seahub
    setfacl -R -m user:www-data:rX $final_path/seafile-server-latest/seahub/media

    # check that this directory exist because in some really old install the data could still be in the main seafile directory
    # We also check at the install time when data directory is not already initialised 
    if [ -e /home/yunohost.app/seafile-data ]; then
        chown -R $seafile_user:$seafile_user /home/yunohost.app/seafile-data
        chmod -R o= /home/yunohost.app/seafile-data
    fi
}

ynh_clean_setup () {
	pkill -f seafile-controller
	pkill -f seaf-server
	pkill -f ccnet-server
	pkill -f seahub
}
