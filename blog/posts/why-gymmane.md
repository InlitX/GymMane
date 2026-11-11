---
date: 2026-11-11
order: 1
tag_es: La historia
tag_en: The story
title_es: Por qué existe GymMane
title_en: Why GymMane exists
desc_es: Usaba apps de gimnasio, pero lo útil estaba detrás de una suscripción, el diseño no enamoraba y mis datos acababan quién sabe dónde. Así que hice la mía.
desc_en: I used gym apps, but the useful parts were behind a subscription, the design didn't win me over and my data ended up who knows where. So I made my own.
---

<div data-l="es">

## Empecé con otras apps

Durante años apunté mis entrenos con apps de gimnasio. Al principio, la versión gratis me bastaba. Pero cuanto más tiempo pasaba, más echaba en falta funciones que te facilitan la vida, y siempre estaban detrás de un muro de pago.

Lo malo no es pagar. Lo malo es pagar cada mes por algo que tampoco estaba tan cuidado: apps sin un diseño que te atrape, que se notaban hechas con prisa. Y cuando por fin encontraba una bonita, con detalle y con un diseño cuidado, la ilusión duraba poco: casi todo lo que veías había que pagarlo para usarlo. Algunas ni siquiera tenían versión gratis.

Luego estaba la privacidad. Sé que puede sonar exagerado, y sé que desde el momento en que uso un móvil ya estoy dando datos personales. No me libro de eso. Pero no quiero que estén expuestos del todo; quiero, al menos, reducirlo al mínimo. Y en ese texto de privacidad que nadie lee aparecía siempre lo mismo: tus datos se usan «para mejorar la calidad del servicio», se comparten con otras empresas y, si no quieres, mandas un correo y esperas. Un lío del que ya estaba harto.

## Las alternativas de código abierto

Así que me pasé al código abierto, y usé esas apps durante mucho tiempo. Les estoy muy agradecido. Pero les faltaba algo que a mí me importa más de lo que parece: el diseño.

Soy joven, y que algo sea bonito me anima. Me hace más constante y me da más ganas de abrir la app y de ir a entrenar. Creo que a mucha gente le pasa lo mismo. Entiendo que esas apps las hacen programadores, no diseñadores, pero era justo lo que les faltaba.

## Y salió GymMane

Lo que quería era sencillo: una app que no me hiciera pagar por lo que necesito, que no mandara mis datos a ningún sitio y que diera gusto usar. No la encontré, así que la hice.

Durante mucho tiempo GymMane fue solo para mí. Al final pensé que, si a mí me había sido útil, seguro que a otros también.

## Lo que hace distinto a GymMane

<div class="facts">
<div class="fact"><b>0 €</b><span>Sin versión de pago, sin suscripción, sin nada bloqueado.</span></div>
<div class="fact"><b>0 cuentas</b><span>Abres la app y empiezas. No hay nada que registrar.</span></div>
<div class="fact"><b>0 conexiones</b><span>La app no tiene permiso de internet. No puede enviar nada.</span></div>
</div>

Lo último es lo que más me importa. GymMane **no pide el permiso de internet** en Android. No es una promesa en una política de privacidad: es una limitación del sistema. Aunque quisiera mandar tus datos a algún sitio, el móvil no la dejaría. Puedes comprobarlo tú mismo en el manifiesto, porque el código es abierto (GPL-3.0). La publico en GitHub y la tienes también en tiendas de código abierto como F-Droid o IzzyOnDroid.

Y eso no la hace pobre en funciones. Dentro tiene:

- **Un mapa del cuerpo**: tocas los músculos que quieres entrenar y te prepara la sesión.
- **Cientos de ejercicios con animación** e instrucciones, y los tuyos con foto, GIF o vídeo.
- **Progresión automática**: te dice cuándo subir peso o repeticiones, avisa si te estancas y programa semanas de descarga.
- **Un temporizador de descanso que suena de verdad**, con la cuenta atrás en la notificación y la pantalla apagada.
- **Récords, 1RM estimado, volumen, rachas** que aguantan tus días libres y un resumen del mes para compartir.
- **Medidas y fotos de progreso** con antes y después.
- **Nutrición (beta)**: calorías, macros, agua, suplementos, planes y ayuno.
- **Widgets, calculadoras, diario con notas** y 22 idiomas.

Y si vienes de otra app, GymMane importa tu historial de Hevy, Strong, Lyfta, FitNotes, openGym o cualquier CSV. Si algún día te quieres ir, te llevas todo en CSV o en una copia completa. Tus datos no son el precio de nada.

## Lo que le falta (y por qué)

Prefiero ser honesto con esto, porque cada cosa que falta tiene un motivo.

