__precompile__(true)

module ProtoBuf

import Base.show, Base.copy!

export writeproto, readproto, ProtoMeta, ProtoMetaAttribs, meta, protobuild
export filled, isfilled, isfilled_default, which_oneof, fillset, fillset_default, fillunset
export show, copy!, set_field, set_field!, get_field, clear, add_field, add_field!, has_field, isinitialized
export ProtoEnum, lookup, enumstr
export ProtoServiceException, ProtoRpcChannel, ProtoRpcController, MethodDescriptor, ServiceDescriptor, ProtoService,
       AbstractProtoServiceStub, GenericProtoServiceStub, ProtoServiceStub, ProtoServiceBlockingStub,
       find_method, get_request_type, get_response_type, get_descriptor_for_type, call_method

using Compat

if isless(Base.VERSION, v"0.4.0-")
import Base.rsplit
rsplit{T<:AbstractString}(str::T, splitter; limit::Integer=0, keep::Bool=true) = rsplit(str, splitter, limit, keep)
end

if isless(Base.VERSION, v"0.4.0-")
fld_type(o, fld) = fieldtype(o, fld)
fld_names(x) = x.names
else
fld_type{T}(o::T, fld) = fieldtype(T, fld)
fld_names(x) = x.name.names
end

if isless(Base.VERSION, v"0.5.0-")
byte2str(x) = bytestring(x)
else
byte2str(x) = String(x)
end


# enable logging only during debugging
macro logmsg(s)
end
#macro logmsg(s)
#    quote
#        open("/tmp/protobuf.log", "a") do f
#            println(f, $(esc(s)))
#        end
#    end
#end

include("codec.jl")
include("svc.jl")

include("google/google.jl")

include("gen.jl")
include("utils.jl")

# Include Google ProtoBuf well known types (https://developers.google.com/protocol-buffers/docs/reference/google.protobuf).
# These are part of the `google.protobuf` sub-module and are included automatically by the code generator.
# For hand coded modules, include them with: `using ProtoBuf; using ProtoBuf.google.protobuf`.
include("google/wellknown.jl")

end # module
