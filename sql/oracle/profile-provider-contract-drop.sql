--
-- Profile Provider interface definition
--
-- @author <a href="mailto:yon@openforce.net">yon@openforce.net</a>
-- @version $Id$
--

declare
begin

    -- drop the methods of this interface

    -- name method
    acs_sc_operation.delete(
        contract_name => 'profile_provider',
        operation_name => 'name'
    );

    acs_sc_msg_type.delete(
        msg_type_name => 'profile_provider.name.InputType'
    );

    acs_sc_msg_type.delete(
        msg_type_name => 'profile_provider.name.OutputType'
    );

    -- prettyName method
    acs_sc_operation.delete(
        contract_name => 'profile_provider',
        operation_name => 'prettyName'
    );

    acs_sc_msg_type.delete(
        msg_type_name => 'profile_provider.prettyName.InputType'
    );

    acs_sc_msg_type.delete(
        msg_type_name => 'profile_provider.prettyName.OutputType'
    );

    -- render method
    acs_sc_operation.delete(
        contract_name => 'profile_provider',
        operation_name => 'render'
    );

    acs_sc_msg_type.delete(
        msg_type_name => 'profile_provider.render.InputType'
    );

    acs_sc_msg_type.delete(
        msg_type_name => 'profile_provider.render.OutputType'
    );

    -- create the interface
    acs_sc_contract.delete(
        contract_name => 'profile_provider'
    );

end;
/
show errors
