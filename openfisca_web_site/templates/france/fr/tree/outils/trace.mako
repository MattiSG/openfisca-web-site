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


<%def name="css()" filter="trim">
    <%parent:css/>
    <link href="${urls.get_static_url(ctx, u'/bower/rainbow/themes/github.css')}" rel="stylesheet">
</%def>


<%def name="h1_content()" filter="trim">
Trace
</%def>


<%def name="page_content()" filter="trim">
        <ul class="nav nav-tabs">
            <li class="active"><a href="#trace-interface-tab-content" data-toggle="tab">Interface</a></li>
            <li><a href="#trace-template-tab-content" data-toggle="tab">Template</a></li>
            <li><a href="#trace-javascript-tab-content" data-toggle="tab">JavaScript</a></li>
        </ul>
        <div class="tab-content">
            <div class="tab-pane active" id="trace-interface-tab-content">
                <div id="trace-container"></div>
                <%self:trace_template/>
            </div>
            <div class="tab-pane" id="trace-template-tab-content">
                <pre><code data-language="html">${capture(self.trace_template)}</code></pre>
            </div>
            <div class="tab-pane fade" id="trace-javascript-tab-content">
                <pre><code data-language="javascript">${capture(self.trace_script_content)}</code></pre>
            </div>
        </div>
</%def>


<%def name="scripts()" filter="trim">
    <%parent:scripts/>
    <script src="${urls.get_static_url(ctx, u'/bower/ractive/ractive.js')}"></script>
    <script src="${urls.get_static_url(ctx, u'/bower/rainbow/js/rainbow.min.js')}"></script>
    <script src="${urls.get_static_url(ctx, u'/bower/rainbow/js/language/generic.js')}"></script>
    <script src="${urls.get_static_url(ctx, u'/bower/rainbow/js/language/html.js')}"></script>
    <script src="${urls.get_static_url(ctx, u'/bower/rainbow/js/language/javascript.js')}"></script>
    <script src="${urls.get_static_url(ctx, u'/bower/rainbow/js/language/python.js')}"></script>
    <script>
<%self:simulation_script_content/>
<%self:trace_script_content/>
    </script>
</%def>


<%def name="simulation_script_content()" filter="trim">
var baseSimulationText = ${simulation_text or u'''\
{
  "scenarios": [
    {
      "test_case": {
        "familles": [
          {
            "parents": ["ind0", "ind1"]
          }
        ],
        "foyers_fiscaux": [
          {
            "declarants": ["ind0", "ind1"]
          }
        ],
        "individus": {
          "ind0": {
            "sali": 15000
          },
          "ind1": {}
        },
        "menages": [
          {
            "personne_de_reference": "ind0",
            "conjoint": "ind1"
          }
        ]
      },
      "year": 2013
    }
  ],
  "variables": ["revdisp"]
}''' | n, js};
</%def>


