# Cómo publicar Manos a Salvo en internet (gratis)

Las piezas son tres: **Supabase** guarda los comentarios, **GitHub** guarda los archivos y **Cloudflare Pages** publica la página.
Tiempo estimado: 30 a 40 minutos. No necesitas programar.

## Archivos de esta carpeta

| Archivo | Para qué sirve |
|---|---|
| `index.html` | El simulador completo |
| `config.js` | **El único archivo que editas:** ahí pegas la URL y la clave de Supabase |
| `vendor/three.min.js` | Motor 3D (no lo toques) |
| `supabase.sql` | Crea la tabla de comentarios en Supabase |
| `GUIA.md` | Esta guía |

---

## Parte 1. Supabase (la base de datos de comentarios)

1. Entra a **supabase.com** y da clic en **Start your project**. Regístrate (puedes usar tu cuenta de GitHub).
2. Da clic en **New project**:
   - Nombre: `manos-a-salvo`
   - Database password: crea una y guárdala (no la vas a pegar en ningún archivo).
   - Region: la más cercana a tu planta.
   - Plan: **Free**.
3. Espera 1 o 2 minutos a que el proyecto termine de crearse.
4. En el menú izquierdo abre **SQL Editor** > **New query**. Copia todo el contenido de `supabase.sql`, pégalo y presiona **Run**. Debe decir *Success*.
5. Verifica en **Table Editor** que aparece la tabla `experiencias` (vacía).
6. Ve a **Project Settings** > **API** (en algunas cuentas se llama **Data API** o **API Keys**) y copia dos datos:
   - **Project URL** (algo como `https://abcd1234.supabase.co`)
   - La clave **anon public** (pestaña *Legacy API keys*) o la **Publishable key** (empieza con `sb_publishable_`). Cualquiera de las dos funciona.
7. Abre `config.js` con el Bloc de notas y reemplaza los dos textos `PEGA_AQUI_...` con esos datos. Conserva las comillas. Guarda.

> ⚠️ Nunca pegues la clave **service_role** / **secret** ni la contraseña de la base de datos. La clave *anon* o *publishable* sí es pública por diseño: las reglas del archivo SQL solo permiten leer y agregar comentarios, nunca borrar ni modificar.

## Parte 2. GitHub (donde viven los archivos)

1. Entra a **github.com** y crea tu cuenta (o inicia sesión).
2. Arriba a la derecha: **+** > **New repository**.
   - Repository name: `manos-a-salvo`
   - Puede ser **Public** o **Private** (Cloudflare funciona con ambos).
   - Da clic en **Create repository**.
3. En la página del repositorio nuevo da clic en el enlace **uploading an existing file**.
4. Arrastra **todo el contenido** de esta carpeta: `index.html`, `config.js` (ya editado), `supabase.sql`, `GUIA.md` y la carpeta **`vendor`** completa.
   - Revisa que en la lista aparezca `vendor/three.min.js`. Si tu navegador no deja arrastrar carpetas, usa Chrome o Edge.
5. Abajo, da clic en **Commit changes**.

## Parte 3. Cloudflare Pages (la publicación)

1. Entra a **dash.cloudflare.com** y crea tu cuenta gratuita.
2. En el menú izquierdo: **Workers & Pages** (en algunas cuentas está dentro de **Compute**) > **Create**.
3. Elige la pestaña **Pages** (si solo ves Workers, busca el enlace *Looking to deploy Pages? Get started*) > **Connect to Git** (o *Import an existing Git repository*).
4. Autoriza a Cloudflare a ver tu GitHub y selecciona el repositorio `manos-a-salvo`. Da clic en **Begin setup**.
5. Configuración de compilación:
   - Framework preset: **None**
   - Build command: **déjalo vacío**
   - Build output directory: **déjalo vacío** (o escribe `/`)
6. Da clic en **Save and Deploy**. En uno o dos minutos te da una dirección como **`https://manos-a-salvo.pages.dev`**.

**Plan B sin GitHub:** en el paso 3 elige **Upload assets** (subir archivos directamente), arrastra la carpeta completa y publica. Es más rápido, pero cada cambio tienes que volver a subirlo a mano.

## Parte 4. Probar y compartir

1. Abre tu dirección `.pages.dev` en PC y en celular. Haz el recorrido completo y deja una experiencia de prueba.
2. En el muro debe decir: *"Las experiencias se guardan en línea..."*. Si dice *"Modo de prueba"*, revisa `config.js`.
3. En Supabase > **Table Editor** > `experiencias` debe aparecer tu comentario. Bórralo si fue solo una prueba (selecciónalo > **Delete**).
4. Para la planta: genera un **código QR** de la dirección (en Chrome: clic derecho en la página > *Crear código QR*) e imprímelo en el área de capacitación o en los comedores.

## Cómo hacer cambios después

- Edita el archivo en GitHub (abre el archivo > ícono de lápiz > **Commit changes**). Cloudflare vuelve a publicar solo en uno o dos minutos.
- **Moderar comentarios:** se borran desde Supabase > Table Editor. La página no permite borrar a nadie.
- **Exportar comentarios a Excel:** Supabase > Table Editor > `experiencias` > **Export** > CSV.

## Si algo falla

| Síntoma | Causa probable |
|---|---|
| "Modo de prueba" en el muro | `config.js` sigue con `PEGA_AQUI_...` o le faltan comillas |
| "No se pudo guardar: el servidor respondió 401" | Clave copiada incompleta o es otra clave |
| "...respondió 404" o "relation does not exist" | No se ejecutó `supabase.sql` |
| "...respondió 400" | Comentario demasiado largo o falta un campo |
| La escena 3D no aparece | Falta subir la carpeta `vendor` |
| Supabase pausó el proyecto | Los proyectos gratuitos se pausan tras ~1 semana sin uso; entra a Supabase y da clic en **Restore** |
