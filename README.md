

# perl.pt

Sources for the http://perl.pt website.

## Adding Posts

* Add a new file in the posts directory: `src/posts`, the file name is used to
create the URL for the new post.

* Use Markdown notation ([basic introduction](https://help.github.com/articles/markdown-basics/)) to create the post.

* Clone the header of other posts files so that everything gets generated correcly, something like:
```
<blank line>
# Title
<blank line>
yyyy-mm-dd, por Author <e-mail>
<blank line>
```
After this you can write whatever you want. HTML weaven in you post is also ok.

* Do not forget to proofread your post. Use a spell checker.

* Push the changes to the repository, open a pull request, ...

* If you need an image in your post, commit the image to the `src/imgs` directory and use an absolute path for it, eg: `/imgs/myimage.png`. If you want to use a generic icon, as the APPP Onion logo, the Camelia butterfly or other, check if there is one already on the `imgs` folder, and try to reuse it.

* Currently used MarkDown to HTML converter do not support code blocks surrounded
by a line of backticks. Instead, indent the code block for spaces.

* Wait for the next build of the site

## Building the Site

Coming up ...

