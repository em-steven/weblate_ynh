#!/bin/bash
# Source: https://github.com/YunoHost-Apps/coin_ynh/

# Open a connection as a user
#
# example: ynh_psql_connect_as 'user' 'pass' <<< "UPDATE ...;"
# example: ynh_psql_connect_as 'user' 'pass' < /path/to/file.sql
#
# usage: ynh_psql_connect_as user pwd [db]
# | arg: user - the user name to connect as
# | arg: pwd - the user password
# | arg: db - the database to connect to
ynh_psql_connect_as() {
    ynh_die "ynh_psql_connect_as is not yet implemented"
}

# # Execute a command as root user
#
# usage: ynh_psql_execute_as_root sql [db]
# | arg: sql - the SQL command to execute
# | arg: db - the database to connect to
ynh_psql_execute_as_root () {
        su -c "psql" - postgres <<< ${1}
}

# Execute a command from a file as root user
#
# usage: ynh_psql_execute_file_as_root file [db]
# | arg: file - the file containing SQL commands
# | arg: db - the database to connect to
ynh_psql_execute_file_as_root() {
     ynh_die "ynh_psql_execute_file_as_root is not yet implemented"
}

# Create a database and grant optionnaly privilegies to a user
#
# usage: ynh_psql_create_db db [user [pwd]]
# | arg: db - the database name to create
# | arg: user - the user to grant privilegies
# | arg: pwd - the password to identify user by
ynh_psql_create_db() {
    db=$1
    # grant all privilegies to user
    if [[ $# -gt 1 ]]; then
        ynh_psql_create_user ${2} "${3}"
        su -c "createdb -O ${2} $db" -  postgres
    else
        su -c "createdb $db" -  postgres
    fi
}

# Drop a database
#
# usage: ynh_psql_drop_db db
# | arg: db - the database name to drop
ynh_psql_drop_db() {
    su -c "dropdb ${1}" -  postgres
}

# Dump a database
#
# example: ynh_psql_dump_db 'roundcube' > ./dump.sql
#
# usage: ynh_psql_dump_db db
# | arg: db - the database name to dump
# | ret: the psqldump output
ynh_psql_dump_db() {
    ynh_die "ynh_psql_dump_db is not yet implemented"
}


# Create a user
#
# usage: ynh_psql_create_user user pwd [host]
# | arg: user - the user name to create
# | arg: pwd - the password to identify user by
ynh_psql_create_user() {
        ynh_psql_execute_as_root \
        "CREATE USER ${1} WITH PASSWORD '${2}';"
}

# Drop a user
#
# usage: ynh_psql_drop_user user
# | arg: user - the user name to drop
ynh_psql_drop_user() {
    su -c "dropuser ${1}" - postgres
}
