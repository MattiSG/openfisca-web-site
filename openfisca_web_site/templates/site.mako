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
    <div class="container">
        <div class="row">
            <%self:breadcrumb/>
            <%self:container_content/>
        </div>
    </div>
    <%self:footer/>
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
            <li><a href="${urls.get_url(ctx)}">${_('Home')}</a></li>
</%def>


<%def name="container_content()" filter="trim">
    <%self:page_header/>
    <%self:page_content/>
</%def>


<%def name="css()" filter="trim">
##    <link href="${urls.get_url(ctx, u'/bower/bootstrap/dist/css/bootstrap.min.css')}" media="screen" rel="stylesheet">
    <link href="${urls.get_url(ctx, u'/css/bootstrap.css')}" media="screen" rel="stylesheet">
    <link href="${urls.get_url(ctx, u'/css/site.css')}" media="screen" rel="stylesheet">
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
    <footer class="footer navbar-default">
        <div class="container">
    % if node is not None and template is not None:
            <ul class="nav navbar-nav">
                <li><a href="https://github.com/openfisca/openfisca-web-site/tree/master/openfisca_web_site/templates${
                        node.template_path}">Source de la page</a></li>
            </ul>
    % endif
            <ul class="nav navbar-nav navbar-right">
                <li><a href="${urls.get_url(ctx, 'a-propos')}">${u"À propos"}</a></li>
                <li><a href="${urls.get_url(ctx, 'contact')}">${u"Contact"}</a></li>
                <li><a href="${urls.get_url(ctx, 'mentions-legales')}">Mentions légales</a></li>
            </ul>
        </div>
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
                <div class="col-lg-3 col-sm-6">
                    <a class="partner" href="http://www.strategie.gouv.fr/">
                        <img alt="Logo du Commissariat général à la stratégie et à la prospective (CGSP)" class="partner" src="logos-partenaires/logo-cgsp.png"></img>
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
                <div class="col-lg-3 col-sm-6">
                    <a class="partner" href="http://www.etalab.gouv.fr/">
                        <img alt="Logo d'Etalab" class="partner" src="logos-partenaires/logo-etalab.png"></img>
                    </a>
                    <a href="http://www.etalab.gouv.fr/">
                        <h4>Etalab</h4>
                    </a>
                    <p>
                        Service du premier ministre chargé de l'ouverture des données publiques et du développement de
                        la plateforme française Open Data <a href="http://data.gouv.fr">data.gouv.fr</a>
                    </p>
                </div>
                <div class="col-lg-3 col-sm-6">
                    <a class="partner" href="http://www.idep-fr.org/">
                        <img alt="Logo de l'Institut d'économie publique (IDEP)" class="partner" src="logos-partenaires/logo-idep.png"></img>
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
                <div class="col-lg-3 col-sm-6">
                    <a class="partner" href="http://www.ipp.eu/">
                        <img alt="Logo de l'Institut des politiques publiques (IPP)" class="partner" src="logos-partenaires/logo-ipp.png"></img>
                    </a>
                    <a href="http://www.ipp.eu/">
                        <h4>Institut des politiques publiques</h4>
                    </a>
                    <p>
                        L’Institut des politiques publiques (IPP) est développé dans le cadre d’un partenariat
                        scientifique entre
                        <a href="http://www.parisschoolofeconomics.eu/"><abbr title="Paris School of Economics">PSE</abbr></a>
                        et le
                        <a href="http://www.crest.fr/"><abbr title="Centre de recherche en économie et statistiques">CREST</abbr></a>.
                        L’IPP vise à promouvoir l’analyse et l’évaluation  quantitatives des politiques publiques en
                        s’appuyant sur les méthodes les plus récentes de la recherche en économie.
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
        <header class="container">
            <h1 id="logo">
                <a href="${urls.get_url(ctx)}">OpenFisca</a> 
            </h1>
            <p class="lead slogan">Moteur ouvert de simulation du système socio-fiscal</p>
        </header>
        <nav class="navbar navbar-default" role="navigation">
            <%self:topbar_content/>
        </nav>
</%def>


<%def name="topbar_content()" filter="trim">
            <div class="container">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-responsive-collapse">
                        <span class="sr-only">${_(u'Toggle navigation')}</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                </div>
                <div class="collapse navbar-collapse navbar-responsive-collapse">
                    <ul class="nav navbar-nav">
                        <li><a href="${urls.get_url(ctx)}"><span class="glyphicon glyphicon-home"></span></a></li>
                        <li><a href="${urls.get_url(ctx, 'presentation')}">${u"Présentation"}</a></li>
                        <li><a href="${urls.get_url(ctx, 'utilisations')}">${u"Exemples"}</a></li>
                        <li><a href="${urls.get_url(ctx, 'installation-web-openfisca')}">${u"Documentation"}</a></li>
##                        <li><a href="${urls.get_url(ctx, 'api')}">${u"API"}</a></li>
                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="${conf['ui.url']}">${u"Simulation en ligne"}</a></li>
                    </ul>
                </div>
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
