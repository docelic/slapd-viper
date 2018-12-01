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

## Introduction

`slapd-viper` is a custom backend for OpenLDAP built on top of OpenLDAP's `slapd-perl`.

It stores the directory tree in files and directories on disk, by default under `/var/lib/ldap/viper/`.

It can be used as a normal backend &mdash; reading and writing data is just the same as for any backend.
However, its primary use is for LDAP trees which contain highly dynamic data and where elaborate and configurable server-side behavior is needed.

Dynamic functions possible with `slapd-viper` are:

1. ADD operation can overwrite existing entries without throwing an error
1. ADD operation can ignore adds for entries which already exist without throwing an error
1. DN of new entries can be modified (entries can be "relocated") before they are saved
1. When adding Debconf templates, a prompt can be opened on a remote machine, asking the admin for Debconf answer
1. When MODIFYing entries, no-ops can be detected and no changes made
1. When MODIFYing (and in combination with other functionality), Copy on Write is supported
1. DELETE can be allowed to delete whole subtrees if entries to delete are non-leaves
1. SEARCH queries can be arbitrarily rewritten
1. SEARCH can fallback to multiple other locations if no results are found
1. Attribute values can expand to content of disk files
1. Attribute values can expand to value of other entries and attributes
1. Attribute values can expand to value of another SEARCH
1. Attribute values can evaluate Perl code
1. Returned entries can be appened with additional attributes or values in various ways


## LDAP Operations

1. BIND operation is supported, but only in a trivial way. Therefore, binding using a DN under this part of DIT is not enabled by default unless `enable_bind 1` is present in the config file.

