---
date: 2026-11-11
order: 1
tag_es: La historia
tag_en: The story
title_es: Por qué existe GymMane
title_en: Why GymMane exists
desc_es: Quería apuntar mis series sin crear una cuenta, sin anuncios y sin pagar cada mes por ver mis propios números. No encontré esa app, así que la hice.
desc_en: I wanted to log my sets without making an account, without ads and without paying every month to see my own numbers. I couldn't find that app, so I made it.
---

<div data-l="es">

## Empezó con una libreta

Durante años apunté mis entrenos en una libreta. Funcionaba, pero no me decía nada: no sabía si estaba subiendo de verdad, cuándo había sido mi mejor serie de sentadilla ni si llevaba tres semanas atascado en el press de banca.

Así que hice lo normal y probé apps. Casi todas me pedían lo mismo antes de dejarme apuntar una sola serie: **crear una cuenta**. Luego venían los anuncios entre series, las gráficas bloqueadas detrás de una suscripción y, mirando los permisos, un montón de datos que salían de mi móvil hacia servidores que no conocía.

Lo que yo quería era muy simple: abrir la app, apuntar lo que levanto y ver cómo mejoro. No necesitaba una red social ni un plan premium. Necesitaba un diario de gimnasio que fuera mío.

No lo encontré. Así que lo hice.

## Lo que hace distinto a GymMane

<div class="facts">
<div class="fact"><b>0 €</b><span>Sin versión de pago, sin suscripción, sin nada bloqueado.</span></div>
<div class="fact"><b>0 cuentas</b><span>Abres la app y empiezas. No hay nada que registrar.</span></div>
<div class="fact"><b>0 conexiones</b><span>La app no tiene permiso de internet. No puede enviar nada.</span></div>
</div>

Lo último es lo que más me importa. GymMane **no pide el permiso de internet** en Android. No es una promesa en una política de privacidad: es una limitación del sistema. Aunque quisiera mandar tus datos a algún sitio, el móvil no la dejaría. Puedes comprobarlo tú mismo en el manifiesto del código, que es abierto (GPL-3.0), y F-Droid la compila directamente desde ese código.

Y eso no la hace pobre en funciones. Dentro tiene:

- **Un mapa del cuerpo**: tocas los músculos que quieres entrenar y te prepara la sesión.
- **Cientos de ejercicios con animación** e instrucciones, y los tuyos con foto, GIF o vídeo.
- **Progresión automática**: te dice cuándo subir peso o repeticiones, avisa si te estancas y programa semanas de descarga.
- **Un temporizador de descanso que suena de verdad**, con la cuenta atrás en la notificación y la pantalla apagada.
- **Récords, 1RM estimado, volumen, rachas** que aguantan tus días libres y un resumen del mes para compartir.
- **Medidas y fotos de progreso** con antes y después.
- **Nutrición (beta)**: calorías, macros, agua, suplementos, planes y ayuno.
- **Widgets, calculadoras, diario con notas** y 17 idiomas.

Y si vienes de otra app, GymMane importa tu historial de Hevy, Strong, Lyfta, FitNotes, openGym o cualquier CSV. Si algún día te quieres ir, te llevas todo en CSV o en una copia completa. Tus datos no son el precio de nada.

## Lo que le falta (y por qué)

Prefiero ser honesto con esto, porque cada cosa que falta tiene un motivo.

