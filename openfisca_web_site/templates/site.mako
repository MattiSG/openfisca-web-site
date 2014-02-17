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


<%doc>
    Site template inherited by each page
</%doc>


<%!
import datetime
import urlparse

from openfisca_web_site import conf, urls
%>


<%def name="body_content()" filter="trim">
    <div class="container"><div class="row">
        <%self:breadcrumb/>
        <%self:container_content/>
        <%self:footer/>
    </div></div>
</%def>


<%def name="brand()" filter="trim">
${conf['realm']}
</%def>


<%def name="brand_url()" filter="trim">
/
</%def>


<%def name="breadcrumb()" filter="trim">
        <ul class="breadcrumb">
            <%self:breadcrumb_content/>
        </ul>
</%def>


<%def name="breadcrumb_content()" filter="trim">
            <li><a href="${urls.get_url(ctx)}">${_('Home')}</a> <span class="divider">/</span></li>
</%def>


<%def name="container_content()" filter="trim">
    <%self:page_header/>
    <%self:page_content/>
</%def>


<%def name="css()" filter="trim">
    <link href="${urls.get_url(ctx, u'/bower/bootstrap/dist/css/bootstrap.min.css')}" rel="stylesheet">
    <link href="${urls.get_url(ctx, u'/bower/bootstrap/dist/css/bootstrap-theme.min.css')}" rel="stylesheet">
    <link rel="stylesheet" href="${urls.get_url(ctx, u'/css/site.css')}">
</%def>


<%def name="error_alert()" filter="trim">
    % if errors:
                <div class="alert alert-danger">
                    <h4 class="alert-heading">${_('Error!')}</h4>
        % if '' in errors:
<%
            error = unicode(errors[''])
%>\
            % if u'\n' in error:
                    <pre class="break-word">${error}</error>
            % else:
                    ${error}
            % endif
        % else:
                    ${_(u"Please, correct the informations below.")}
        % endif
                </div>
    % endif
</%def>


<%def name="feeds()" filter="trim">
    <link rel="alternate" type="application/atom+xml" title="${conf['realm']}" href="${urls.get_url(ctx, 'atom')}">
</%def>


<%def name="footer()" filter="trim">
        <hr>
        <footer class="footer">
            <p>
                ${_('{0}:').format(_('Software'))}
                <a href="https://github.com/openfisca" rel="external">OpenFisca</a>
                &mdash;
                <span>${_(u'Copyright © {} OpenFisca Team').format(u', '.join(
                    unicode(year)
                    for year in range(2011, datetime.date.today().year + 1)
                    ))}</span>
                &mdash;
                <a href="http://www.gnu.org/licenses/agpl.html" rel="external">${_(
                    u'GNU Affero General Public License')}</a>
            </p>
        </footer>
</%def>


<%def name="h1_content()" filter="trim">
<%self:brand/>
</%def>


<%def name="hidden_fields()" filter="trim">
</%def>


<%def name="ie_scripts()" filter="trim">
    <!--[if lt IE 9]>
    <script src="${urls.get_url(ctx, u'/bower/html5shiv/src/html5shiv.js')}"></script>
    <script src="${urls.get_url(ctx, u'/bower/respond/respond.src.js')}"></script>
    <![endif]-->
</%def>


<%def name="metas()" filter="trim">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    ## Make sure Internet Explorer can't use Compatibility Mode, as this will break Persona.
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
</%def>


<%def name="page_header()" filter="trim">
        <div class="page-header">
            <h1><%self:h1_content/></h1>
        </div>
</%def>