<%def name="trace_script_content()" filter="trim">
var traceRactive = new Ractive({
    el: 'trace-container',
    template: '#trace-template',
    data: {
        apiUrl: ${api_url or conf['urls.api'] | n, js},
        getEntityBackgroundColor: function (step) {
            return {
                'fam': 'bg-success',
                'familles': 'bg-success',
                'foy': 'bg-info',
                'foyers_fiscaux': 'bg-info',
                'ind': 'bg-primary',
                'individus': 'bg-primary',
                'men': 'bg-warning',
                'menages': 'bg-warning'
            }[step.entity] || step.entity;
        },
        getEntityKeyPlural: function (step) {
            return {
                'fam': 'familles',
                'foy': 'foyers fiscaux',
                'ind': 'individus',
                'men': 'ménages'
            }[step.entity] || step.entity;
        },
        getType: function (object) {
            return object['@type'];
        },
        scenariosVariables: null,
        showDefaultFormulas: false,
        simulationError: null,
        simulationText: baseSimulationText,
        tracebacks: null,
        variableHolderByCode: {},
        variableOpenedByCode: {}
    }
});
traceRactive.on({
    'toggle-variable-panel': function (event) {
        event.original.preventDefault();
        var name = traceRactive.get('tracebacks')[event.index.scenarioIndex][event.index.tracebackStepIndex].name;
        var path = 'variableOpenedByCode.' + name;
        previousValue = this.get(path);
        this.toggle(path);
        if (! this.get('variableHolderByCode')[name]) {
            $.ajax(traceRactive.get('apiUrl') + 'api/1/field', {
                data: {
                    variable: name
                },
                dataType: 'json',
                type: 'GET',
                xhrFields: {
                    withCredentials: true
                }
            })
            .done(function (data, textStatus, jqXHR) {
                traceRactive.set('variableHolderByCode.' + name, data.value).then(function () {
                    ## Colorize code in variable.
                    Rainbow.color();
                });
            })
            .fail(function(jqXHR, textStatus, errorThrown) {
                console.log('fail');
                console.log(jqXHR);
                console.log(textStatus);
                console.log(errorThrown);
            });
        }
    },
    'submit-form': function (event) {
        if (event) {
            event.original.preventDefault();
        }
        var simulationText = this.get('simulationText');
        try {
            var simulationJson = JSON.parse(simulationText);
            simulationJson.trace = true;
        } catch (error) {
            traceRactive.set('simulationError', error.message);
            return;
        }

        $.ajax(this.get('apiUrl') + 'api/1/calculate', {
            contentType: 'application/json',
            data: JSON.stringify(simulationJson),
            dataType: 'json',
            type: 'POST',
            xhrFields: {
                withCredentials: true
            }
        })
        .done(function (data, textStatus, jqXHR) {
            traceRactive.set({
                scenariosVariables: data.variables,
                simulationError: null,
                tracebacks: data.tracebacks
            });
        })
        .fail(function(jqXHR, textStatus, errorThrown) {
            console.log('fail');
            console.log(jqXHR);
            console.log(textStatus);
            console.log(errorThrown);
            traceRactive.set('simulationError', jqXHR.responseText);
        });
    }
});

traceRactive.fire('submit-form');
</script>
</%def>


