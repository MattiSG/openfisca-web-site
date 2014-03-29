## -*- coding: utf-8 -*-


## OpenFisca -- A versatile microsimulation software
## By: OpenFisca Team <contact@openfisca.fr>
##
## Copyright (C) 2011, 2012, 2013, 2014 OpenFisca Team
## https://github.com/openfisca
##
## This file is part of OpenFisca.
##
## OpenFisca is free software; you can redistribute it and/or modify
## it under the terms of the GNU Affero General Public License as
## published by the Free Software Foundation, either version 3 of the
## License, or (at your option) any later version.
##
## OpenFisca is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU Affero General Public License for more details.
##
## You should have received a copy of the GNU Affero General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.


<%!
import urlparse

from openfisca_web_site import conf, urls
%>


<%inherit file="/page.mako"/>


<%def name="h1_content()" filter="trim">
Installation Web d'OpenFisca <a href="#linux">GNU/Linux</a> - <a href="#windows">Windows</a>
</%def>


<%def name="page_content()" filter="trim">
<h2 id="linux">Installation sous  <strong>GNU/Linux</strong></h2>
<h3>Installation de l'API Web d'OpenFisca</h3>
    <ul>
        <li>Afin de pouvoir lancer l'API, certain paquets sont nécessaires, pour les installer, lancer les commandes suivantes :
<pre># apt-get install gettext
# apt-get install git
# apt-get install python-babel
# apt-get install python-dateutil
# apt-get install python-isodate
# apt-get install python-pandas
# apt-get install python-pastescript
# apt-get install python-pymongo
# apt-get install python-setuptools
# apt-get install python-scipy
# apt-get install python-requests
# apt-get install python-weberror</pre></li>
    </ul>
<h4>Oui, mais ensuite ?</h4>
    <ul>
    <li>Si vous voulez mettre vos fichiers dans "Documents", effectuer les commandes suivantes dans le terminal :</li>
            <pre>$ cd Documents
$ mkdir openfisca
$ cd openfisca</pre>
        <li>Pour cloner les fichiers openfisca sur votre machine, effectuez les 4 commandes suivantes :</li>
            <pre>$ git clone https://github.com/etalab/biryani.git
$ git clone http://github.com/openfisca/openfisca-core.git
$ git clone http://github.com/openfisca/openfisca-france.git
$ git clone http://github.com/openfisca/openfisca-web-api.git</pre>
        <li>Afin d'installer chaque partie d'openfisca, effectuez les commandes suivantes dans l'ordre :</li>
            <pre>$ cd biryani
$ python setup.py compile_catalog
# python setup.py develop --no-deps
$ cd openfisca-core
$ python setup.py compile_catalog
# python setup.py develop --no-deps
$ cd ../openfisca-france
# python setup.py develop --no-deps
$ cd ../openfisca-web-api
$ python setup.py compile_catalog
# python setup.py develop --no-deps</pre>
    </ul>
<h4>Lancer le serveur</h4>
    <ul>
        <li>Une fois toutes ces étapes finis, il faut, toujours dans la même commande (normalement vous vous trouvez dans le dossier "openfisca-web-api" lancer la commande suivante :</li>
            <pre>$ paster serve --reload development.ini</pre>
        <li>Pour arreter le serveur, dans la commande faire <kbd>ctrl + C</kbd></li></ul>
      <div class="alert alert-danger">ATTENTION : pour lancer vos tests localement, dans vos fichiers test, vous devez remplacer les liens de simulation et de législation par vos liens locaux :
                            <ul><li>http://api.openfisca.fr/api/1/simulate  --&gt;  http://localhost:2014/api/1/simulate</li>
                              <li>http://api.openfisca.fr/api/1/default-legislation  --&gt;  http://localhost:2014/api/1/default-legislation</li></ul>
      </div>
<h3>Installation de l'Interface Utilisateur <small>(non indispensable pour faire tourner l'API Web)</small></h3>
  <ul>
    <li>Pour installer l'UI, il faut ouvrir un nouvel onglet (<kbd>ctrl + shift + T</kbd>), aller dans son dossier openfisca et installer les paquets essentiels :
      <pre>$ cd Documents/openfisca
# apt-get install python-formencode
# apt-get install nodejs-legacy
# apt-get install npm
$ npm install -g bower
$ git clone https://git.gitorious.org/korma/korma.git@dev
$ cd korma.git@dev
# python setup.py develop --no-deps
$ cd ../
$ git clone https://github.com/openfisca/openfisca-web-ui.git
$ cd openfisca-web-ui
$ python setup.py compile_catalog
# python setup.py develop --no-deps
$ ./openfisca_web_ui/scripts/setup.py development.ini #création des index dans la base de donnée</pre></li>
    <li>installer bower dans openfisca/openfisca-web-ui :
      <pre>$ cd Documents/openfisca/openfisca-web-ui
$ bower install</pre>
    </li></ul><p class="alert alert-danger">ATTENTION : pour lancer le serveur de l'interface, vous devez lancer d'abord le serveur de l'api et MongoDB dans des consoles différentes :</p>

  <ul>
        <li>Tout d'abord, dans un premier onglet, lancer l'API :
          <pre>$ cd Documents/openfisca/openfisca-web-api
$ paster serve --reload development.ini</pre></li>
        <li>Enusite, dans un deuxième onglet, lancer MongoDB (ici installé dans le dossier openfisca) :
          <pre># service mongodb start</pre></li>
          <li>Enfin, dans un troisième onglet, lancer le serveur de l'Interface utilisateur :
          <pre>$ cd Documents/openfisca/openfisca-web-ui
$ paster serve --reload development.ini</pre></li>
  </ul>
