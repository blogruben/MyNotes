
create table tags (
  id serial unique,
  updated_at timestamp with time zone,
  name text,
  level int2 not null,
  ordering int4 not null,
  user_id uuid not null,
  sub_tag int8,
  constraint name_length check (char_length(name) > 0),
  constraint level_range check (level >= 0 and level <= 6),
  constraint ordering_range check (ordering >= 0 and ordering <= 20000),
  constraint fk_sub_tag foreign key(sub_tag) references tags(id) on delete set null,
  constraint user_id foreign key(user_id) references auth.users on delete cascade

);

alter table tags
  enable row level security;

create policy "Public profiles are viewable by everyone." on tags
  for select using ((select auth.uid()) = user_id);

create policy "Users can insert their own profile." on tags
  for insert with check ((select auth.uid()) = user_id);

create policy "Users can update own profile." on tags
  for update using ((select auth.uid()) = user_id);

