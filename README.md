# Slapd-viper Database Backend for OpenLDAP

`slapd-viper` is a flexible database backend for OpenLDAP. It has been in use since 2008.

It implements all the usual LDAP operations, as well as provides elaborate features for responding with dynamic and auto-computed data on a level not seen in traditional LDAP installations.

## Quick Start

1. Install system dependencies:

```sh
apt install slapd libfile-find-rule-perl libnet-ldap-perl libtext-csv-xs-perl liblist-moreutils-perl
```

2. Obtain and run Viper with an example config file that provides suffix `dc=example,dc=com`:

```sh
cd /etc/ldap
git clone https://github.com/crystallabs/slapd-viper

/usr/sbin/slapd -d 256 -f ./slapd-viper/etc/ldap/slapd.conf
```

3. While the server is running, load example data into the tree:

```sh
ldapadd -x -D cn=admin,dc=example,dc=com -w nevairbe -v -c -f slapd-viper/ldifs/example.ldif
```

4. And query the added data:

```sh
ldapsearch -x -b dc=example,dc=com
```

That's it for the most basic example.

## Quick Introduction and Concepts

`slapd-viper` is a custom backend built on top of OpenLDAP's `slapd-perl`.

It stores the directory tree in files and directories on disk.

It is primarily intended for databases which contain highly dynamic data and where you need elaborate custom and configurable behavior server-side behavior.
















