--
-- Groups that implement the profile provider interface
--
-- @author <a href="mailto:yon@milliped.com">yon@milliped.com</a>
-- @version $Id$
--

create table profiled_groups (
    group_id                    integer
				constraint pg_group_id_fk
                                references groups (group_id)
                                constraint profiled_groups_pk
                                primary key,
    profile_provider            integer
				constraint pg_profile_provider_fk
                                references acs_sc_impls (impl_id)
                                constraint pg_profile_provider_nn
                                not null
);

select acs_object_type__create_type(
        'profiled_group',
        'Profiled Group',
        'Profiled Groups',
        'group',
        'profiled_groups',
        'group_id',
        'profiled_group',
	'f',
        NULL,
        'acs_group.name'
);


select define_function_args ('profiled_group__new','group_id,profile_provider,group_name,join_policy,email,url,object_type;profiled_group,creation_date,creation_user,creation_ip');

create function profiled_group__new(integer,integer,varchar,varchar,varchar,varchar,varchar,timestamp,integer,varchar)
returns integer as '
DECLARE
	p_group_id		alias for $1;
	p_profile_provider	alias for $2;
	p_group_name		alias for $3;
	p_join_policy		alias for $4;
	p_email			alias for $5;
	p_url			alias for $6;
	p_object_type		alias for $7;
	p_creation_date		alias for $8;
	p_creation_user		alias for $9;
	p_creation_ip		alias for $10;
	v_group_id		integer;
BEGIN
        v_group_id := acs_group__new(
            p_group_id,
	    p_object_type,
	    p_creation_date,
	    p_creation_user,
	    p_creation_ip,
	    p_email,
	    p_url,
	    p_group_name,
	    p_join_policy,
	    NULL
        );
	
        insert
        into profiled_groups
        (group_id, profile_provider)
        values
        (v_group_id, p_profile_provider);

	return v_group_id;
END;
' language 'plpgsql';


create function profiled_group__new(integer, varchar)
returns integer as '
DECLARE
	p_profile_provider		alias for $1;
	p_group_name			alias for $2;
BEGIN
	return profiled_group__new(
	       NULL,
	       p_profile_provider,
	       p_group_name,
	       NULL,
	       NULL,
	       NULL,
	       ''profiled_group'',
	       now(),
	       NULL,
	       NULL
	);
END;
' language 'plpgsql';


select define_function_args('profiled_group__delete','group_id');

create function profiled_group__delete(integer)
returns integer as '
DECLARE
	p_group_id		alias for $1;
BEGIN
        delete
        from profiled_groups
        where profiled_groups.group_id = p_group_id;

	perform acs_group__delete(p_group_id);

	return 0;
END;
' language 'plpgsql';

