

# perl.pt

Sources for the http://perl.pt website.

## Adding Posts

* Add a new file in the posts directory: `src/posts`, the file name is used to
create the URL for the new post.

* Use Markdown notation to create the post.

* Clone the header of other posts files so that everything gets generated correcly, something like:
```
<blank line>
# Title
<blank line>
yyyy-mm-dd, por Author <e-mail>
<blank line>
```
After this you can write whatever you want. HTML weaven in you post is algo ok.

* Push the changes to the repository, open a pull request, ...

* If you need an image in your post, commit the image to the `src/imgs` directory and use an absolute path for it, eg: `/imgs/myimage.png`.

* Wait for the next build of the site

## Building the Site

Coming up ...