<h4>Ouvrir l'interface</h4>

  <ul>
    <li>Pour ouvrir l'interface utilisateur, il vous suffit d'ouvrir votre navigateur internet et d'aller à l'adresse du lien suivant : <kbd>http://localhost:2015</kbd></li>
  </ul>
  <hr>











 <h2 id="windows">Installation sous <strong>Windows</strong></h2>
 <h3>Installation de l'API Web d'OpenFisca</h3>
    <ul>
        <li>Installer <a href="https://www.python.org/download/releases/2.7.6/">Python 2.7.6</a></li>
        <li>Installer <a href="git-scm.com/download/win">Git</a>, ouvrir le .exe et choisissez tout par
        defaut sauf "adjusting yout PATH environent" et selectionnez "run Git from the Windows Command Prompt"</li>
        <li>Télécharger les <a href="http://www.lfd.uci.edu/~gohlke/pythonlibs/#setuptools">outils python</a> dans leur version pour Python 2.7</li>
    </ul>
<h4>Oui, mais ensuite ?</h4>
    <ul>
      <li>Tout d'abord, il faut ouvrir la commande Windows, le plus simple étant de faire la touche <kbd>Windows + R</kbd>, de taper <kbd>cmd</kbd> puis ok.
        </li><li>Si vous voulez mettre vos fichiers sur le bureau, effectuer les commandes suivantes dans la <abbr title="windows command prompt">CMD</abbr> :</li>
            <pre>$ cd Desktop
$ mkdir openfisca
$ cd openfisca</pre>
        <li>Pour cloner les fichiers openfisca sur votre machine, effectuez les 3 commandes suivantes :</li>
            <pre>$ git clone http://github.com/openfisca/openfisca-web-api.git
$ git clone http://github.com/openfisca/openfisca-core.git
$ git clone http://github.com/openfisca/openfisca-france.git
$ git clone https://github.com/etalab/biryani.git</pre>
        <li>Afin d'installer chaque partie d'openfisca, effectuez les commandes suivantes dans l'ordre :</li>
            <pre>$ pip install python gettext
$ pip install PasteScript
$ cd openfisca-core
$ python setup.py compile_catalog
$ python setup.py install
$ cd ../openfisca-france
$ python setup.py install
$ cd ../openfisca-web-api
$ python setup.py compile_catalog
$ python setup.py install</pre>
    </ul>
<h4>Lancer le serveur</h4>
    <ul>
        <li>Une fois toutes ces étapes finis, il faut, toujours dans la même commande (normalement vous vous trouvez dans le dossier "openfisca-web-api" lancer la commande suivante :</li>
            <pre>$ paster serve --reload development.ini</pre>
        <li>Pour arreter le serveur, dans la commande faire <kbd>ctrl + C</kbd></li></ul>
      <div class="alert alert-danger">ATTENTION : pour lancer vos tests localement, dans vos fichiers test, vous devez remplacer les liens de simulation et de législation par vos liens locaux :
                            <ul><li>http://api.openfisca.fr/api/1/simulate  --&gt;  http://localhost:2014/api/1/simulate</li>
                              <li>http://api.openfisca.fr/api/1/default-legislation  --&gt;  http://localhost:2014/api/1/default-legislation</li></ul>
      </div>
<h3>Installation de l'Interface Utilisateur <small>(non indispensable pour faire tourner l'API Web)</small></h3>
  <ul>
    <li>Pour installer l'UI, il faut ouvrir une nouvelle commande (<kbd>Windows + R</kbd> -&gt; <kbd>cmd</kbd> -&gt; OK) et aller dans son dossier openfisca :
      <pre>$ cd Desktop/openfisca
$ git clone https://git.gitorious.org/korma/korma.git@dev
$ cd korma.git@dev
$ python setup.py install
$ cd ../
$ git clone https://github.com/openfisca/openfisca-web-ui.git
$ cd openfisca-web-ui
$ python setup.py compile_catalog
$ python setup.py install
$ ./openfisca_web_ui/scripts/setup.py development.ini #création des index dans la base de donnée
$ pip install FormEncode</pre></li>
    <li>Télécharger ensuite <a href="http://nodejs.org/download/">nodejs</a> et executer le .exe</li>
    <li> une fois l'installation terminée, il faut télécharger <a href="https://www.mongodb.org/downloads">MongoDB</a> et l'installer</li>
    <li>Vous aurez surement besoin de redémmarer votre machine afin de prendre certains paramètres en compte</li>
    <li>installer bower :
      <pre>$ npm install bower</pre></li>
    <li>installer bower dans openfisca/openfisca-web-ui :
      <pre>$ cd Desktop/openfisca/openfisca-web-ui
$ bower install</pre>
    </li></ul><p class="alert alert-danger">ATTENTION : pour lancer le serveur de l'interface, vous devez lancer d'abord le serveur de l'api et MongoDB dans des consoles différentes :</p>

  <ul>
        <li>Tout d'abord, dans une première console, lancer l'API :
          <pre>$ cd Desktop/openfisca/openfisca-web-api
$ paster serve --reload development.ini</pre></li>
        <li>Enusite, dans une deuxième console, lancer MongoDB (ici installé dans le dossier openfisca) :
          <pre>$ cd Desktop/openfisca/mongodb/bin
$ mongod.exe</pre></li>
          <li>Enfin, dans une troisième console, lancer le serveur de l'Interface utilisateur :
          <pre>$ cd Desktop/openfisca/openfisca-web-ui
$ paster serve --reload development.ini</pre></li>
  </ul>
<h4>Ouvrir l'interface</h4>

  <ul>
    <li>Pour ouvrir l'interface utilisateur, il vous suffit d'ouvrir votre navigateur internet et d'aller à l'adresse du lien suivant : <kbd>http://localhost:2015</kbd></li>
  </ul>
  <hr>
</%def>
