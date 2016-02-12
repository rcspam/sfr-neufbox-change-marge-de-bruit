sfr-neufbox-change-marge-bruit
=====================
Un petit script pour changer la marge de bruit sur une neufbox (NB6 pour ma part)

Il est facilement adaptable à d'autres requêtes

C'est un fork de [denouche/sfr-neufbox-change-ip](https://github.com/denouche/sfr-neufbox-change-ip), donc grand merci à @denouche

Conditions
------------

Ce script fonctionne avec la SFR Neufbox Evolution.

Nous supposons que l'adresse de la box est `192.168.1.1` (vous pouvez modifier le script pour définir une autre adresse IP).

Utilisation
-----

### Installation

Afin installer sfr-neufbox-change-marge-bruit dans votre $HOME/bin/ et de télécharger les dépendances nécessaires, exécuter:

```
    $ make
```

Lors de l'installation, 'make' vous demandera les login/mot_de_passe de l'interface web de neufbox.

### Configuration

Vous pouvez modifier le login/mot_de_passe dans le fichiers '.credentials' de votre répertoire d'installation ($HOME/bin/neufbox_change_bruit).

Le format est le suivant:

```
    login:password
```

Ces identifiants sont les mêmes que vous utilisez pour vous connecter sur l'interface web de vous Neufbox.

### Exécution
Ajouter $HOME/bin à votre $PATH.

Pour changer la marge de bruit, exécuter le script avec sa valeur en argument:

```
    $ neufbox_change_marge_bruit.sh 40
```

Dépendences
-----

Ce script utilise PhantomJS (http://phantomjs.org/).
