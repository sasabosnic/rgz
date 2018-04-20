# Compare Vanilla JavaScript, Ramda, and Elm

I recently worked on pagination for a web app. This simple problem is a
good case study for comparing JavaScript and Elm.

Here's the use case:

We have a current page address, for example **index**, and a list of all
the page addresses: **index**, **vanilla**, **ramda**, **elm**.

There are two links, **Previous** and **Next**. By clicking on those links
you go to the previous or the next page accordingly.

When you're on the first page, the **Previous** link is disabled. When
you're on the last page, **Next** is disabled.

                  current page
                      |
                      |
    [ Previous ]    index    vanilla    ramda    elm    [ Next ]
          |
          |
    disabled link

Let's write two functions --- one to prepare a data structure and another
to generate HTML code based on it.

## The `paginate()` function

This function takes a **current** page and a list of **pages**. It returns
a tuple of **previous**, **next**. Both elements of the tuple can be
empty.

## The `html()` function

This function takes the result of `paginate()` and returns an HTML string
containing links to the next and previous pages. It handles cases when a
current page is not found, or either of the **previous** or **next** links
is missing.

    // List of pages
    pages = ['index', 'vanilla', 'ramda', 'elm']

    // There should be no Previous page
    paginate('index', pages);
    // => [undefined, 'vanilla']

    html(paginate('index', pages));
    // => 'No previous<a href="vanilla">Next</a>'

    // Both links are available
    html(paginate('vanilla', pages));
    // => '<a href="index">Previous</a><a href="ramda">Next</a>'

    // Non-existent page
    html(paginate('pageX', pages));
    // => 'Current not found'

To start with, let's implement this in vanilla JavaScript.

## Vanilla JavaScript

We'll start with a plain JavaScript implementation; to be specific,
ECMAScript 5. Then we'll see what we can improve.

How can we implement `paginate()` in JavaScript? First, get the index of
the `current` page in the array of `pages`. If `current` is found, then
get its neighbors and return an array of `[previous, next]`; otherwise,
return nothing.

Implementing `html()` is pretty straightforward: get that array and render
it to a string.

## Na&#x00EF;ve implementation in ECMAScript 5.

    var pages = ['index', 'vanilla', 'ramda', 'elm'];
    var current = 'vanilla';

    var paginate = function(current, pages) {

      // Get index of current page
      // in array of pages
      var i = pages.indexOf(current);

      // If current page is found
      // (index is not -1)
      return i !== -1
        ? ([ pages[i - 1], // Previous page
            pages[i + 1]  // Next page
          ])
        // else return undefined
        : undefined;
    }

    var html = function(pagination) {
      if (pagination === undefined) return 'Current not found';

      var previous =
        pagination[0] === undefined
          ? 'No previous'
          : ('<a href="' + pagination[0] + '">Previous</a>');

      var next =
        pagination[1] === undefined
          ? 'No next'
          : ('<a href="' + pagination[1] + '">Next</a>');

      return (previous + next);
    }

Now we can test our functions.

    pages = ['index', 'vanilla', 'ramda', 'elm']
    // => '["index", "vanilla", "ramda", "elm"]'

    current = 'vanilla'
    // => "vanilla"

    paginate(current, pages)
    // => ["index", "ramda"]

    html(paginate(current, pages))
    // => "<a href=\"index\">Previous</a><a href=\"ramda\">Next</a>"

## How can we improve it?

First, those `undefined` values look suspicious. Just take a look at the
edge case, when **previous** is `undefined`:

    paginate('index', pages)
    // => [undefined, "vanilla"]

We need some safer data types.

Second, those `if` and `else` statements are a problem. It is possible to
forget something and accidentally miss a case.

We need a better way to branch our code.

## Built with Ramda

Before we dive in into our implementation, let's get familiar with Ramda,
a functional library for JavaScript.

If you haven't tried functional programming before, it may look unusual,
but it's totally worth learning. It is consistently simple, backed by
math, and fun to learn.

## Ramda

Ramda helps us to write code in a purer functional style. It's a small
library, has no dependencies, and works in all browsers as well as Node.

    var numbers = [10, 20, 30, 40];
    var inc = function (x) { return (x + 1); }

Compare the native `map`...

    numbers.map(inc)
    // => [11, 21, 31, 41]

... with Ramda's:

    R.map(inc, numbers)
    // => [11, 21, 31, 41]

It doesn't look that different at the beginning... but it's only the
beginning.

