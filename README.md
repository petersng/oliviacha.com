oliviacha.com
-------------

My GF's website.  For me, it means playing around using Jekyll for generating and deploying, along with writing some Ruby code.

Goes out and calls the Vimeo API to generates the data code for her video portfolio, given a formatted list of links to use.

Makes it easier to update it to whatever she wants.  Happy wife, happy life.

---

Files to create before use:

vimeo_links.txt - List of sections containing links to Vimeo videos.  These links are in the order in which they appear in the portfolio grid, from left to right, top to bottom on a 3x3 grid.

vimeo_keys.txt - The keys for accessing the Vimeo API.  Each line of this file is:
App ID
App Secret
Access Token
Access Token Secret

---

After these files are in place, run "jekyll build" and the site should be generated and placed into the _site dir.


