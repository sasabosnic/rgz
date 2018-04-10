# Start with Elm

This guide is all you need to go from zero to your first Elm app.

What is _Elm_? It's a purely functional compile-to-JavaScript language
with great performance and no runtime exceptions designed by Evan
Czaplicki in 2012.

## Hello, world

Let me start with the simplest app.

    import Html

    main =
      Html.text "Hello, World"

This code compiles to JavaScript like this:

    <!DOCTYPE HTML>
    <script>/* Elm runtime */</script>
    <script>Elm.Main.fullscreen();</script>

There are just two `<script>` tags: one with the app-related code baked
into 152 KB of Elm runtime (which, to be fair, can be minified and gzipped
to 17 KB) and another with the `Elm.Main.fullscreen()` function call. This
call sends `"Hello, World"` to the DOM.

Now you're ready to install everything on your computer and try it by
yourself.

## Install

_These instructions were tested with Node.js v6.9 and npm 3.10 on macOS
Sierra 10.12_. With different versions of Node.js or operating systems,
your mileage may vary.

One of the benefits of Elm is its lean tooling. If you have Node.js
installed, you can install the Elm platform with just two commands. Run
these in your project directory to initialize a project:

    $ npm init --yes
    $ npm install elm --save

Installing the Elm platform locally for every project takes about 50 MB of
disk space, but if you are working with multiple projects or with other
developers, avoid installing Elm globally.

## Make

To run your Elm app in a browser you need to compile it to JavaScript.

    $ printf 'import Html\nmain = Html.text "Hello, World"' > Main.elm
    $ $(npm bin)/elm-make Main.elm --yes

By default, `elm-make` generates `index.html`. Open it in your browser.
You should see `Hello, World` on the page.

## Live reload

Every time you change `*.elm` files, you need to compile them and reload
the web page in the browser. To automate this part we can use `elm-live`,
a helpful dev server. Install the server as dev dependency:


    $ npm install elm-live --save-dev

Run the server

    $ $(npm bin)/elm-live --path-to-elm-make="$(npm bin)/elm-make" Main.elm --yes

Add the `start` script to your `package.json`:

    ...
    "scripts": {
      "start": "elm-live Main.elm --yes --open",
      "test": ...

Now you can run the server with:

    $ npm start

It compiles `Main.elm` to `index.html` and opens <http://localhost:8000>
in your browser. Now whenever the `*.elm` files are changed, they compile
and your browser reloads the page automatically.

## Files

As result, you will get three artifacts in your project's directory.

## `Main.elm`

    import Html         -- Makes functions of the Html module
                        -- visible in this scope. Html
                        -- is a core Elm library
                        -- to handle the DOM

    main =              -- runtime calls function `main`
      Html.text         -- and it returns an element
        "Hello, World"  -- with text

## `elm-package.json`

    {
        "version": "1.0.0",
        "summary": "Hello, World",
        "repository": "https://github.com/romanzolotarev/elm-hello-world.git",
        "license": "BSD3",
        "source-directories": [
            "."
        ],
        "exposed-modules": [],
        "dependencies": {
            "elm-lang/core": "5.0.0 <= v < 6.0.0",
            "elm-lang/html": "2.0.0 <= v < 3.0.0"
        },
        "elm-version": "0.18.0 <= v < 0.19.0"
    }

## `package.json`

    {
        "scripts": {
            "start": "elm-live Main.elm --yes --open"
        },
        "dependencies": {
            "elm": "^0.18.0"
        },
        "devDependencies": {
            "elm-live": "^2.6.0"
        }
    }

The rest (`index.html`, `elm-stuff/`, `node_modules/`) can be added to
`.gitignore`.

## See also

[An Introduction to Elm by Evan Czaplicki](https://guide.elm-lang.org),
[Live reload server by Tomek Wiszniewski](https://github.com/tomekwi/elm-live)
