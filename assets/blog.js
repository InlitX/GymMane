(function () {
  'use strict';

  var lang = null;
  try { lang = localStorage.getItem('gm-lang'); } catch (e) {}
  if (lang !== 'es' && lang !== 'en') {
    lang = (navigator.language || 'es').toLowerCase().indexOf('es') === 0 ? 'es' : 'en';
  }

  var COPY = { es: ['Copiar', 'Copiado'], en: ['Copy', 'Copied'] };

  function apply() {
    var root = document.documentElement;
    root.lang = lang;
    var title = root.getAttribute('data-title-' + lang);
    if (title) document.title = title;
    var desc = root.getAttribute('data-desc-' + lang);
    var meta = document.querySelector('meta[name="description"]');
    if (desc && meta) meta.setAttribute('content', desc);
    document.querySelectorAll('[data-l]').forEach(function (el) {
      el.hidden = el.getAttribute('data-l') !== lang;
    });
    document.querySelectorAll('.lang button').forEach(function (b) {
      b.setAttribute('aria-pressed', String(b.dataset.lang === lang));
    });
    document.querySelectorAll('.copy').forEach(function (b) {
      if (!b.classList.contains('ok')) b.textContent = COPY[lang][0];
    });
  }

  document.querySelectorAll('.lang button').forEach(function (b) {
    b.addEventListener('click', function () {
      lang = b.dataset.lang;
      try { localStorage.setItem('gm-lang', lang); } catch (e) {}
      apply();
    });
  });

  document.querySelectorAll('.prose pre').forEach(function (pre) {
    var btn = document.createElement('button');
    btn.className = 'copy';
    btn.type = 'button';
    btn.addEventListener('click', function () {
      var code = pre.querySelector('code');
      var text = code ? code.textContent : pre.textContent;
      var done = function () {
        btn.classList.add('ok');
        btn.textContent = COPY[lang][1];
        setTimeout(function () { btn.classList.remove('ok'); btn.textContent = COPY[lang][0]; }, 1600);
      };
      if (navigator.clipboard) navigator.clipboard.writeText(text).then(done, function () {});
    });
    var box = document.createElement('div');
    box.className = 'code';
    pre.parentNode.insertBefore(box, pre);
    box.appendChild(pre);
    box.appendChild(btn);
  });

  var y = document.getElementById('y');
  if (y) y.textContent = String(new Date().getFullYear());

  if ('IntersectionObserver' in window) {
    var io = new IntersectionObserver(function (es) {
      es.forEach(function (e) { if (e.isIntersecting) { e.target.classList.add('in'); io.unobserve(e.target); } });
    }, { rootMargin: '0px 0px -8% 0px' });
    document.querySelectorAll('.reveal').forEach(function (el) { io.observe(el); });
  } else {
    document.querySelectorAll('.reveal').forEach(function (el) { el.classList.add('in'); });
  }

  var tocLinks = [].slice.call(document.querySelectorAll('.toc a[href^="#"]:not(.toc__top)'));
  function spy() {
    var current = null;
    tocLinks.forEach(function (a) {
      var h = document.getElementById(a.getAttribute('href').slice(1));
      if (h && h.offsetParent !== null && h.getBoundingClientRect().top < innerHeight * 0.4) current = a;
    });
    tocLinks.forEach(function (a) { a.classList.toggle('on', a === current); });
  }
  if (tocLinks.length) {
    addEventListener('scroll', spy, { passive: true });
    document.querySelectorAll('.lang button').forEach(function (b) { b.addEventListener('click', spy); });
    spy();
  }

  apply();
})();