**No hay sincronización en la nube.** Sincronizar con una nube necesita internet y una cuenta, y eso es justo lo que GymMane no quiere ser. A cambio, la app hace copias automáticas en una carpeta, y esa carpeta la puedes sincronizar con [Syncthing](https://syncthing.net) o con la herramienta que prefieras, de tu móvil a tu ordenador sin pasar por servidores de nadie. Y si tienes un ordenador en casa, puedes montar la versión web en tu propio servidor: lo explico en [este post](/blog/how-its-made/).

**No hay red social ni rankings.** Comparar tu press de banca con el de desconocidos no te hace entrenar mejor, y montar algo así obligaría a subir tus datos a algún sitio. Si quieres enseñar tu progreso, puedes compartir el resumen del mes o una tarjeta de tu entreno como imagen, cuando tú quieras.

**No hay un entrenador con IA dentro.** Una IA de verdad necesita conexión. Lo que sí hay es un atajo: GymMane te prepara el texto para pedirle una rutina o un plan de comidas a la IA que tú uses, y luego pegas la respuesta. La app nunca habla con nadie; tú decides qué copias y dónde.

**No hay una base de datos de alimentos online.** Las grandes bases de comida viven en internet. GymMane trae una biblioteca de alimentos dentro y te deja crear los tuyos y guardar tus comidas.

**En el móvil, solo Android.** Es donde puedo garantizar todo lo anterior. En el ordenador ya puedes usarla en el navegador si la montas en tu propio servidor. Lo demás llegará cuando pueda hacerlo igual de bien.

## Hecha por alguien que entrena

GymMane la hago yo, InlitX, en mi tiempo libre. La uso cada día que entreno, así que cada cosa que tiene la he necesitado en algún momento con la barra en la mano. Por eso los botones son grandes, el temporizador no se calla y no hay nada que te distraiga entre serie y serie.

Si te ayuda a entrenar, me alegra de verdad. Y si le falta algo, me lo puedes decir en [GitHub](https://github.com/InlitX/GymMane/issues): muchas de las cosas que tiene hoy empezaron siendo una sugerencia de alguien.

</div>

<div data-l="en">

## I started with other apps

For years I logged my workouts with gym apps. At first, the free version was enough. But the more time went by, the more I missed features that make your life easier, and they were always behind a paywall.

Paying isn't the problem. The problem is paying every month for something that wasn't that polished either: apps without a design that draws you in, that felt made in a hurry. And when I finally found a beautiful one, with care and a thoughtful design, the excitement didn't last: almost everything you saw had to be paid for. Some didn't even have a free version.

Then there was privacy. I know it can sound over the top, and I know that from the moment I use a phone I'm already giving away personal data. I don't escape that. But I don't want it fully exposed; I want, at least, to keep it to a minimum. And that privacy text nobody reads always said the same thing: your data is used "to improve the quality of the service", it's shared with other companies and, if you don't want that, you send an email and wait. A mess I was tired of.

## The open source alternatives

So I moved to open source, and I used those apps for a long time. I'm really grateful to them. But they were missing something that matters to me more than it seems: design.

I'm young, and something being beautiful motivates me. It keeps me consistent and makes me want to open the app and go train. I think a lot of people feel the same. I understand those apps are made by programmers, not designers, but it was exactly what they were missing.

## And GymMane came out of it

What I wanted was simple: an app that didn't make me pay for what I need, that didn't send my data anywhere and that was a pleasure to use. I couldn't find it, so I made it.

For a long time GymMane was just for me. In the end I thought that if it had been useful to me, it would surely be useful to others too.

## What makes GymMane different

<div class="facts">
<div class="fact"><b>$0</b><span>No paid version, no subscription, nothing locked.</span></div>
<div class="fact"><b>0 accounts</b><span>Open the app and start. There's nothing to sign up for.</span></div>
<div class="fact"><b>0 connections</b><span>The app has no internet permission. It can't send anything.</span></div>
</div>

That last one matters most to me. GymMane **doesn't ask for the internet permission** on Android. It isn't a promise in a privacy policy: it's a limit enforced by the system. Even if it wanted to send your data somewhere, the phone wouldn't let it. You can check it yourself in the manifest, because the code is open (GPL-3.0). I publish it on GitHub, and you can also get it from open source stores like F-Droid or IzzyOnDroid.

And that doesn't make it short on features. Inside you'll find:

- **A body map**: tap the muscles you want to train and it builds the session.
- **Hundreds of animated exercises** with instructions, plus your own with a photo, GIF or video.
- **Automatic progression**: it tells you when to add weight or reps, warns you when you stall and plans deload weeks.
- **A rest timer that actually rings**, with the countdown in the notification and the screen off.
- **Records, estimated 1RM, volume, streaks** that survive your rest days and a monthly recap to share.
- **Body measurements and progress photos** with before and after.
- **Nutrition (beta)**: calories, macros, water, supplements, meal plans and fasting.
- **Widgets, calculators, a journal with notes** and 22 languages.

If you're coming from another app, GymMane imports your history from Hevy, Strong, Lyfta, FitNotes, openGym or any CSV. If you ever want to leave, you take everything with you as CSV or a full backup. Your data isn't the price of anything.

## What it doesn't have (and why)

I'd rather be honest about this, because every missing piece has a reason.

**No cloud sync.** Syncing to a cloud needs the internet and an account, and that's exactly what GymMane doesn't want to be. Instead, the app saves automatic backups to a folder, and you can sync that folder with [Syncthing](https://syncthing.net) or whichever tool you prefer, from your phone to your computer without touching anyone's servers. And if you have a computer at home, you can run the web version on your own server: I explain it in [this post](/blog/how-its-made/).

**No social feed or leaderboards.** Comparing your bench press with strangers doesn't make you train better, and building that would mean uploading your data somewhere. If you want to show your progress, you can share your monthly recap or a workout card as an image, whenever you choose.

**No built-in AI coach.** A real AI needs a connection. What there is instead is a shortcut: GymMane writes the request for you to ask the AI you already use for a routine or a meal plan, and then you paste the answer back. The app never talks to anyone; you decide what you copy and where.

**No online food database.** The big food databases live on the internet. GymMane ships with a food library inside and lets you add your own foods and save your meals.

**On phones, Android only.** It's where I can guarantee everything above. On a computer you can already use it in the browser if you run it on your own server. The rest will come when I can do it just as well.

## Made by someone who trains

I'm InlitX and I make GymMane in my free time. I use it every day I train, so everything in it is something I once needed with the bar in my hands. That's why the buttons are big, the timer doesn't keep quiet and nothing distracts you between sets.

If it helps you train, that genuinely makes me happy. And if something's missing, tell me on [GitHub](https://github.com/InlitX/GymMane/issues): a lot of what it has today started as somebody's suggestion.

</div>