**No hay sincronización en la nube.** Sincronizar con una nube necesita internet y una cuenta, y eso es justo lo que GymMane no quiere ser. A cambio, puedes hacer copias automáticas en una carpeta y sincronizarla con [Syncthing](https://syncthing.net), que va de tu móvil a tu ordenador sin pasar por servidores de nadie. Y si tienes un ordenador en casa, puedes montar la versión web en tu propio servidor (lo cuento en el [siguiente post](/blog/how-its-made/)).

**No hay red social ni rankings.** Comparar tu press de banca con el de desconocidos no te hace entrenar mejor, y montar algo así obligaría a subir tus datos a algún sitio. Si quieres enseñar tu progreso, puedes compartir el resumen del mes o una tarjeta de tu entreno como imagen, cuando tú quieras.

**No hay un entrenador con IA dentro.** Una IA de verdad necesita conexión. Lo que sí hay es un atajo: GymMane te prepara el texto para pedirle una rutina o un plan de comidas a la IA que tú uses, y luego pegas la respuesta. La app nunca habla con nadie; tú decides qué copias y dónde.

**No hay una base de datos de alimentos online.** Las grandes bases de comida viven en internet. GymMane trae una biblioteca de alimentos dentro y te deja crear los tuyos y guardar tus comidas.

**De momento, solo Android.** Es donde puedo garantizar todo lo anterior y donde F-Droid la compila desde el código. Lo demás llegará cuando pueda hacerlo igual de bien.

## Hecha por alguien que entrena

GymMane la hago yo, InlitX, en mi tiempo libre. La uso cada día que entreno, así que cada cosa que tiene la he necesitado en algún momento con la barra en la mano. Por eso los botones son grandes, el temporizador no se calla y no hay nada que te distraiga entre serie y serie.

Si te ayuda a entrenar, me alegra de verdad. Y si le falta algo, me lo puedes decir en [GitHub](https://github.com/InlitX/GymMane/issues): muchas de las cosas que tiene hoy empezaron siendo una sugerencia de alguien.

</div>

<div data-l="en">

## It started with a notebook

For years I logged my workouts in a notebook. It worked, but it told me nothing: I didn't know if I was really getting stronger, when my best squat set had been, or whether I'd been stuck on the bench press for three weeks.

So I did the normal thing and tried apps. Almost all of them asked for the same thing before I could log a single set: **make an account**. Then came the ads between sets, the charts locked behind a subscription and, looking at the permissions, a lot of data leaving my phone for servers I didn't know.

What I wanted was very simple: open the app, write down what I lift and see myself get better. I didn't need a social network or a premium plan. I needed a gym log that was mine.

I couldn't find it. So I made it.

## What makes GymMane different

<div class="facts">
<div class="fact"><b>$0</b><span>No paid version, no subscription, nothing locked.</span></div>
<div class="fact"><b>0 accounts</b><span>Open the app and start. There's nothing to sign up for.</span></div>
<div class="fact"><b>0 connections</b><span>The app has no internet permission. It can't send anything.</span></div>
</div>

That last one matters most to me. GymMane **doesn't ask for the internet permission** on Android. It isn't a promise in a privacy policy: it's a limit enforced by the system. Even if it wanted to send your data somewhere, the phone wouldn't let it. You can check it yourself in the manifest of the source code, which is open (GPL-3.0), and F-Droid builds the app straight from that code.

And that doesn't make it short on features. Inside you'll find:

- **A body map**: tap the muscles you want to train and it builds the session.
- **Hundreds of animated exercises** with instructions, plus your own with a photo, GIF or video.
- **Automatic progression**: it tells you when to add weight or reps, warns you when you stall and plans deload weeks.
- **A rest timer that actually rings**, with the countdown in the notification and the screen off.
- **Records, estimated 1RM, volume, streaks** that survive your rest days and a monthly recap to share.
- **Body measurements and progress photos** with before and after.
- **Nutrition (beta)**: calories, macros, water, supplements, meal plans and fasting.
- **Widgets, calculators, a journal with notes** and 17 languages.

If you're coming from another app, GymMane imports your history from Hevy, Strong, Lyfta, FitNotes, openGym or any CSV. If you ever want to leave, you take everything with you as CSV or a full backup. Your data isn't the price of anything.

## What it doesn't have (and why)

I'd rather be honest about this, because every missing piece has a reason.

**No cloud sync.** Syncing to a cloud needs the internet and an account, and that's exactly what GymMane doesn't want to be. Instead, you can save automatic backups to a folder and sync it with [Syncthing](https://syncthing.net), which goes from your phone to your computer without touching anyone's servers. And if you have a computer at home, you can run the web version on your own server (I explain it in the [next post](/blog/how-its-made/)).

**No social feed or leaderboards.** Comparing your bench press with strangers doesn't make you train better, and building that would mean uploading your data somewhere. If you want to show your progress, you can share your monthly recap or a workout card as an image, whenever you choose.

**No built-in AI coach.** A real AI needs a connection. What there is instead is a shortcut: GymMane writes the request for you to ask the AI you already use for a routine or a meal plan, and then you paste the answer back. The app never talks to anyone; you decide what you copy and where.

**No online food database.** The big food databases live on the internet. GymMane ships with a food library inside and lets you add your own foods and save your meals.

**Android only, for now.** It's where I can guarantee everything above and where F-Droid builds it from source. The rest will come when I can do it just as well.

## Made by someone who trains

I'm InlitX and I make GymMane in my free time. I use it every day I train, so everything in it is something I once needed with the bar in my hands. That's why the buttons are big, the timer doesn't keep quiet and nothing distracts you between sets.

If it helps you train, that genuinely makes me happy. And if something's missing, tell me on [GitHub](https://github.com/InlitX/GymMane/issues): a lot of what it has today started as somebody's suggestion.

</div>
