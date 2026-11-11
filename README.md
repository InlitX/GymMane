# GymMane web

The website for GymMane, built with [Eleventy](https://www.11ty.dev). It lives on the `web` branch only,
so `main` stays clean. GitHub Actions builds it and publishes it to GitHub Pages on every push to `web`.

```
index.html               the home page (copied as it is)
assets/                  styles, scripts, images, screenshots
app/                     the live demo (the real app built for the web)
blog/index.njk           the list of posts
blog/posts/              one Markdown file per post, both languages inside
_includes/               the page and post layouts
_data/site.json          links used by the layouts
```

## Run it locally

```bash
npm install
npm run dev
```

Then open http://localhost:8080/GymMane/. It reloads on every change.

## Write a post

Create `blog/posts/my-post.md`. The file name is the address: `/blog/my-post/`.

```md
---
date: 2026-11-20
tag_es: Novedades
tag_en: What's new
title_es: El título
title_en: The title
desc_es: Una línea para la lista y los buscadores.
desc_en: One line for the list and for search engines.
---

<div data-l="es">

Texto en Markdown.

</div>

<div data-l="en">

Text in Markdown.

</div>
```

Keep an empty line after each opening `<div>` and before each `</div>`, or the Markdown inside won't be read.
The ES/EN switch in the header shows one language or the other, like on the home page. Inside a post you can
also use `<div class="facts">`, `<div class="note">` and `<ol class="steps">` (see the existing posts).
