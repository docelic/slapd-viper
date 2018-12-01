# Slapd-viper for OpenLDAP

`slapd-viper` is a flexible database backend for OpenLDAP.

It implements all the usual LDAP operations, as well as provides elaborate features to respond with dynamic and auto-computed data on a level previously unseen in traditional LDAP installations.

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

3. Load example data into the tree:

```sh
ldapadd -x -D cn=admin,dc=example,dc=com -w nevairbe -v -c -f slapd-viper/ldifs/example.ldif
```

4. Query the added data:

```sh
ldapsearch -x -b dc=example,dc=com
```

And that's it for the most basic example.
