import crypto from "node:crypto";
import fs from "node:fs";
import { HtmlBasePlugin } from "@11ty/eleventy";

const locales = { en: "en-GB", es: "es-ES" };

export default function (config) {
  config.addPlugin(HtmlBasePlugin);

  config.setTemplateFormats(["njk", "md"]);
  config.ignores.add("README.md");
  config.ignores.add("app/**");

  config.addPassthroughCopy("index.html");
  config.addPassthroughCopy("llms.txt");
  config.addPassthroughCopy("assets");
  config.addPassthroughCopy("app");

  config.addFilter("day", (date, lang = "es") =>
    new Intl.DateTimeFormat(locales[lang], { day: "numeric", month: "long", year: "numeric", timeZone: "UTC" }).format(date),
  );

  config.addFilter("iso", (date) => date.toISOString().slice(0, 10));

  config.addFilter("v", (file) =>
    crypto.createHash("md5").update(fs.readFileSync(file)).digest("hex").slice(0, 8),
  );

  config.addFilter("minutes", (content, lang) => {
    const text = String(content).replace(/<[^>]+>/g, " ");
    const marker = `data-l="${lang}"`;
    const words = text.split(/\s+/).length;
    const share = String(content).includes(marker) ? 0.5 : 1;
    return Math.max(1, Math.round((words * share) / 220));
  });

  const slug = (text) =>
    text
      .replace(/<[^>]+>/g, "")
      .normalize("NFD")
      .replace(/[̀-ͯ]/g, "")
      .toLowerCase()
      .replace(/&[a-z]+;/g, "")
      .replace(/[^a-z0-9]+/g, "-")
      .replace(/^-|-$/g, "");

  const split = (content) => {
    const html = String(content);
    const at = html.indexOf('<div data-l="en">');
    return at < 0 ? { es: html, en: "" } : { es: html.slice(0, at), en: html.slice(at) };
  };

  const headings = (html, lang) =>
    [...html.matchAll(/<h2>(.*?)<\/h2>/g)].map((m) => ({ id: `${lang}-${slug(m[1])}`, text: m[1].replace(/<[^>]+>/g, "") }));

  config.addFilter("toc", (content, lang) => headings(split(content)[lang], lang));

  config.addFilter("withIds", (content) => {
    const { es, en } = split(content);
    const tag = (html, lang) => html.replace(/<h2>(.*?)<\/h2>/g, (_, inner) => `<h2 id="${lang}-${slug(inner)}">${inner}</h2>`);
    return tag(es, "es") + tag(en, "en");
  });

  config.addFilter("short", (date, lang = "es") =>
    new Intl.DateTimeFormat(locales[lang], { day: "numeric", month: "short", year: "numeric", timeZone: "UTC" }).format(date),
  );

  config.addCollection("posts", (api) =>
    api.getFilteredByGlob("blog/posts/*.md").sort((a, b) => b.date - a.date || (b.data.order ?? 0) - (a.data.order ?? 0)),
  );

  return {
    dir: { input: ".", includes: "_includes", data: "_data", output: "_site" },
    pathPrefix: "/GymMane/",
    markdownTemplateEngine: "njk",
    htmlTemplateEngine: "njk",
  };
}
