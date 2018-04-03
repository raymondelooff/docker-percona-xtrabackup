# Percona XtraBackup for Docker

This image allows you to use Percona XtraBackup, without having to install XtraBackup on the local system. This image also makes it possible to easily backup a MySQL/MariaDB server that runs in a Docker container (with volume mounts). You can also run XtraBackup on systems that are not officially supported by Percona XtraBackup, for example to prepare a backup on macOS.

## Usage

The entrypoint of this Docker image is the `xtrabackup` executable. This allows you to pass any option to XtraBackup. For example, you can pass `--backup` to make a backup, and pass `--prepare` to prepare a backup. You can also pass any other option that is supported by XtraBackup ([see the documentation](https://www.percona.com/doc/percona-xtrabackup/LATEST/xtrabackup_bin/xbk_option_reference.html)). By default, this image sets the `--datadir` option to `/var/lib/mysql`, and the `--target-dir` option to `/target`. You'll need to mount the correct directories into the Docker container to allow XtraBackup to read the MySQL/MariaDB data directory and write the backup outside the container.

```
docker run --rm -it \
    -v /path/to/var/lib/mysql:/var/lib/mysql \
    -v /path/to/target/directory:/target \
    -v /path/to/etc/mysql/my.cnf:/etc/mysql/my.cnf \
    -v /path/to/my.cnf:/root/.my.cnf \
    raymondelooff/percona-xtrabackup:latest
```

## Parameters

It's recommended to use the `my.cnf` files to specify the server configuration and client credentials that XtraBackup has to use. By default, XtraBackup reads the following configuration files in the given order: `/etc/my.cnf` `/etc/mysql/my.cnf` `/usr/etc/my.cnf` `~/.my.cnf`. You can also specify the username and password using the options `--user` and `--password`. For more information about the available options, [see the documentation](https://www.percona.com/doc/percona-xtrabackup/LATEST/xtrabackup_bin/xbk_option_reference.html).

*   `-v /var/lib/mysql` - Must be linked to the MySQL/MariaDB data directory
*   `-v /target` - Must be linked to the target directory for the backup
*   `-v /etc/mysql/my.cnf` - Recommended, mount the MySQL/MariaDB server `my.cnf` file
*   `-v /.root/.my.cnf` - Recommended, mount the user-specific `.my.cnf` 'defaults extra file'
