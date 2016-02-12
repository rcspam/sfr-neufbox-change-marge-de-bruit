sfr-neufbox-change-marge-bruit
=====================
A little script to change the noise rate of a neufbox.

It is easily adaptable to other requests.

This is a forked from denouche/sfr-neufbox-change-ip, so thanks to @denouche

Requirements
------------

This script works with the SFR Neufbox Evolution.

We suppose that the box is accessible at `192.168.1.1` (you can modify the script to set a custom IP address).

Usage
-----

### Retrieve dependency

First in order to install sfr-neufbox-change-marge-bruit in your $HOME/bin/ and retrieve needed dependency, run:
```
    $ make
```
During installation, 'make' ask you the login/password of the neufbox web interface

### Configuration

You can change the login/password in the file `.credentials` in your install directory ( $HOME/bin/neufbox_change_bruit ) with this following format:
```
    login:password
```
These credentials are the same you are using to connect on the web interface of you Neufbox.

### Run
Add $HOME/bin to your $PATH.
Run the script to change the rate noise with a 'rate noise' argument.
```
    $ neufbox_change_marge_bruit.sh 40
```

Dependency
-----

This script is using PhantomJS (http://phantomjs.org/).
