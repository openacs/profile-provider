--
-- Groups that implement the profile provider interface
--
-- @author <a href="mailto:yon@milliped.com">yon@milliped.com</a>
-- @version $Id$
--

create table profiled_groups (
    group_id                    constraint pg_group_id_fk
                                references groups (group_id)
                                constraint profiled_groups_pk
                                primary key,
    profile_provider            constraint pg_profile_provider_fk
                                references acs_sc_impls (impl_id)
                                constraint pg_profile_provider_nn
                                not null
);

declare
begin
    acs_object_type.create_type(
        object_type => 'profiled_group',
        supertype => 'group',
        pretty_name => 'Profiled Group',
        pretty_plural => 'Profiled Groups',
        table_name => 'profiled_groups',
        id_column => 'group_id',
        package_name => 'profiled_group',
        type_extension_table => '',
        name_method => 'acs_group.name'
    );
end;
/
show errors

create or replace package profiled_group
as
    function new (
        group_id in profiled_groups.group_id%TYPE default null,
        profile_provider in profiled_groups.profile_provider%TYPE,
        group_name in groups.group_name%TYPE,
        join_policy in groups.join_policy%TYPE default null,
        email in parties.email%TYPE default null,
        url in parties.url%TYPE default null,
        object_type in acs_objects.object_type%TYPE default 'profiled_group',
        creation_date in acs_objects.creation_date%TYPE default sysdate,
        creation_user in acs_objects.creation_user%TYPE default null,
        creation_ip in acs_objects.creation_ip%TYPE default null
    ) return profiled_groups.group_id%TYPE;

    procedure delete (
        group_id in profiled_groups.group_id%TYPE
    );
end profiled_group;
/
show errors
create or replace package body profiled_group
as
    function new (
        group_id in profiled_groups.group_id%TYPE default null,
        profile_provider in profiled_groups.profile_provider%TYPE,
        group_name in groups.group_name%TYPE,
        join_policy in groups.join_policy%TYPE default null,
        email in parties.email%TYPE default null,
        url in parties.url%TYPE default null,
        object_type in acs_objects.object_type%TYPE default 'profiled_group',
        creation_date in acs_objects.creation_date%TYPE default sysdate,
        creation_user in acs_objects.creation_user%TYPE default null,
        creation_ip in acs_objects.creation_ip%TYPE default null
    ) return profiled_groups.group_id%TYPE is
        v_group_id profiled_groups.group_id%TYPE;
    begin
        v_group_id := acs_group.new(
            group_id => profiled_group.new.group_id,
            group_name => profiled_group.new.group_name,
            join_policy => profiled_group.new.join_policy,
            email => profiled_group.new.email,
            url => profiled_group.new.url,
            object_type => profiled_group.new.object_type,
            creation_date => profiled_group.new.creation_date,
            creation_user => profiled_group.new.creation_user,
            creation_ip => profiled_group.new.creation_ip
        );

        insert
        into profiled_groups
        (group_id, profile_provider)
        values
        (v_group_id, profiled_group.new.profile_provider);

        return v_group_id;
    end new;

    procedure delete (
        group_id in profiled_groups.group_id%TYPE
    ) is
    begin
        delete
        from profiled_groups
        where profiled_groups.group_id = profiled_group.delete.group_id;

        acs_group.delete(group_id);
    end delete;
end profiled_group;
/
show errors
