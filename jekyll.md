# Jekyll

Jekyll is a static website generator. It converts your
[markdown](/markdown.html) files to web pages which you can publish with a
single command or few clicks.

## Recipe

If you are on a Mac, both Ruby and Jekyll are most likely installed. If
they aren't, install
[Ruby](https://www.ruby-lang.org/en/documentation/installation/) and then
Jekyll.

    $ gem install jekyll

Create a new directory for your project and run Jekyll.

    $ mkdir hello-world
    $ cd hello-world
    $ jekyll s


Create an `index.md` file in your favorite text editor with the following
content:

    ---
    ---
    # Hello, World!

Those dashes separate the Jekyll _front matter_ from your Markdown
content. Jekyll needs front matter even if it's empty.

Open <http://127.0.0.1:4000> in a web browser.

Edit `index.md`. Jekyll detects changes and regenerates all files. To see
changes, reload the web page.

Add more files if needed.

## Publish

One of the simplest ways to publish is to push your project to GitHub. It
will take care of running Jekyll to regenerate all files on push.

You can also publish your site on any web server. By default, Jekyll
renders all files to the `_site` directory, so just copy those files and
you're good to go. No dependencies, just static HTML files.

## Layout (optional)

When you have multiple files and want to style your web pages, it makes
sense to create a layout.

To add a new layout:

- Choose any layout name, say, `default`.
- Create a file `default.html` in the `_layouts` directory.
- Add any HTML you want and include the `{% raw %}{{content}}{% endraw %}`
  tag.

## Live reload (advanced)

When I'm editing wordy pages or tweaking layouts I use the
`jekyll-livereload` plugin. It triggers page reload every time I save a
file.

`jekyll-reload` injects JavaScript code into `<head>`. So **make sure you
have a `<head>` tag in your layout.**

Here's how to enable live reload:

Install Bundler:

    $ gem install bundler

Add `Gemfile`:

    source 'https://rubygems.org'
    gem 'jekyll', group: :jekyll_plugins
    group 'jekyll_plugins' do
      gem 'jekyll-livereload'
    end

Install and run:

    $ bundle install
    $ bundle exec jekyll serve -L

## See also

[Jekyll Minimalist](https://romanzolotarev.github.io/jekyll-minimalist),
[Jekyll](http://jekyllrb.com),
[GitHub Pages](https://pages.github.com)