How does `map()` work? It takes a function and a functor (e.g., array,
string, or object), applies the function to each of the functor's values,
and returns a functor of the same shape.

    R.map(inc, {a: 100, b: 200})
    // => {"a": 101, "b": 201}

    R.map(inc, {a: 'a', b: 'b'})
    // => {"a": "a1", "b": "b1"}

    R.map(inc, 'abc')
    // => ["a1", "b1", "c1"]

What happens when you pass fewer parameters than the function expects?
Usually JavaScript functions are not happy:

    numbers.map()
    // => TypeError: Array.prototype.map callback must be a function

Now look at the Ramda function:

    R.map()
    // => function n(r,e){switch(arguments.length){case 0:return n;case 1:return b(r)?n:L(function(n){return t(r,n)});default:return b(r)&&b(e)?n:b(r)?L(function(n){return t(n,e)}):b(e)?L(function(n){return t(r,n)}):t(r,e)}}

That's right --- it returns a function. If there were no parameters
passed, it returns itself. Just double checking:

    R.map
    // => function n(r,e){switch(arguments.length){case 0:return n;case 1:return b(r)?n:L(function(n){return t(r,n)});default:return b(r)&&b(e)?n:b(r)?L(function(n){return t(n,e)}):b(e)?L(function(n){return t(r,n)}):t(r,e)}}

What if you pass one parameter instead of two?

    incAll = R.map(inc)
    // => function n(r){return 0===arguments.length||b(r)?n:t.apply(this,arguments)}

It returns a partially applied function.

All Ramda functions are automatically curried and work this way. A
*curried* function can take only a subset of its parameters and return a
new function that takes the remaining parameters. If you call a curried
function with all of its parameters, it just calls the function and
returns a value.

So all of the following expressions return the same result:

    incAll(numbers)
    // => [11, 21, 31, 41]

    R.map(inc, numbers)
    // => [11, 21, 31, 41]

    R.map(inc)(numbers)
    // => [11, 21, 31, 41]

    R.map()(inc)(numbers)
    // => [11, 21, 31, 41]

Note that in most Ramda functions the data is supplied as the last
parameter, to make it convenient for currying.

By the way, Ramda has `R.inc()` and `R.dec()` already.

    R.map(R.dec)(numbers)
    // => [9, 19, 29, 39]

Probably the simplest Ramda function is `R.identity()`. It does nothing
but return the parameter supplied to it, so it's good as a placeholder
function. We will use it in the example.

    R.map(R.identity)(numbers)
    // => [10, 20, 30, 40]

The next two function names speak for themselves: `R.head()` returns the
first element of the array.

    R.head(numbers)
    // => 10

`R.last()` returns the last element of the array.

    R.last(numbers)
    // => 40

The last function you need to learn for now is `R.concat()`.

    R.concat(numbers, 50)
    // => [10, 20, 30, 40, 50]

I am glad you got this far! Finally, we are at the point where we can get
rid of `undefined`. There is a library for this. :)

## Sanctuary

Sanctuary is a functional programming library. It depends on and works
nicely with Ramda.

Let's compare what two `indexOf` functions return when the element is not
found in the array:

    R.indexOf(42, numbers)
    // => -1

`-1`? Okay. Kind of weird, but familiar. Now look at Sanctuary's version:

    S.indexOf(42, numbers)
    // => Nothing()

It returns a value of `Maybe` type. `Maybe` is useful for composing
functions that might not return a value.

Here's one more example of a function which returns `Maybe`.

`S.at()` takes an index and a list and returns `Just` the element of the
list at the index, if the index is within the list's bounds...

    S.at(1, numbers)
    // => Just(20)

... and returns `Nothing` otherwise.

    S.at(100, numbers)
    // => Nothing()

Compare it with the native JavaScript alternative:

    numbers[100]
    // => undefined

Okay, sounds like we can get rid of `undefined`. But how should we handle
`Maybe` values? To apply functions to `Maybe` values you can use old good
`map`:

    R.map(R.inc, S.Just(3))
    // => Just(4)

    R.map(R.inc, S.Nothing())
    // => Nothing()

But what about branching code without using conditionals? In our case, we
have two branches, left and right.

    pagination[2] === undefined
      ? 'No next'                                     // Left
      : ('<a href="' + pagination[2] + '">Next</a>'); // Right

To handle it, we can convert `Maybe` to `Either`. What is `Either`? The
`Either` type represents values with two possibilities, `Left` and
`Right`.

    S.maybeToEither('No next', S.Just(3))
    // => Right(3)

    S.maybeToEither('No next', S.Nothing())
    // => Left("No next")