<%def name="partners()" filter="trim">
        <div class="container">
            <div class="row">
                <div class="col-lg-3">
                    <a class="partner" href="http://www.strategie.gouv.fr/">
                        <img alt="Logo du Commissariat général à la stratégie et à la prospective (CGSP)" class="partner" src="images/logo-cgsp.png"></img>
                    </a>
                    <a href="http://www.strategie.gouv.fr/">
                        <h4>Commissariat général à la stratégie et à la prospective</h4>
                    </a>
                    <p>
                        le Commissariat général à la stratégie et à la prospective, lieu transversal de concertation et
                        de réflexion, s'attache à :
                    </p>
                    <ul>
                        <li>
                            Renouveler l’approche de la stratégie et de la prospective afin d’éclairer les pouvoirs
                            publics sur les trajectoires possibles à moyen et long termes pour la France en matière
                            économique, sociale, culturelle et environnementale.
                        </li>
                        <li>
                            Redonner vigueur à la concertation avec les partenaires sociaux et développer le dialogue
                            avec les acteurs de la société civile.
                        </li>
                    </ul>
                </div>
                <div class="col-lg-3">
                    <a class="partner" href="http://www.etalab.gouv.fr/">
                        <img alt="Logo d'Etalab" class="partner" src="images/logo-etalab.png"></img>
                    </a>
                    <a href="http://www.etalab.gouv.fr/">
                        <h4>Etalab</h4>
                    </a>
                    <p>
                        Service du premier ministre chargé de l'ouverture des données publiques et du développement de
                        la plateforme française Open Data <a href="http://data.gouv.fr">data.gouv.fr</a>
                    </p>
                </div>
                <div class="col-lg-3">
                    <a class="partner" href="http://www.idep-fr.org/">
                        <img alt="Logo de l'Institut d'économie publique (IDEP)" class="partner" src="images/logo-idep.png"></img>
                    </a>
                    <a href="http://www.idep-fr.org/">
                        <h4>Institut d'économie publique</h4>
                    </a>
                    <p>
                         L'IDEP est un réseau de chercheurs. Il a trois missions :
                    </p>
                    <ul>
                        <li>
                            Fournir une expertise en matière de politiques publiques concernant notamment la fiscalité,
                            les systèmes sociaux, le marché du travail, l'environnement, le logement, la santé et
                            l'éducation.
                        </li>
                        <li>
                            Assurer la diffusion des savoirs à la fois en termes de valorisation et d'édition.
                        </li>
                        <li>
                            Assurer une mission pédagogique en direction des lycéens, des étudiants et dans le cadre de
                            la formation tout au long de la vie.
                        </li>
                    </ul>
                </div>
                <div class="col-lg-3">
                    <a class="partner" href="http://www.ipp.eu/">
                        <img alt="Logo de l'Institut des politiques publiques (IPP)" class="partner" src="images/logo-ipp.png"></img>
                    </a>
                    <a href="http://www.ipp.eu/">
                        <h4>Institut des politiques publiques</h4>
                    </a>
                    <p>
                        Équipe de recherche permanente dédiée à l’analyse des politiques publiques afin d'une part
                        faciliter la production de travaux universitaires à forte valeur ajoutée, d’autre part, informer
                        le débat public sur les principaux enjeux des politiques publiques au moyen d’évaluations
                        indépendantes, rigoureuses et accessibles au plus grand nombre
                    </p>
                </div>
            </div>
        </div>
</%def>


<%def name="scripts()" filter="trim">
    <script src="${urls.get_url(ctx, u'/bower/jquery/dist/jquery.min.js')}"></script>
    <script src="${urls.get_url(ctx, u'/bower/bootstrap/dist/js/bootstrap.min.js')}"></script>
    <script>
$(function () {
    $('.dropdown-toggle').dropdown();
});
    </script>
</%def>


<%def name="title_content()" filter="trim">
<%self:brand/>
</%def>


<%def name="topbar()" filter="trim">
    <nav class="navbar navbar-default navbar-fixed-default navbar-inverse" role="navigation">
        <%self:topbar_content/>
    </nav>
</%def>


<%def name="topbar_content()" filter="trim">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-topbar-collapse">
                <span class="sr-only">${_(u'Toggle navigation')}</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="${self.brand_url()}"><%self:brand/> <span class="label label-warning">pre-alpha</span></a>
        </div>
        <div class="collapse navbar-collapse navbar-topbar-collapse">
            <ul class="nav navbar-nav">
                <li><a href="presentation">${u"Présentation"}</a></li>
                <li><a href="telechargement">${u"Téléchargement"}</a></li>
                <li><a href="${conf['ui.url']}">${u"Simulation en ligne"}</a></li>
                <li><a href="api">${u"API"}</a></li>
                <li><a href="contact">${u"Contact"}</a></li>
                <li><a href="a-propos">${u"À propos"}</a></li>
            </ul>
        </div>
</%def>


<%def name="trackers()" filter="trim">
    % if conf['google_analytics.key'] is not None:
    <script type="text/javascript">
var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
    </script>
    <script type="text/javascript">
try {
    var pageTracker = _gat._getTracker("${conf['google_analytics.key']}");
    pageTracker._trackPageview();
} catch(err) {}
    </script>
    % endif
    % if conf['piwik.key'] is not None:
    <script type="text/javascript">
var _paq = _paq || [];
_paq.push(["trackPageView"]);
_paq.push(["enableLinkTracking"]);

(function() {
    var u=(("https:" == document.location.protocol) ? "https" : "http") + "://${urlparse.urlsplit(
        conf['piwik.url']).netloc}/";
    _paq.push(["setTrackerUrl", u+"piwik.php"]);
    _paq.push(["setSiteId", "${conf['piwik.key']}"]);
    var d=document, g=d.createElement("script"), s=d.getElementsByTagName("script")[0]; g.type="text/javascript";
    g.defer=true; g.async=true; g.src=u+"piwik.js"; s.parentNode.insertBefore(g,s);
})();
    </script>
    % endif
</%def>


<!DOCTYPE html>
<html lang="${ctx.lang[0][:2]}">
<head>
    <%self:metas/>
    <title>${self.title_content()}</title>
    <%self:css/>
    <%self:feeds/>
    <%self:ie_scripts/>
</head>
<body>
    <%self:topbar/>
    <%self:body_content/>
    <%self:scripts/>
    <%self:trackers/>
</body>
</html>
