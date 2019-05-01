'use strict';

require("./styles.scss");

const { Elm } = require('./Todo');

const storedState = localStorage.getItem('elm-todo-save');
const startingState = storedState ? JSON.parse(storedState) : null;

const todomvc = Elm.Todo.init({
    node: document.getElementById('elm'),
    flags: startingState,
});

todomvc.ports.setStorage.subscribe(function(state) {
    localStorage.setItem('elm-todo-save', JSON.stringify(state));
});