Now we can apply two different functions to `Left` and `Right`.

When the third parameter is `Left`, then `R.identity()` is applied to `'No
next'`. Let's hard-code the third parameter to test `S.either`.

    S.either(R.identity, R.toString, S.Left('No next'))
    // => "No next"

When the third parameter is `Right`, then `R.toString()` is applied to
`3`. The third parameter is hard-coded again.

    S.either(R.identity, R.toString, S.Right(3))
    // => "3"

Congratulations! Now you are ready to read the refactored solution. ;)

## Implementation with Ramda and Sanctuary

    // var R = require('ramda');
    // var S = require('sanctuary');

    var pages = ['index', 'vanilla', 'ramda', 'elm'];
    var current = 'ramda';

    var paginate = function(current, pages) {

      return R.map(
        function(index) {
          return [
            S.at(R.dec(index), pages),
            S.at(R.inc(index), pages)
          ]
        },
        // Gets index of the current page
        S.indexOf(current, pages)
      )
    }

    var html = function(pagination) {

      var previous =
        function(url) {
          return ('<a href="' + url + '">Previous</a>');
        }

      var next =
        function(url) {
          return ('<a href="' + url + '">Next</a>');
        }

      var buttons = function(x) {
        return R.concat(
          S.either(
            R.identity,
            previous,
            S.maybeToEither('No previous', R.head(x))
          ),
          S.either(
            R.identity,
            next,
            S.maybeToEither('No next', R.last(x))
          )
        )
      }

      return S.either(
        R.identity,
        buttons,
        S.maybeToEither('Current not found', pagination)
      )
    }

Let's test it.

    pages = ['index', 'vanilla', 'ramda', 'elm']
    // => ["index", "vanilla", "ramda", "elm"]

    current = 'ramda'
    // => "ramda"

    paginate('ramda', pages)
    // => Just([Just("vanilla"), Just("elm")])

    html(paginate('ramda', pages))
    // => "<a href=\"vanilla\">Previous</a><a href=\"elm\">Next</a>"

## What can we improve?

Syntax. It is getting pretty lengthy and noisy. ECMAScript 2015 solves
this partially.

    const paginate = (current, pages) => R.map(
      (i) => R.map(
        S.at(R.dec(i), pages),
        S.at(R.inc(i), pages)
      ), S.indexOf(current, pages)
    )

By the way, here's our vanilla version in ECMAScript 2015.

    const paginate = (current, pages) => {
      const i = pages.indexOf(current);
      return i !== -1
        ? [pages[i - 1], pages[i + 1]]
        : undefined;
    }

Another problem with our solution is that `html()` returns a string. It
would be good to have DOM elements instead. To manipulate the DOM we can
use one of the Virtual DOM libraries or frameworks, like React, Angular,
Ember, or Vue.

If we're looking for a lighter and purely functional solution, Elm is
a better option.

## Built with Elm

I have been playing with Elm for several months and find it fascinating:
Helpful error messages. If it compiles, it works; no runtime errors; good
performance; clean syntax; simple refactoring, and so on.

## Writing in Elm

Create a file, say `pagination.elm`. If you are using any modules, you
have to import them explicitly.

For this implementation in Elm I'm using the `List` type for the list of
pages. To get value by index, we use `getAt()` and to get index by value,
we use `elemIndex()`. Both functions are from the `List.Extra` module;
let's import it.

    import List.Extra

    List.Extra.getAt 3 pages
    -- Just "elm"

We can use the `exposing` keyword to import particular functions of the
module, and then call them _without a qualifier_.

    import List.Extra exposing (getAt, elemIndex)

    getAt 3 pages
    -- Just "elm"

    elemIndex "elm" pages
    -- Just 3

As you can see, you don't need brackets in these function calls, just the
function name and a list of its parameters.

To define a function you just type in a function name, then a list of its
parameters, then the `=` sign, and finally its definition.

    inc x = x + 1

    inc 1
    -- 2

You can define local functions inside a function with the `let ... in`
keywords.

    current = "ramda"

    isCurrent page =
        let
            current = "elm"
        in
            page == current

    isCurrent "elm"
    -- True

To handle cases you can use the `case ... of` keywords, which is useful
for pattern matching. The important difference with Elm is that its
compiler won't let you forget to cover cases, and will make sure all
branches return values of the same shape.

    get index pages =
        case index of
            Just i ->
                "Index is " ++ i

            Nothing ->
                "No index"

