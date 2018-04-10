# RSS to Email

Sending emails requires too much clicking and typing. Yes, it takes just
few minutes every week, but inefficiency makes me miserable, and the
miserable feeling lasts longer than the clicking. I love writing, and I do
not like dull clicking. Humans hate boring mechanical work, and robots
adore it. Right? At least I think so. Let's automate this.

As you know, Jekyll powers my website. To publish a new page, I just
create a file and push to GitHub directly from my text editor. I love the
simplicity of this workflow, and I wanted the same for my newsletter
updates. Fortunately, you can create RSS-to-email campaigns.

Another thing that makes me miserable is default email templates. They're
too bloated, too generic. They all look alike. Maybe it's just me, but I
rarely appreciate those colorful postcards with fancy fonts. I prefer
plain text and words.

## Recipe

1. Fork the [Jekyll Newsletter website boilerplate][j].
1. Publish your new Jekyll site with your first update.
1. [Validate the new RSS feed][validate]. RSS should contain **just one
   item** with that newsletter update.
1. [Sign up for Campaign Monitor][cm], if you do not have an account yet.
   The price starts at nine US dollars per month, and it depends on how
   many subscribers are in your list.
1. Go to **Lists & Subscribers**, then click the **Create a new list**
   button.
1. Give it the name, like `Newsletter`, and click **Create list**.
1. If you have subscribers already, click **Add subscribers** and paste in
   your existing list.
1. Go to **Automation**, then click on the **Setup an RSS campaign** link
   in the sidebar.
1. Type in your RSS feed URL, and click the **Look up** button.
1. Campaign Monitor will fetch your RSS feed and show the items. There
   should be just one. Click the **Use this feed** button.
1. Select your desired schedule in the **When to send the emails** section
   and click the **Next** button.
1. On the **Choose the design** page, select **Import your own**.
1. Type in a name for the template, say, `Minimalist`, then in the
   **Import from my computer** section click on **Choose file** under
   **HTML page**.
1. Use my [template](#template) as an example (change **src** in
   `<datarepeater>` and the content of `<rssitemlink>`).
1. Click on the **Add template** button. Campaign Monitor will check your
   HTML and import it.
1. On the **Who will receive this workflow?** page, select your list and
   click on the **Next** button.
1. Review your campaign on the **RSS snapshot** page, and click on the
   **Test and wrap up** button.
1. On the **Test your workflow** page, type in your email address and
   click **Send the test email**. Check your mailbox, and if everything
   looks right, click on the **Skip the test** button (yes, it's a
   confusing button label).
1. On the **Start your workflow** page, type in your email address and
   click **Start the schedule**.

Done!

If you need to change something, go to the **Automation** page, select
your campaign from the list, then click on the **Edit this workflow** link
in the sidebar.

## Template

    <!DOCTYPE html>
      <style>body { max-width: 400px; width: 90%; font-family: Arial, sans-serif; }</style>
      <!--[if mso]><table><tr><td width="400"><![endif]-->
      <p>Hi [firstname,fallback=]
      <datarepeater type="rss" src="https://www.romanzolotarev.com/newsletter.xml">
        <rssbody paragraphs="all" />
        <p><rssitemlink>View on romanzolotarev.com</rssitemlink>
      </datarepeater>
      <p style="margin-top: 4em; color: #777777;">
        Sent to [email]<br>
        <unsubscribe style="color: #777777;">Unsubscribe</unsubscribe>

Note: I intentionally omitted certain HTML tags, [because I
can][omission]. There is a hack with `table` for Outlook. Please email
me if something does not work for you, or if you know a nicer solution.

[j]: https://github.com/romanzolotarev/jekyll-newsletter
[omission]: https://html.spec.whatwg.org/multipage/syntax.html#syntax-tag-omission
[validate]: https://validator.w3.org/feed/
[cm]: https://www.campaignmonitor.com/pricing/

## Instead of a conclusion

I spent a lot of time to automate this. I could create a hundred campaigns
for sure. For me, it's probably [not worth the time][xkcd]. But would I do
it again? Hell yeah! I can't help but make robots work. Automate
everything! And hopefully, this recipe will save a few hours for you and
other humans.

As a side effect, I have a newsletter archive hosted on my site,
accessible even to those who didn't subscribe on the first day. Neat!

[xkcd]: https://m.xkcd.com/1205/
