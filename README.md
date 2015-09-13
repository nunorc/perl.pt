

# perl.pt

Sources for the http://perl.pt website.

## Adding Posts

* Add a new file in the posts directory: `src/posts`, the file name is used to
create the URL for the new post.

* Use Markdown notation ([basic introduction](http://daringfireball.net/projects/markdown/)) to create the post.

* Clone the header of other posts files so that everything gets generated correcly, something like:
```
<blank line>
# Title
<blank line>
yyyy-mm-dd, por Author <e-mail>
<blank line>
<Text goes here>
```
After this you can write whatever you want. HTML weaved in you post is also ok.

* Do not forget to proofread your post. Use a spell checker.

* Push the changes to the repository, open a pull request, ...

* If you need an image in your post, commit the image to the `src/imgs` directory and use an absolute path for it, eg: `/imgs/myimage.png`. If you want to use a generic icon, as the APPP Onion logo, the Camelia butterfly or other, check if there is one already on the `imgs` folder, and try to reuse it.

* The currently used MarkDown to HTML converter does not support code blocks
surrounded by a line of back-ticks. Instead, indent the code block using spaces.

* Wait for the next build of the site.

## Building the Site

### Prerequisites

* `perl6`, Rakudo Star is a good option ([how-to-get-rakudo](http://rakudo.org/how-to-get-rakudo/))
* the markdown converter used for now is written in Perl 5, so you need [Text::Markdown](http://search.cpan.org/dist/Text-Markdown/) installed, this will be upgraded to a Perl 6 module soon-ish
* the following Perl 6 modules are required (check [panda](https://github.com/tadzik/panda/) to install modules):
  * [Template6](https://github.com/supernovus/template6/)
  * [Syndication](https://github.com/retupmoca/p6-syndication/)
  * [Pekyll](https://github.com/nunorc/p6-Pekyll)
  * [XML](https://github.com/supernovus/exemel/)

### Build

Once you have everything set up correctly just run;

```
$ perl6 build.p6
```

And the site will be generated in a `dist/` directory.