You've probably noticed that for summing numbers in Elm we use `+`, but to
concatenate strings we need `++`.

Our function `paginate()` returns a tuple, which is a data type in Elm.
Here's the syntax.

    pagination = (Just "elm", Nothing)

Oh, the `Maybe` type is in the Elm core library, so you don't need to
import it.

HTML elements are functions of the `Html` module. To create a link ---
HTML element `<A>` --- you need to call the function `Html.a` with two
parameters: list of attributes and list of children.

    Html.a [ Html.Attributes.href "ramda" ] [ Html.text "Previous" ]

As you can guess, `href` is a function from the `Html.Attributes` module,
and `text` is a function from the `Html` module.

That's it. You know enough Elm to read the code:

    import Html exposing (div, text, a)
    import Html.Attributes exposing (href)
    import List.Extra exposing (getAt, elemIndex)


    pages =
        [ "index", "vanilla", "ramda", "elm" ]


    current =
        "elm"


    paginate current pages =
        case (elemIndex current pages) of
            Just i ->
                ( (getAt (i - 1) pages), (getAt (i + 1) pages) )

            _ ->
                ( Nothing, Nothing )


    html pagination =
        let
            next page =
                case page of
                    Just url ->
                        a [ href url ] [ text "Next" ]

                    Nothing ->
                        text "No next"

            previous page =
                case page of
                    Just url ->
                        a [ href url ] [ text "Previous" ]

                    Nothing ->
                        text "No previous"
        in
            case pagination of
                ( Nothing, Nothing ) ->
                    text "Current not found"

                ( p, n ) ->
                    div [] [ previous p, next n ]


    main =
        html (paginate current pages)

## Epilogue

You may ask, what's the point of adding lines of code and introducing new
libraries and weird data types --- even a new language! Doesn't it
complicate everything?

First, type safety helps you to avoid runtime errors and catch mistakes
earlier. Second, pure functions are much simpler to understand, to
maintain, and to refactor. Third, in most cases composability and
point-free style make your code much cleaner.

If you're building a small web app and file size is critical, then nothing
can beat vanilla JavaScript, of course. However, when your app grows,
Ramda or Elm can save you from mistakes and make your developer experience
much better.

You'd still better know [JavaScript equality
quirks](https://dorey.github.io/JavaScript-Equality-Table/), how to
manipulate the
[DOM](https://developer.mozilla.org/en-US/docs/Web/API/Document_Object_Model)
directly, how to manage scope, how to avoid mutable state, how to handle
`null`, etc.

If JavaScript is so weird, why should we learn it? Because 3 billion
people use web browsers and  JavaScript is the only scripting language
natively supported by most web browsers today. JavaScript is getting
better, but it won't be changed dramatically anytime soon.

## Bonus track

Thank you for reading this far! Here's another implementation with the Elm
core library only. You can copy-paste it to [Elm
REPL](http://elm-lang.org/try) and play with it.

    import Html
    import List

    pages = [ "index", "vanilla", "ramda", "elm" ]
    current = "elm"

    paginate current pages =
        let
            cs = pages |> List.map Just
            ns = List.drop 1 cs ++ [ Nothing ]
            ps = Nothing :: List.take (List.length cs - 1) cs
            isCurrent (p, c, n) =
                case c == Just current of
                    True -> Just (p, n)
                    False -> Nothing
        in
            List.map3 (\p c n -> ( p, c, n )) ps cs ns
              |> List.filterMap isCurrent

    main =
        paginate current pages
          |> toString
          |> Html.text
          -- Just (Just "ramda", Just "elm", Nothing)

## See also

[An Introduction to Elm by Evan Czaplicki](https://guide.elm-lang.org),
[Type Signatures by Scott Sauyet](https://github.com/ramda/ramda/wiki/Type-Signatures),
[Functors, Applicatives, And Monads In Pictures by Aditya Bhargava](http://adit.io/posts/2013-04-17-functors,_applicatives,_and_monads_in_pictures.html),
[Thinking in Ramda by Randy Coulman](http://randycoulman.com/blog/categories/thinking-in-ramda/),
[Professor Frisby's Mostly Adequate Guide to FP by Brian Lonsdorf](https://github.com/MostlyAdequate/mostly-adequate-guide),
[Functional-Light JavaScript by Kyle Simpson](https://github.com/getify/functional-light-js),
[Awesome FP JavaScript](https://github.com/stoeffel/awesome-fp-js)
