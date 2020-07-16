// generated from rosidl_generator_swift/resource/idl.swift.em
// with input from @(package_name):@(interface_path)
// generated code does not contain a copyright notice
@
@#######################################################################
@# EmPy template for generating <idl>.cs files
@#
@# Context:
@#  - package_name (string)
@#  - interface_path (Path relative to the directory named after the package)
@#  - content (IdlContent, list of elements, e.g. Messages or Services)
@#######################################################################
@
@
@#######################################################################
@# Handle messages
@#######################################################################
@{
from rosidl_parser.definition import Message
}@
@[for message in content.get_elements_of_type(Message)]@
@{
TEMPLATE(
    'msg.swift.em',
    package_name=package_name, interface_path=interface_path, message=message)
}@
@[end for]@
@
@#######################################################################
@# Handle services
@#######################################################################
@
@#TODO - services not implemented
@
@
@#######################################################################
@# Handle actions
@#######################################################################
@
@#TODO - actions not implemented
@