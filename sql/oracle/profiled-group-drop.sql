--
-- Groups that implement the profile provider interface
--
-- @author <a href="mailto:yon@milliped.com">yon@milliped.com</a>
-- @version $Id$
--

drop package profiled_group;

declare
begin
    acs_object_type.drop_type(
        object_type => 'profiled_group'
    );
end;
/
show errors

drop table profiled_groups;
