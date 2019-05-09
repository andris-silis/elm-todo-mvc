'use strict';

require("./styles.scss");

const { Elm } = require('./Todo');

const todomvc = Elm.Todo.init({
    node: document.getElementById('elm'),
    flags: null
});