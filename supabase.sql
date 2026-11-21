-- MANOS A SALVO: tabla de experiencias
-- Copia todo este archivo en Supabase > SQL Editor > New query y presiona "Run".
-- Crea la tabla y permite que cualquier visitante LEA e INSERTE comentarios,
-- pero nadie puede editarlos ni borrarlos desde la página (solo tú desde Supabase).

create table if not exists public.experiencias (
  id           uuid primary key default gen_random_uuid(),
  created_at   timestamptz not null default now(),
  nombre       text not null default 'Anónimo' check (char_length(nombre) between 1 and 60),
  area         text not null check (char_length(area) between 1 and 40),
  calificacion smallint not null check (calificacion between 1 and 5),
  comentario   text not null check (char_length(comentario) between 5 and 600),
  compromisos  jsonb not null default '[]'::jsonb check (jsonb_typeof(compromisos) = 'array'),
  aciertos     smallint not null default 0 check (aciertos between 0 and 3)
);

alter table public.experiencias enable row level security;

drop policy if exists "Leer experiencias" on public.experiencias;
create policy "Leer experiencias" on public.experiencias
  for select to anon, authenticated using (true);

drop policy if exists "Agregar experiencias" on public.experiencias;
create policy "Agregar experiencias" on public.experiencias
  for insert to anon, authenticated with check (true);

-- Sin políticas de update ni delete: desde la página no se puede modificar ni borrar.
grant select, insert on public.experiencias to anon, authenticated;

-- (Opcional) Para moderar: Supabase > Table Editor > experiencias > selecciona la fila > Delete.
