## Prerequisites

Please install latest LTS version of Node. At the time of writing it is v10.15.3. App might not work with latest version. I recommend using `nvm`:

https://github.com/nvm-sh/nvm

And install it using:

```
nvm install v10.15.3
```

If you are on Windows, you might need to se intaller from Nodes website: 

https://nodejs.org/en/

Once node is installed, please add elm binaries and elm formatter with npm globally: 
```
$ npm install -g elm
$ npm install -g elm-format
```
Or with yarn:
```
$ yarn global add elm
$ yarn global add elm-format
```

## VS Code setup

Please install VS Code: https://code.visualstudio.com/

And following extension for Elm: https://github.com/Krzysztof-Cieslak/vscode-elm

Enable format on save for elm
```
"[elm]": {
    "editor.formatOnSave": true
},
```

While it is not strictly necessary to install VS Code and you can use some other editor, please make sure that it has support for elm-format and does reformatting on save. It will help a lot. 

## App installation

Clone this repo into a new project folder:.

```sh
$ git clone git@github.com:janjiss/todo-mvc.git
$ cd todo-mvc
```

Run the install script with npm:
```sh
$ npm install
```

Or with yarn:
```sh
$ yarn
```

## Running the app

With npm:
```sh
$ npm start
```

With yarn:
```sh
$ yarn start
```

Open http://localhost:3000 and you should see `Hello world`
