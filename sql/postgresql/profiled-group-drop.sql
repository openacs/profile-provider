--
-- Groups that implement the profile provider interface
--
-- @author <a href="mailto:yon@milliped.com">yon@milliped.com</a>
-- @version $Id$
--

drop function profiled_group__new(integer,integer,varchar,varchar,varchar,varchar,varchar,timestamptz,integer,varchar);

drop function profiled_group__delete(integer);

select acs_object_type__drop_type('profiled_group');

drop table profiled_groups;
