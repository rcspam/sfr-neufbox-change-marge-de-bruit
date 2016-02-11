sfr-neufbox-change-marge-bruit
=====================

A little script to change the IP address of your internet connexion

Requirements
------------

This script works with my SFR Neufbox Evolution.

We suppose that the box is accessible at `192.168.1.1` (you can modify the script to set a custom IP address).

Usage
-----

### Retrieve dependency

First in order to retrieve needed dependency and install sfr-neufbox-change-marge-bruit in your $HOME/bin/, run:
```
    make
```

### Configuration

You need to create a file `.credentials` in your $HOME/bin/sfr-neufbox-change-marge-de-bruit with the following format:
```
    login:password
```
These credentials are the same you are using to connect on the web interface of you Neufbox.

### Run
Add $HOME/bin to your $PATH.
Run the script to change the rate noise with a 'rate noise' argument.
```
    $ sfr-neufbox-change-marge-de-bruit 40
```

Dependency
-----

This script is using PhantomJS (http://phantomjs.org/).

The IP address is retrieved usgin http://ipecho.net/

