oliviacha.com
-------------

My GF's video portfolio site, as she is a video editor.  She wanted a means to easily create her site without doing too much HTML or CSS to get her Vimeo links on the page.  So I hacked around with Jekyll, along with writing some custom Ruby code to extract Vimeo data given a list of links she wanted to use.  The Vimeo data was then used to generate the videos section on the site.

---

Files to create before use:

vimeo_links.txt - List of sections containing links to Vimeo videos.  These links are in the order in which they appear in the portfolio grid, from left to right, top to bottom on a 3x3 grid.

vimeo_keys.txt - The keys for accessing the Vimeo API.  Each line of this file is:
App ID
App Secret
Access Token
Access Token Secret

---

After these files are in place, run "jekyll build" and the site should be generated and placed into the _site dir.  Boom.

Copyright (C) Peter Ng + Olivia Cha


