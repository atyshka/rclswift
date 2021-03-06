@{
from rosidl_parser.definition import AbstractNestedType
from rosidl_parser.definition import AbstractGenericString
from rosidl_parser.definition import AbstractString
from rosidl_parser.definition import AbstractWString
from rosidl_parser.definition import AbstractSequence
from rosidl_parser.definition import Array
from rosidl_parser.definition import BasicType
from rosidl_parser.definition import NamespacedType
from rosidl_generator_swift import msg_type_to_c

type_name = message.structure.namespaced_type.name
msg_typename = '%s__%s' % ('__'.join(message.structure.namespaced_type.namespaces), type_name)
msg_prefix = "RCLSWIFT_{0}_{1}_{2}".format(package_name, '_'.join(message.structure.namespaced_type.namespaces), type_name).upper()
header_guard = "{0}_H".format(msg_prefix)
}@
#ifndef @(header_guard)
#define @(header_guard)

#if defined(_MSC_VER)
    //  Microsoft
    #define @(msg_prefix)_EXPORT __declspec(dllexport)
    #define @(msg_prefix)_IMPORT __declspec(dllimport)
#elif defined(__GNUC__)
    //  GCC
    #define @(msg_prefix)_EXPORT __attribute__((visibility("default")))
    #define @(msg_prefix)_IMPORT
#else
    //  do nothing and hope for the best?
    #define @(msg_prefix)_EXPORT
    #define @(msg_prefix)_IMPORT
    #pragma warning Unknown dynamic link import/export semantics.
#endif

#include "stdint.h"
#include "stdbool.h"

@(msg_prefix)_EXPORT
const void * @(msg_typename)__get_typesupport();

@(msg_prefix)_EXPORT
void * @(msg_typename)__create_native_message();

@(msg_prefix)_EXPORT
void @(msg_typename)__destroy_native_message(void *);

@[for member in message.structure.members]@
@[    if isinstance(member.type, Array)]@
// TODO: Array types are not supported
@[    elif isinstance(member.type, AbstractSequence)]@
// TODO: Sequence types are not supported
@[    elif isinstance(member.type, AbstractWString)]@
// TODO: Unicode types are not supported
@[    elif isinstance(member.type, BasicType) or isinstance(member.type, AbstractString)]@
@(msg_prefix)_EXPORT
@(msg_type_to_c(member.type)) @(msg_typename)__read_field_@(member.name)(void *);

@(msg_prefix)_EXPORT
void @(msg_typename)__write_field_@(member.name)(void *, const @(msg_type_to_c(member.type)));
@[    else]@
@(msg_prefix)_EXPORT
void * @(msg_typename)__get_field_@(member.name)_HANDLE(void *);
@[    end if]@
@[end for]@

#endif // @(header_guard)
