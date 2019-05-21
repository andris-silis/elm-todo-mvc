'use strict';

require("./styles.scss");

const { Elm } = require('./Todo');

const storedState = localStorage.getItem("elm-todo")
const initialState = storedState ? JSON.parse(storedState) : null

const todomvc = Elm.Todo.init({
    node: document.getElementById('elm'),
    flags: initialState
});

todomvc.ports.setStorage.subscribe((model) => {
    localStorage.setItem("elm-todo", JSON.stringify(model))
});
