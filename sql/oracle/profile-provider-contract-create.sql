--
-- Profile Provider interface definition
--
-- @author <a href="mailto:yon@openforce.net">yon@openforce.net</a>
-- @version $Id$
--

declare
    foo                         integer;
begin

    -- create the interface
    foo := acs_sc_contract.new(
        contract_name => 'profile_provider',
        contract_desc => 'profile provider interface definition'
    );

    -- create the methods of this interface

    -- name method
    foo := acs_sc_msg_type.new(
        msg_type_name => 'profile_provider.name.InputType',
        msg_type_spec => ''
    );

    foo := acs_sc_msg_type.new(
        msg_type_name => 'profile_provider.name.OutputType',
        msg_type_spec => 'name:string'
    );

    foo := acs_sc_operation.new(
        contract_name => 'profile_provider',
        operation_name => 'name',
        operation_desc => 'return the name of the profile provider',
        operation_iscachable_p => 't',
        operation_nargs => 0,
        operation_inputtype => 'profile_provider.name.InputType',
        operation_outputtype => 'profile_provider.name.OutputType'
    );

    -- prettyName method
    foo := acs_sc_msg_type.new(
        msg_type_name => 'profile_provider.prettyName.InputType',
        msg_type_spec => ''
    );

    foo := acs_sc_msg_type.new(
        msg_type_name => 'profile_provider.prettyName.OutputType',
        msg_type_spec => 'prettyName:string'
    );

    foo := acs_sc_operation.new(
        contract_name => 'profile_provider',
        operation_name => 'prettyName',
        operation_desc => 'return the pretty name of the profile provider',
        operation_iscachable_p => 't',
        operation_nargs => 0,
        operation_inputtype => 'profile_provider.prettyName.InputType',
        operation_outputtype => 'profile_provider.prettyName.OutputType'
    );

    -- render method
    foo := acs_sc_msg_type.new(
        msg_type_name => 'profile_provider.render.InputType',
        msg_type_spec => ''
    );

    foo := acs_sc_msg_type.new(
        msg_type_name => 'profile_provider.render.OutputType',
        msg_type_spec => 'output:string'
    );

    foo := acs_sc_operation.new(
        contract_name => 'profile_provider',
        operation_name => 'render',
        operation_desc => 'output the HTML from this profile provider',
        operation_iscachable_p => 't',
        operation_nargs => 0,
        operation_inputtype => 'profile_provider.render.InputType',
        operation_outputtype => 'profile_provider.render.OutputType'
    );

end;
/
show errors
