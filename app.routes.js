'use strict';

angular
    .module('app.routes', ['ngRoute'])
    .config(config);

function config ($routeProvider) {
    $routeProvider.
        when('/', {
            templateUrl: 'views/home/index.tpl.html',
            controller: 'HomeController'
        })
        .otherwise({
            redirectTo: '/'
        });
}