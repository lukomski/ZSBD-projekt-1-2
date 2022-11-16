create or replace function update_users() returns trigger as $$
    declare
        description text = 'Name changed from ' || old.name || ' to ' || new.name;
    begin
    insert into users_history( date, user_id, description) values (now(), old.id, description);
    return NEW;
    end;
$$ language plpgsql;

drop trigger if exists log_users_update on users;
create trigger log_users_update
    after update on users
    FOR EACH ROW
    WHEN (OLD.* IS DISTINCT FROM NEW.*)
    EXECUTE FUNCTION update_users();
