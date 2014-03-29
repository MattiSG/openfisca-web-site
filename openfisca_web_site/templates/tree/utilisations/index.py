# -*- coding: utf-8 -*-


# OpenFisca -- A versatile microsimulation software
# By: OpenFisca Team <contact@openfisca.fr>
#
# Copyright (C) 2011, 2012, 2013, 2014 OpenFisca Team
# https://github.com/openfisca
#
# This file is part of OpenFisca.
#
# OpenFisca is free software; you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# OpenFisca is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.


from openfisca_web_site import model, urls


class Node(model.Folder):
    def get_visualizations(self, ctx):
        return [
            dict(
                description = u"'Proposition de réforme du statut du quotient conjugal",
                logo_url = urls.get_url(ctx, self.url_path, 'images', 'logo-openfisca.png'),
                source_url = urls.get_full_url(ctx, self.url_path, 'hackathon-2014-03-14/quotient-conjugal/'),
                owner = u"Équipe hackathon",
                title = u"Réforme du quotient conjugal",
                thumbnail_url = urls.get_url(ctx, self.url_path, 'images', 'vignette-quotient-conjugal.png'),
                updated = u'2014-03-24T19:19:00',
                ),
            dict(
                description = u"'Évolution du taux effectif d'imposition en fonction du salaire et du capital",
                logo_url = urls.get_url(ctx, self.url_path, 'images', 'logo-regards-citoyens.jpeg'),
                source_url = u'http://nbviewer.ipython.org/urls/raw.githubusercontent.com/regardscitoyens/openfisca-web-notebook/master/calcul_taux_effectif.ipynb',
                owner = u"Regards citoyens",
                title = u"Taux effectif d'imposition",
                thumbnail_url = urls.get_url(ctx, self.url_path, 'images', 'vignette-taux-effectif.png'),
                updated = u'2014-03-25T09:13:00',
                ),
            dict(
                description = u"Graphe dynamique des dépendances entre les formules socio-fiscales d'OpenFisca",
                logo_url = urls.get_url(ctx, self.url_path, 'images', 'logo-etalab.png'),
                source_url = urls.get_full_url(ctx, self.url_path, '../graphe-formules'),
                owner = u"Etalab",
                title = u"Interdépendance des formules d'OpenFisca",
                thumbnail_url = urls.get_url(ctx, self.url_path, 'images', 'vignette-graphe-formules.png'),
                updated = u'2014-03-28T07:26:00',
                ),
            dict(
                description = u"Représentation du revenu net et des ses composantes en faisant varier le salaire imposable",
                logo_url = urls.get_url(ctx, self.url_path, 'images', 'logo-etalab.png'),
                owner = u"Etalab",
                source_url = u'http://localhost:2015/bareme.html',
                title = u"Barème",
                thumbnail_url = u'http://localhost:2015/bareme.png',
                updated = u'2014-03-28T07:26:00',
                ),
            ]
