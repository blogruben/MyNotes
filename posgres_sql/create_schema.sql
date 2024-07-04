create table tags (
  id bigint generated always as identity primary key,
  updated_at timestamp with time zone,
  name text,
  level int2 not null,
  ordering int4 not null,
  user_id uuid not null default auth.uid(),
  sub_tag int8,
  constraint name_length check (char_length(name) > 0),
  constraint level_range check (level >= 0 and level <= 6),
  constraint ordering_range check (ordering >= 0 and ordering <= 1000),
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

create or replace function check_level()
returns trigger as $$
declare
  sub_level int2;
  sub_user_id uuid;
begin
  if (new.sub_tag is not null) then
    select level,user_id
    into sub_level,sub_user_id
    from tags where tags.id = new.sub_tag;
  end if;
	-- if (new.level <> 1) then
  --   raise exception 'level %', sub_level;
  -- end if;

  -- CHECK LEVEL:
	if (new.sub_tag is null and new.level <> 1) then
	  raise exception 'There is not sub_tag, so the level should be one.';
  end if;
  -- CHECK LEVEL:
  if (new.level <> (sub_level + 1)) then
    raise exception 'The level should be %.', (sub_level + 1);
  end if;
  -- CHECK SUB-TAG
  if (sub_user_id != auth.uid()) then
    raise exception 'The sub_tag that not the correct user_id %', new.sub_tag;
  end if;

	return new;
end;
$$ language plpgsql;

create trigger check_level_on_insert
  after insert on public.tags
  for each row execute procedure public.check_level();