<%def name="trace_template()" filter="trim">
<script id="trace-template" type="text/ractive">
    <h2>Historique des calculs permettant de calculer le revenu disponible</h2>
    <form class="form" role="form" on-submit="submit-form">
        <p class="lead">
            Saisissez le JSON d'une simulation, pour connaître sa décomposition en prélèvements et prestations.
        </p>
        <div class="form-group">
            <label class="control-label" for="simulation">Simulation :</label>
            <textarea class="form-control" placeholder="Mettez ici la simulation au format JSON" rows="10" value="{{
                    simulationText}}"></textarea>
            {{#simulationError}}
                <pre><code data-language="javascript">{{simulationError}}</pre>
            {{/simulationError}}
        </div>
        <p class="form-control-static"><b>URL API :</b> {{apiUrl}}</p>
        <button class="btn btn-primary" type="submit">Simuler</button>
        <div class="checkbox">
            <label>
                <input checked="{{showDefaultFormulas}}" type="checkbox">
                Afficher aussi les formules appelées avec les valeurs par défaut
            </label>
        </div>
    </form>
    {{#tracebacks:scenarioIndex}}
        {{#.:tracebackStepIndex}}
            {{# .is_computed && (showDefaultFormulas || ! .default_arguments)}}
                <div class="panel panel-default">
                    <div class="panel-heading" on-click="toggle-variable-panel" style="cursor: pointer">
                        <div class="row">
                            <div class="col-sm-3">
                                <span class="glyphicon {{variableOpenedByCode[name] ? 'glyphicon-minus'
                                        : 'glyphicon-plus'}}"></span>
                                <code>{{name}}</code>
                            </div>
                            <div class="col-sm-5">{{label}}</div>
                            <div class="col-sm-1 {{getEntityBackgroundColor(.)}}">{{getEntityKeyPlural(.)}}</div>
                            <div class="col-sm-1">{{period}}</div>
                            <div class="col-sm-2">
                                {{# {
                                    variableValue: scenariosVariables[scenarioIndex][name]
                                }}}
                                    {{# {
                                        variableArray: typeof variableValue === 'object' ? variableValue[period] : variableValue
                                    }}}
                                        <ul class="list-unstyled">
                                            {{#variableArray}}
                                                <li class="text-right">{{.}}</li>
                                            {{/variableArray}}
                                        </ul>
                                    {{/}}
                                {{/}}
                            </div>
                        </div>
                    </div>
                    {{#variableOpenedByCode[name]}}
                        <div class="panel-body">
                            {{#variableHolderByCode[name]}}
                                {{#.formula}}
                                    {{>formulaContent}}
                                {{/.formula}}
                            {{/variableHolderByCode[name]}}
                        </div>
                    {{/variableOpenedByCode[name]}}
                </div>
            {{/ .is_computed && (showDefaultFormulas || ! .default_arguments)}}
        {{/.}}
    {{/tracebacks}}


    <!-- {{>formulaContent}} -->
    {{# getType(.) === 'AlternativeFormula'}}
        <h3>Choix de fonctions <small>AlternativeFormula</small></h3>
        <ul>
            {{#.alternative_formulas}}
                <li>
                    {{>formulaContent}}
                </li>
            {{/.alternative_formulas}}
        </ul>
    {{/ getType(.) === 'AlternativeFormula'}}
    {{# getType(.) === 'DatedFormula'}}
        <h3>Fonctions datées <small>DatedFormula</small></h3>
        <ul>
            {{#.dated_formulas}}
                <li>
                    <span class="lead">{{start_instant}} - {{stop_instant}}</span>
                    {{#.formula}}
                        {{>formulaContent}}
                    {{/.formula}}
                </li>
            {{/.dated_formulas}}
        </ul>
    {{/ getType(.) === 'DatedFormula'}}
    {{# getType(.) === 'SelectFormula'}}
        <h3>Choix de fonctions <small>SelectFormula</small></h3>
        <ul>
            {{#.formula_by_main_variable:mainVariable}}
                <li>
                    <span class="lead">{{mainVariable}}</span>
                    {{>formulaContent}}
                </li>
            {{/.formula_by_main_variable:mainVariable}}
        </ul>
    {{/ getType(.) === 'SelectFormula'}}
    {{# getType(.) === 'SimpleFormula'}}
        <h3>Fonction <small>SimpleFormula</small></h3>
        <h4>Paramètres</h4>
            <table class="table">
                <thead>
                    <tr>
                        <th>Nom</th>
                        <th>Libellé</th>
                        <th>Entité</th>
                        <th>Période</th>
                        <th>Valeur</th>
                    </tr>
                </thead>
                <tbody>
                    {{#.variables}}
                        {{# {
                            argumentPeriod: tracebacks[scenarioIndex][tracebackStepIndex].arguments[.name],
                            entityBackgroundColor: getEntityBackgroundColor(.),
                            argumentValue: scenariosVariables[scenarioIndex][.name]
                        }}}
                            {{# {
                                argumentArray: typeof argumentValue === 'object' ? argumentValue[argumentPeriod] : argumentValue
                            }}}
                                <tr>
                                    <td><code>{{name}}</code></td>
                                    <td>{{label != name ? label : ''}}</td>
                                    <td class="{{entityBackgroundColor}}">{{entity}}</td>
                                    <td>{{argumentPeriod}}</td>
                                    <td>
                                        <ul class="list-unstyled">
                                            {{#argumentArray}}
                                                <li class="text-right">{{.}}</li>
                                            {{/argumentArray}}
                                        </ul>
                                    </td>
                                </tr>
                            {{/}}
                        {{/}}
                    {{/.variables}}
                </tbody>
            </table>
        <h4>Code source <a class="btn btn-info" href="https://github.com/openfisca/openfisca-france/tree/master/{{
                module.split('.').join('/')}}.py#L{{line_number}}-{{
                line_number + source.trim().split('\n').length - 1}}" target="_blank">Voir dans GitHub</a></h4>
        <pre><code data-language="python">{{source}}</code></pre>
    {{/ getType(.) === 'SimpleFormula'}}
    <!-- {{/formulaContent}} -->
</script>
</%def>
