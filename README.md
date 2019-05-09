## Prerequisites

Please install latest version of node ( Anything above version 8 should do, but we all do like the latest stuff, right? :) ). I recommend using `nvm`:

https://github.com/nvm-sh/nvm

If you are on windows, you might need to install the binary from Nodes website: 

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
