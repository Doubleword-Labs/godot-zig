// Type aliases
pub const ObjectID = enum(u64) { _ };

// Enums
pub const InitializationLevel = enum(c_uint) {
    core = c.GDEXTENSION_INITIALIZATION_CORE,
    servers = c.GDEXTENSION_INITIALIZATION_SERVERS,
    scene = c.GDEXTENSION_INITIALIZATION_SCENE,
    editor = c.GDEXTENSION_INITIALIZATION_EDITOR,
    // max = c.GDEXTENSION_MAX_INITIALIZATION_LEVEL,
};

pub const ClassMethodFlags = packed struct(u32) {
    normal: bool = true,
    editor: bool = false,
    @"const": bool = false,
    virtual: bool = false,
    vararg: bool = false,
    static: bool = false,
    _padding: u26 = 0,

    pub const default: ClassMethodFlags = .{};
};

pub const ClassMethodArgumentMetadata = enum(c_uint) {
    none = c.GDEXTENSION_METHOD_ARGUMENT_METADATA_NONE,
    int_is_int8 = c.GDEXTENSION_METHOD_ARGUMENT_METADATA_INT_IS_INT8,
    int_is_int16 = c.GDEXTENSION_METHOD_ARGUMENT_METADATA_INT_IS_INT16,
    int_is_int32 = c.GDEXTENSION_METHOD_ARGUMENT_METADATA_INT_IS_INT32,
    int_is_int64 = c.GDEXTENSION_METHOD_ARGUMENT_METADATA_INT_IS_INT64,
    int_is_uint8 = c.GDEXTENSION_METHOD_ARGUMENT_METADATA_INT_IS_UINT8,
    int_is_uint16 = c.GDEXTENSION_METHOD_ARGUMENT_METADATA_INT_IS_UINT16,
    int_is_uint32 = c.GDEXTENSION_METHOD_ARGUMENT_METADATA_INT_IS_UINT32,
    int_is_uint64 = c.GDEXTENSION_METHOD_ARGUMENT_METADATA_INT_IS_UINT64,
    real_is_float = c.GDEXTENSION_METHOD_ARGUMENT_METADATA_REAL_IS_FLOAT,
    real_is_double = c.GDEXTENSION_METHOD_ARGUMENT_METADATA_REAL_IS_DOUBLE,
    int_is_char16 = c.GDEXTENSION_METHOD_ARGUMENT_METADATA_INT_IS_CHAR16,
    int_is_char32 = c.GDEXTENSION_METHOD_ARGUMENT_METADATA_INT_IS_CHAR32,
};

// Opaque types
pub const MethodBind = opaque {
    pub fn ptr(self: *const @This()) c.GDExtensionMethodBindPtr {
        return @ptrCast(self);
    }
};

pub const ClassLibrary = opaque {
    pub fn ptr(self: *@This()) c.GDExtensionClassLibraryPtr {
        return @ptrCast(self);
    }
};

pub const ScriptInstance = opaque {
    pub fn ptr(self: *@This()) c.GDExtensionScriptInstancePtr {
        return @ptrCast(self);
    }
};

pub const ScriptInstanceData = opaque {
    pub fn ptr(self: *@This()) c.GDExtensionScriptInstanceDataPtr {
        return @ptrCast(self);
    }
};

pub const ScriptLanguage = opaque {
    pub fn ptr(self: *@This()) c.GDExtensionScriptLanguagePtr {
        return @ptrCast(self);
    }
};

pub const ClassTag = opaque {
    pub fn ptr(self: *@This()) c.GDExtensionClassTagPtr {
        return @ptrCast(self);
    }
};

// Structs
pub const InstanceBindingCallbacks = extern struct {
    create_callback: c.GDExtensionInstanceBindingCreateCallback,
    free_callback: c.GDExtensionInstanceBindingFreeCallback,
    reference_callback: c.GDExtensionInstanceBindingReferenceCallback,
};

pub const PropertyInfo = extern struct {
    tag: Variant.Tag,
    name: *StringName,
    class_name: *StringName,
    hint: u32,
    hint_string: *String,
    usage: u32,
};

pub const MethodInfo = extern struct {
    name: *StringName,
    return_value: PropertyInfo,
    flags: u32,
    id: i32,
    argument_count: u32,
    arguments: [*]PropertyInfo,
    default_argument_count: u32,
    default_arguments: [*]*Variant,
};

pub const ClassMethodInfo = extern struct {
    name: *StringName,
    method_userdata: ?*anyopaque,
    call_func: c.GDExtensionClassMethodCall,
    ptrcall_func: c.GDExtensionClassMethodPtrCall,
    method_flags: u32,
    has_return_value: bool,
    return_value_info: *PropertyInfo,
    return_value_metadata: ClassMethodArgumentMetadata,
    argument_count: u32,
    arguments_info: [*]PropertyInfo,
    arguments_metadata: [*]ClassMethodArgumentMetadata,
    default_argument_count: u32,
    default_arguments: [*]*Variant,
};

pub const ClassVirtualMethodInfo = extern struct {
    name: *StringName,
    method_flags: u32,
    return_value: PropertyInfo,
    return_value_metadata: ClassMethodArgumentMetadata,
    argument_count: u32,
    arguments: [*]PropertyInfo,
    arguments_metadata: [*]ClassMethodArgumentMetadata,
};

pub const CallableCustomInfo = extern struct {
    callable_userdata: ?*anyopaque,
    library: *ClassLibrary,
    object_id: ObjectID,
    call_func: c.GDExtensionCallableCustomCall,
    is_valid_func: c.GDExtensionCallableCustomIsValid,
    free_func: c.GDExtensionCallableCustomFree,
    hash_func: c.GDExtensionCallableCustomHash,
    equal_func: c.GDExtensionCallableCustomEqual,
    less_than_func: c.GDExtensionCallableCustomLessThan,
    to_string_func: c.GDExtensionCallableCustomToString,
};

pub const CallableCustomInfo2 = extern struct {
    callable_userdata: ?*anyopaque,
    library: *ClassLibrary,
    object_id: ObjectID,
    call_func: c.GDExtensionCallableCustomCall,
    is_valid_func: c.GDExtensionCallableCustomIsValid,
    free_func: c.GDExtensionCallableCustomFree,
    hash_func: c.GDExtensionCallableCustomHash,
    equal_func: c.GDExtensionCallableCustomEqual,
    less_than_func: c.GDExtensionCallableCustomLessThan,
    to_string_func: c.GDExtensionCallableCustomToString,
    get_argument_count_func: c.GDExtensionCallableCustomGetArgumentCount,
};

pub const ScriptInstanceInfo = extern struct {
    set_func: c.GDExtensionScriptInstanceSet,
    get_func: c.GDExtensionScriptInstanceGet,
    get_property_list_func: c.GDExtensionScriptInstanceGetPropertyList,
    free_property_list_func: c.GDExtensionScriptInstanceFreePropertyList,
    property_can_revert_func: c.GDExtensionScriptInstancePropertyCanRevert,
    property_get_revert_func: c.GDExtensionScriptInstancePropertyGetRevert,
    get_owner_func: c.GDExtensionScriptInstanceGetOwner,
    get_property_state_func: c.GDExtensionScriptInstanceGetPropertyState,
    get_method_list_func: c.GDExtensionScriptInstanceGetMethodList,
    free_method_list_func: c.GDExtensionScriptInstanceFreeMethodList,
    get_property_type_func: c.GDExtensionScriptInstanceGetPropertyType,
    has_method_func: c.GDExtensionScriptInstanceHasMethod,
    call_func: c.GDExtensionScriptInstanceCall,
    notification_func: c.GDExtensionScriptInstanceNotification,
    to_string_func: c.GDExtensionScriptInstanceToString,
    refcount_incremented_func: c.GDExtensionScriptInstanceRefCountIncremented,
    refcount_decremented_func: c.GDExtensionScriptInstanceRefCountDecremented,
    get_script_func: c.GDExtensionScriptInstanceGetScript,
    is_placeholder_func: c.GDExtensionScriptInstanceIsPlaceholder,
    set_fallback_func: c.GDExtensionScriptInstanceSet,
    get_fallback_func: c.GDExtensionScriptInstanceGet,
    get_language_func: c.GDExtensionScriptInstanceGetLanguage,
    free_func: c.GDExtensionScriptInstanceFree,
};

pub const ScriptInstanceInfo2 = extern struct {
    set_func: c.GDExtensionScriptInstanceSet,
    get_func: c.GDExtensionScriptInstanceGet,
    get_property_list_func: c.GDExtensionScriptInstanceGetPropertyList,
    free_property_list_func: c.GDExtensionScriptInstanceFreePropertyList,
    get_class_category_func: c.GDExtensionScriptInstanceGetClassCategory,
    property_can_revert_func: c.GDExtensionScriptInstancePropertyCanRevert,
    property_get_revert_func: c.GDExtensionScriptInstancePropertyGetRevert,
    get_owner_func: c.GDExtensionScriptInstanceGetOwner,
    get_property_state_func: c.GDExtensionScriptInstanceGetPropertyState,
    get_method_list_func: c.GDExtensionScriptInstanceGetMethodList,
    free_method_list_func: c.GDExtensionScriptInstanceFreeMethodList,
    get_property_type_func: c.GDExtensionScriptInstanceGetPropertyType,
    validate_property_func: c.GDExtensionScriptInstanceValidateProperty,
    has_method_func: c.GDExtensionScriptInstanceHasMethod,
    call_func: c.GDExtensionScriptInstanceCall,
    notification_func: c.GDExtensionScriptInstanceNotification2,
    to_string_func: c.GDExtensionScriptInstanceToString,
    refcount_incremented_func: c.GDExtensionScriptInstanceRefCountIncremented,
    refcount_decremented_func: c.GDExtensionScriptInstanceRefCountDecremented,
    get_script_func: c.GDExtensionScriptInstanceGetScript,
    is_placeholder_func: c.GDExtensionScriptInstanceIsPlaceholder,
    set_fallback_func: c.GDExtensionScriptInstanceSet,
    get_fallback_func: c.GDExtensionScriptInstanceGet,
    get_language_func: c.GDExtensionScriptInstanceGetLanguage,
    free_func: c.GDExtensionScriptInstanceFree,
};

pub const ScriptInstanceInfo3 = extern struct {
    set_func: c.GDExtensionScriptInstanceSet,
    get_func: c.GDExtensionScriptInstanceGet,
    get_property_list_func: c.GDExtensionScriptInstanceGetPropertyList,
    free_property_list_func: c.GDExtensionScriptInstanceFreePropertyList2,
    get_class_category_func: c.GDExtensionScriptInstanceGetClassCategory,
    property_can_revert_func: c.GDExtensionScriptInstancePropertyCanRevert,
    property_get_revert_func: c.GDExtensionScriptInstancePropertyGetRevert,
    get_owner_func: c.GDExtensionScriptInstanceGetOwner,
    get_property_state_func: c.GDExtensionScriptInstanceGetPropertyState,
    get_method_list_func: c.GDExtensionScriptInstanceGetMethodList,
    free_method_list_func: c.GDExtensionScriptInstanceFreeMethodList2,
    get_property_type_func: c.GDExtensionScriptInstanceGetPropertyType,
    validate_property_func: c.GDExtensionScriptInstanceValidateProperty,
    has_method_func: c.GDExtensionScriptInstanceHasMethod,
    get_method_argument_count_func: c.GDExtensionScriptInstanceGetMethodArgumentCount,
    call_func: c.GDExtensionScriptInstanceCall,
    notification_func: c.GDExtensionScriptInstanceNotification2,
    to_string_func: c.GDExtensionScriptInstanceToString,
    refcount_incremented_func: c.GDExtensionScriptInstanceRefCountIncremented,
    refcount_decremented_func: c.GDExtensionScriptInstanceRefCountDecremented,
    get_script_func: c.GDExtensionScriptInstanceGetScript,
    is_placeholder_func: c.GDExtensionScriptInstanceIsPlaceholder,
    set_fallback_func: c.GDExtensionScriptInstanceSet,
    get_fallback_func: c.GDExtensionScriptInstanceGet,
    get_language_func: c.GDExtensionScriptInstanceGetLanguage,
    free_func: c.GDExtensionScriptInstanceFree,
};

pub const Initialization = extern struct {
    minimum_initialization_level: InitializationLevel,
    userdata: ?*anyopaque,
    initialize: *const fn (?*anyopaque, InitializationLevel) callconv(.C) void,
    deinitialize: *const fn (?*anyopaque, InitializationLevel) callconv(.C) void,
};

pub const GodotVersion = extern struct {
    major: u32,
    minor: u32,
    patch: u32,
    string: [*:0]const u8,
};

pub const ClassCreationInfo = struct {
    is_virtual: bool = false,
    is_abstract: bool = false,
    set_func: ?c.GDExtensionClassSet = null,
    get_func: ?c.GDExtensionClassGet = null,
    get_property_list_func: ?c.GDExtensionClassGetPropertyList = null,
    free_property_list_func: ?c.GDExtensionClassFreePropertyList = null,
    property_can_revert_func: ?c.GDExtensionClassPropertyCanRevert = null,
    property_get_revert_func: ?c.GDExtensionClassPropertyGetRevert = null,
    notification_func: ?c.GDExtensionClassNotification = null,
    to_string_func: ?c.GDExtensionClassToString = null,
    reference_func: ?c.GDExtensionClassReference = null,
    unreference_func: ?c.GDExtensionClassUnreference = null,
    create_instance_func: ?c.GDExtensionClassCreateInstance = null,
    free_instance_func: ?c.GDExtensionClassFreeInstance = null,
    get_virtual_func: ?c.GDExtensionClassGetVirtual = null,
    get_rid_func: ?c.GDExtensionClassGetRID = null,
    class_userdata: ?*anyopaque = null,
};

pub const ClassCreationInfo2 = struct {
    is_virtual: bool = false,
    is_abstract: bool = false,
    is_exposed: bool = true,
    set_func: ?c.GDExtensionClassSet = null,
    get_func: ?c.GDExtensionClassGet = null,
    get_property_list_func: ?c.GDExtensionClassGetPropertyList = null,
    free_property_list_func: ?c.GDExtensionClassFreePropertyList = null,
    property_can_revert_func: ?c.GDExtensionClassPropertyCanRevert = null,
    property_get_revert_func: ?c.GDExtensionClassPropertyGetRevert = null,
    validate_property_func: ?c.GDExtensionClassValidateProperty = null,
    notification_func: ?c.GDExtensionClassNotification2 = null,
    to_string_func: ?c.GDExtensionClassToString = null,
    reference_func: ?c.GDExtensionClassReference = null,
    unreference_func: ?c.GDExtensionClassUnreference = null,
    create_instance_func: ?c.GDExtensionClassCreateInstance = null,
    free_instance_func: ?c.GDExtensionClassFreeInstance = null,
    recreate_instance_func: ?c.GDExtensionClassRecreateInstance = null,
    get_virtual_func: ?c.GDExtensionClassGetVirtual = null,
    get_virtual_call_data_func: ?c.GDExtensionClassGetVirtualCallData = null,
    call_virtual_with_data_func: ?c.GDExtensionClassCallVirtualWithData = null,
    get_rid_func: ?c.GDExtensionClassGetRID = null,
    class_userdata: ?*anyopaque = null,
};

pub const ClassCreationInfo3 = struct {
    is_virtual: bool = false,
    is_abstract: bool = false,
    is_exposed: bool = true,
    is_runtime: bool = false,
    set_func: ?c.GDExtensionClassSet = null,
    get_func: ?c.GDExtensionClassGet = null,
    get_property_list_func: ?c.GDExtensionClassGetPropertyList = null,
    free_property_list_func: ?c.GDExtensionClassFreePropertyList2 = null,
    property_can_revert_func: ?c.GDExtensionClassPropertyCanRevert = null,
    property_get_revert_func: ?c.GDExtensionClassPropertyGetRevert = null,
    validate_property_func: ?c.GDExtensionClassValidateProperty = null,
    notification_func: ?c.GDExtensionClassNotification2 = null,
    to_string_func: ?c.GDExtensionClassToString = null,
    reference_func: ?c.GDExtensionClassReference = null,
    unreference_func: ?c.GDExtensionClassUnreference = null,
    create_instance_func: ?c.GDExtensionClassCreateInstance = null,
    free_instance_func: ?c.GDExtensionClassFreeInstance = null,
    recreate_instance_func: ?c.GDExtensionClassRecreateInstance = null,
    get_virtual_func: ?c.GDExtensionClassGetVirtual = null,
    get_virtual_call_data_func: ?c.GDExtensionClassGetVirtualCallData = null,
    call_virtual_with_data_func: ?c.GDExtensionClassCallVirtualWithData = null,
    get_rid_func: ?c.GDExtensionClassGetRID = null,
    class_userdata: ?*anyopaque = null,
};

pub const ClassCreationInfo4 = struct {
    parent_class_name: [*:0]const u8,
    class_name: [*:0]const u8,
    is_virtual: bool = false,
    is_abstract: bool = false,
    is_exposed: bool = true,
    is_runtime: bool = false,
    icon_path: ?[*:0]const u8 = null,

    set_func: ?c.GDExtensionClassSet = null,
    get_func: ?c.GDExtensionClassGet = null,
    get_property_list_func: ?c.GDExtensionClassGetPropertyList = null,
    free_property_list_func: ?c.GDExtensionClassFreePropertyList2 = null,
    property_can_revert_func: ?c.GDExtensionClassPropertyCanRevert = null,
    property_get_revert_func: ?c.GDExtensionClassPropertyGetRevert = null,
    validate_property_func: ?c.GDExtensionClassValidateProperty = null,
    notification_func: ?c.GDExtensionClassNotification2 = null,
    to_string_func: ?c.GDExtensionClassToString = null,
    reference_func: ?c.GDExtensionClassReference = null,
    unreference_func: ?c.GDExtensionClassUnreference = null,
    create_instance_func: ?c.GDExtensionClassCreateInstance2 = null,
    free_instance_func: ?c.GDExtensionClassFreeInstance = null,
    recreate_instance_func: ?c.GDExtensionClassRecreateInstance = null,
    get_virtual_func: ?c.GDExtensionClassGetVirtual2 = null,
    get_virtual_call_data_func: ?c.GDExtensionClassGetVirtualCallData2 = null,
    call_virtual_with_data_func: ?c.GDExtensionClassCallVirtualWithData = null,
    class_userdata: ?*anyopaque = null,
};

// Error types
const CallResult = extern struct {
    @"error": enum(c_uint) {
        ok = c.GDEXTENSION_CALL_OK,
        invalid_method = c.GDEXTENSION_CALL_ERROR_INVALID_METHOD,
        invalid_argument = c.GDEXTENSION_CALL_ERROR_INVALID_ARGUMENT,
        too_many_arguments = c.GDEXTENSION_CALL_ERROR_TOO_MANY_ARGUMENTS,
        too_few_arguments = c.GDEXTENSION_CALL_ERROR_TOO_FEW_ARGUMENTS,
        instance_is_null = c.GDEXTENSION_CALL_ERROR_INSTANCE_IS_NULL,
        method_not_const = c.GDEXTENSION_CALL_ERROR_METHOD_NOT_CONST,
    } = .ok,
    argument: i32 = 0,
    expected: i32 = 0,

    fn throw(self: CallResult) CallError!void {
        return switch (self) {
            .ok => {},
            .err => switch (self.err.@"error") {
                .invalid_method => error.InvalidMethod,
                .invalid_argument => error.InvalidArgument,
                .too_many_arguments => error.TooManyArguments,
                .too_few_arguments => error.TooFewArguments,
                .instance_is_null => error.InstanceIsNull,
                .method_not_const => error.MethodNotConst,
            },
        };
    }
};

pub const CallError = error{
    InvalidMethod,
    InvalidArgument,
    TooManyArguments,
    TooFewArguments,
    InstanceIsNull,
    MethodNotConst,
};

pub const Error = error{
    VariantCallError,
    InvalidOperation,
    InvalidKey,
    IndexOutOfBounds,
    ScriptMethodCallError,
    MethodCallError,
    ConstructorError,
    IteratorInitFailed,
    InvalidIterator,
};

// Interface struct
pub const Interface = struct {
    library: *ClassLibrary,

    // Memory management
    mem_alloc: c.GDExtensionInterfaceMemAlloc,
    mem_realloc: c.GDExtensionInterfaceMemRealloc,
    mem_free: c.GDExtensionInterfaceMemFree,

    // Print functions
    print_error: c.GDExtensionInterfacePrintError,
    print_error_with_message: c.GDExtensionInterfacePrintErrorWithMessage,
    print_warning: c.GDExtensionInterfacePrintWarning,
    print_warning_with_message: c.GDExtensionInterfacePrintWarningWithMessage,
    print_script_error: c.GDExtensionInterfacePrintScriptError,
    print_script_error_with_message: c.GDExtensionInterfacePrintScriptErrorWithMessage,

    // Native struct
    get_native_struct_size: c.GDExtensionInterfaceGetNativeStructSize,

    // Variant
    variant_new_copy: c.GDExtensionInterfaceVariantNewCopy,
    variant_new_nil: c.GDExtensionInterfaceVariantNewNil,
    variant_destroy: c.GDExtensionInterfaceVariantDestroy,
    variant_call: c.GDExtensionInterfaceVariantCall,
    variant_call_static: c.GDExtensionInterfaceVariantCallStatic,
    variant_evaluate: c.GDExtensionInterfaceVariantEvaluate,
    variant_set: c.GDExtensionInterfaceVariantSet,
    variant_set_named: c.GDExtensionInterfaceVariantSetNamed,
    variant_set_keyed: c.GDExtensionInterfaceVariantSetKeyed,
    variant_set_indexed: c.GDExtensionInterfaceVariantSetIndexed,
    variant_get: c.GDExtensionInterfaceVariantGet,
    variant_get_named: c.GDExtensionInterfaceVariantGetNamed,
    variant_get_keyed: c.GDExtensionInterfaceVariantGetKeyed,
    variant_get_indexed: c.GDExtensionInterfaceVariantGetIndexed,
    variant_iter_init: c.GDExtensionInterfaceVariantIterInit,
    variant_iter_next: c.GDExtensionInterfaceVariantIterNext,
    variant_iter_get: c.GDExtensionInterfaceVariantIterGet,
    variant_hash: c.GDExtensionInterfaceVariantHash,
    variant_recursive_hash: c.GDExtensionInterfaceVariantRecursiveHash,
    variant_hash_compare: c.GDExtensionInterfaceVariantHashCompare,
    variant_booleanize: c.GDExtensionInterfaceVariantBooleanize,
    variant_duplicate: c.GDExtensionInterfaceVariantDuplicate,
    variant_stringify: c.GDExtensionInterfaceVariantStringify,
    variant_get_type: c.GDExtensionInterfaceVariantGetType,
    variant_has_method: c.GDExtensionInterfaceVariantHasMethod,
    variant_has_member: c.GDExtensionInterfaceVariantHasMember,
    variant_has_key: c.GDExtensionInterfaceVariantHasKey,
    variant_get_object_instance_id: c.GDExtensionInterfaceVariantGetObjectInstanceId,
    variant_get_type_name: c.GDExtensionInterfaceVariantGetTypeName,
    variant_can_convert: c.GDExtensionInterfaceVariantCanConvert,
    variant_can_convert_strict: c.GDExtensionInterfaceVariantCanConvertStrict,

    // Variant type construction
    get_variant_from_type_constructor: c.GDExtensionInterfaceGetVariantFromTypeConstructor,
    get_variant_to_type_constructor: c.GDExtensionInterfaceGetVariantToTypeConstructor,
    get_variant_get_internal_ptr_func: c.GDExtensionInterfaceGetVariantGetInternalPtrFunc,

    // Variant ptr operations
    variant_get_ptr_operator_evaluator: c.GDExtensionInterfaceVariantGetPtrOperatorEvaluator,
    variant_get_ptr_builtin_method: c.GDExtensionInterfaceVariantGetPtrBuiltinMethod,
    variant_get_ptr_constructor: c.GDExtensionInterfaceVariantGetPtrConstructor,
    variant_get_ptr_destructor: c.GDExtensionInterfaceVariantGetPtrDestructor,
    variant_construct: c.GDExtensionInterfaceVariantConstruct,
    variant_get_ptr_setter: c.GDExtensionInterfaceVariantGetPtrSetter,
    variant_get_ptr_getter: c.GDExtensionInterfaceVariantGetPtrGetter,
    variant_get_ptr_indexed_setter: c.GDExtensionInterfaceVariantGetPtrIndexedSetter,
    variant_get_ptr_indexed_getter: c.GDExtensionInterfaceVariantGetPtrIndexedGetter,
    variant_get_ptr_keyed_setter: c.GDExtensionInterfaceVariantGetPtrKeyedSetter,
    variant_get_ptr_keyed_getter: c.GDExtensionInterfaceVariantGetPtrKeyedGetter,
    variant_get_ptr_keyed_checker: c.GDExtensionInterfaceVariantGetPtrKeyedChecker,
    variant_get_constant_value: c.GDExtensionInterfaceVariantGetConstantValue,
    variant_get_ptr_utility_function: c.GDExtensionInterfaceVariantGetPtrUtilityFunction,

    // String
    string_new_with_latin1_chars: c.GDExtensionInterfaceStringNewWithLatin1Chars,
    string_new_with_utf8_chars: c.GDExtensionInterfaceStringNewWithUtf8Chars,
    string_new_with_utf16_chars: c.GDExtensionInterfaceStringNewWithUtf16Chars,
    string_new_with_utf32_chars: c.GDExtensionInterfaceStringNewWithUtf32Chars,
    string_new_with_wide_chars: c.GDExtensionInterfaceStringNewWithWideChars,
    string_new_with_latin1_chars_and_len: c.GDExtensionInterfaceStringNewWithLatin1CharsAndLen,
    string_new_with_utf8_chars_and_len: c.GDExtensionInterfaceStringNewWithUtf8CharsAndLen,
    string_new_with_utf8_chars_and_len2: c.GDExtensionInterfaceStringNewWithUtf8CharsAndLen2,
    string_new_with_utf16_chars_and_len: c.GDExtensionInterfaceStringNewWithUtf16CharsAndLen,
    string_new_with_utf16_chars_and_len2: c.GDExtensionInterfaceStringNewWithUtf16CharsAndLen2,
    string_new_with_utf32_chars_and_len: c.GDExtensionInterfaceStringNewWithUtf32CharsAndLen,
    string_new_with_wide_chars_and_len: c.GDExtensionInterfaceStringNewWithWideCharsAndLen,
    string_to_latin1_chars: c.GDExtensionInterfaceStringToLatin1Chars,
    string_to_utf8_chars: c.GDExtensionInterfaceStringToUtf8Chars,
    string_to_utf16_chars: c.GDExtensionInterfaceStringToUtf16Chars,
    string_to_utf32_chars: c.GDExtensionInterfaceStringToUtf32Chars,
    string_to_wide_chars: c.GDExtensionInterfaceStringToWideChars,
    string_operator_index: c.GDExtensionInterfaceStringOperatorIndex,
    string_operator_index_const: c.GDExtensionInterfaceStringOperatorIndexConst,
    string_operator_plus_eq_string: c.GDExtensionInterfaceStringOperatorPlusEqString,
    string_operator_plus_eq_char: c.GDExtensionInterfaceStringOperatorPlusEqChar,
    string_operator_plus_eq_cstr: c.GDExtensionInterfaceStringOperatorPlusEqCstr,
    string_operator_plus_eq_wcstr: c.GDExtensionInterfaceStringOperatorPlusEqWcstr,
    string_operator_plus_eq_c32str: c.GDExtensionInterfaceStringOperatorPlusEqC32str,
    string_resize: c.GDExtensionInterfaceStringResize,

    // StringName
    string_name_new_with_latin1_chars: c.GDExtensionInterfaceStringNameNewWithLatin1Chars,
    string_name_new_with_utf8_chars: c.GDExtensionInterfaceStringNameNewWithUtf8Chars,
    string_name_new_with_utf8_chars_and_len: c.GDExtensionInterfaceStringNameNewWithUtf8CharsAndLen,

    // XML/File/Image helpers
    xml_parser_open_buffer: c.GDExtensionInterfaceXmlParserOpenBuffer,
    file_access_store_buffer: c.GDExtensionInterfaceFileAccessStoreBuffer,
    file_access_get_buffer: c.GDExtensionInterfaceFileAccessGetBuffer,
    image_ptrw: c.GDExtensionInterfaceImagePtrw,
    image_ptr: c.GDExtensionInterfaceImagePtr,

    // WorkerThreadPool
    worker_thread_pool_add_native_group_task: c.GDExtensionInterfaceWorkerThreadPoolAddNativeGroupTask,
    worker_thread_pool_add_native_task: c.GDExtensionInterfaceWorkerThreadPoolAddNativeTask,

    // Packed array operations
    packed_byte_array_operator_index: c.GDExtensionInterfacePackedByteArrayOperatorIndex,
    packed_byte_array_operator_index_const: c.GDExtensionInterfacePackedByteArrayOperatorIndexConst,
    packed_float32_array_operator_index: c.GDExtensionInterfacePackedFloat32ArrayOperatorIndex,
    packed_float32_array_operator_index_const: c.GDExtensionInterfacePackedFloat32ArrayOperatorIndexConst,
    packed_float64_array_operator_index: c.GDExtensionInterfacePackedFloat64ArrayOperatorIndex,
    packed_float64_array_operator_index_const: c.GDExtensionInterfacePackedFloat64ArrayOperatorIndexConst,
    packed_int32_array_operator_index: c.GDExtensionInterfacePackedInt32ArrayOperatorIndex,
    packed_int32_array_operator_index_const: c.GDExtensionInterfacePackedInt32ArrayOperatorIndexConst,
    packed_int64_array_operator_index: c.GDExtensionInterfacePackedInt64ArrayOperatorIndex,
    packed_int64_array_operator_index_const: c.GDExtensionInterfacePackedInt64ArrayOperatorIndexConst,
    packed_string_array_operator_index: c.GDExtensionInterfacePackedStringArrayOperatorIndex,
    packed_string_array_operator_index_const: c.GDExtensionInterfacePackedStringArrayOperatorIndexConst,
    packed_vector2_array_operator_index: c.GDExtensionInterfacePackedVector2ArrayOperatorIndex,
    packed_vector2_array_operator_index_const: c.GDExtensionInterfacePackedVector2ArrayOperatorIndexConst,
    packed_vector3_array_operator_index: c.GDExtensionInterfacePackedVector3ArrayOperatorIndex,
    packed_vector3_array_operator_index_const: c.GDExtensionInterfacePackedVector3ArrayOperatorIndexConst,
    packed_vector4_array_operator_index: c.GDExtensionInterfacePackedVector4ArrayOperatorIndex,
    packed_vector4_array_operator_index_const: c.GDExtensionInterfacePackedVector4ArrayOperatorIndexConst,
    packed_color_array_operator_index: c.GDExtensionInterfacePackedColorArrayOperatorIndex,
    packed_color_array_operator_index_const: c.GDExtensionInterfacePackedColorArrayOperatorIndexConst,

    // Array
    array_operator_index: c.GDExtensionInterfaceArrayOperatorIndex,
    array_operator_index_const: c.GDExtensionInterfaceArrayOperatorIndexConst,
    array_ref: c.GDExtensionInterfaceArrayRef,
    array_set_typed: c.GDExtensionInterfaceArraySetTyped,

    // Dictionary
    dictionary_operator_index: c.GDExtensionInterfaceDictionaryOperatorIndex,
    dictionary_operator_index_const: c.GDExtensionInterfaceDictionaryOperatorIndexConst,
    dictionary_set_typed: c.GDExtensionInterfaceDictionarySetTyped,

    // Object
    object_method_bind_call: c.GDExtensionInterfaceObjectMethodBindCall,
    object_method_bind_ptrcall: c.GDExtensionInterfaceObjectMethodBindPtrcall,
    object_destroy: c.GDExtensionInterfaceObjectDestroy,
    global_get_singleton: c.GDExtensionInterfaceGlobalGetSingleton,
    object_get_instance_binding: c.GDExtensionInterfaceObjectGetInstanceBinding,
    object_set_instance_binding: c.GDExtensionInterfaceObjectSetInstanceBinding,
    object_free_instance_binding: c.GDExtensionInterfaceObjectFreeInstanceBinding,
    object_set_instance: c.GDExtensionInterfaceObjectSetInstance,
    object_get_class_name: c.GDExtensionInterfaceObjectGetClassName,
    object_cast_to: c.GDExtensionInterfaceObjectCastTo,
    object_get_instance_from_id: c.GDExtensionInterfaceObjectGetInstanceFromId,
    object_get_instance_id: c.GDExtensionInterfaceObjectGetInstanceId,
    object_has_script_method: c.GDExtensionInterfaceObjectHasScriptMethod,
    object_call_script_method: c.GDExtensionInterfaceObjectCallScriptMethod,

    // Ref
    ref_get_object: c.GDExtensionInterfaceRefGetObject,
    ref_set_object: c.GDExtensionInterfaceRefSetObject,

    // Script instance
    script_instance_create: c.GDExtensionInterfaceScriptInstanceCreate,
    script_instance_create2: c.GDExtensionInterfaceScriptInstanceCreate2,
    script_instance_create3: c.GDExtensionInterfaceScriptInstanceCreate3,
    placeholder_script_instance_create: c.GDExtensionInterfacePlaceHolderScriptInstanceCreate,
    placeholder_script_instance_update: c.GDExtensionInterfacePlaceHolderScriptInstanceUpdate,
    object_get_script_instance: c.GDExtensionInterfaceObjectGetScriptInstance,

    // Callable
    callable_custom_create: c.GDExtensionInterfaceCallableCustomCreate,
    callable_custom_create2: c.GDExtensionInterfaceCallableCustomCreate2,
    callable_custom_get_user_data: c.GDExtensionInterfaceCallableCustomGetUserData,

    // ClassDB
    classdb_construct_object: c.GDExtensionInterfaceClassdbConstructObject,
    classdb_construct_object2: c.GDExtensionInterfaceClassdbConstructObject2,
    classdb_get_method_bind: c.GDExtensionInterfaceClassdbGetMethodBind,
    classdb_get_class_tag: c.GDExtensionInterfaceClassdbGetClassTag,
    classdb_register_extension_class: c.GDExtensionInterfaceClassdbRegisterExtensionClass,
    classdb_register_extension_class2: c.GDExtensionInterfaceClassdbRegisterExtensionClass2,
    classdb_register_extension_class3: c.GDExtensionInterfaceClassdbRegisterExtensionClass3,
    classdb_register_extension_class4: c.GDExtensionInterfaceClassdbRegisterExtensionClass4,
    classdb_register_extension_class_method: c.GDExtensionInterfaceClassdbRegisterExtensionClassMethod,
    classdb_register_extension_class_virtual_method: c.GDExtensionInterfaceClassdbRegisterExtensionClassVirtualMethod,
    classdb_register_extension_class_integer_constant: c.GDExtensionInterfaceClassdbRegisterExtensionClassIntegerConstant,
    classdb_register_extension_class_property: c.GDExtensionInterfaceClassdbRegisterExtensionClassProperty,
    classdb_register_extension_class_property_indexed: c.GDExtensionInterfaceClassdbRegisterExtensionClassPropertyIndexed,
    classdb_register_extension_class_property_group: c.GDExtensionInterfaceClassdbRegisterExtensionClassPropertyGroup,
    classdb_register_extension_class_property_subgroup: c.GDExtensionInterfaceClassdbRegisterExtensionClassPropertySubgroup,
    classdb_register_extension_class_signal: c.GDExtensionInterfaceClassdbRegisterExtensionClassSignal,
    classdb_unregister_extension_class: c.GDExtensionInterfaceClassdbUnregisterExtensionClass,

    // Library path
    get_library_path: c.GDExtensionInterfaceGetLibraryPath,

    // Editor
    editor_add_plugin: c.GDExtensionInterfaceEditorAddPlugin,
    editor_remove_plugin: c.GDExtensionInterfaceEditorRemovePlugin,
    editor_help_load_xml_from_utf8_chars: c.GDExtensionsInterfaceEditorHelpLoadXmlFromUtf8Chars,
    editor_help_load_xml_from_utf8_chars_and_len: c.GDExtensionsInterfaceEditorHelpLoadXmlFromUtf8CharsAndLen,

    // Version
    get_godot_version: c.GDExtensionInterfaceGetGodotVersion,

    // Initialize the interface from the entry point
    pub fn initialize(
        get_proc_address: c.GDExtensionInterfaceGetProcAddress,
        library: *ClassLibrary,
    ) Interface {
        return .{
            .library = library,

            // Memory management
            .mem_alloc = @ptrCast(get_proc_address("mem_alloc").?),
            .mem_realloc = @ptrCast(get_proc_address("mem_realloc").?),
            .mem_free = @ptrCast(get_proc_address("mem_free").?),

            // Print functions
            .print_error = @ptrCast(get_proc_address("print_error").?),
            .print_error_with_message = @ptrCast(get_proc_address("print_error_with_message").?),
            .print_warning = @ptrCast(get_proc_address("print_warning").?),
            .print_warning_with_message = @ptrCast(get_proc_address("print_warning_with_message").?),
            .print_script_error = @ptrCast(get_proc_address("print_script_error").?),
            .print_script_error_with_message = @ptrCast(get_proc_address("print_script_error_with_message").?),

            // Native struct
            .get_native_struct_size = @ptrCast(get_proc_address("get_native_struct_size").?),

            // Variant
            .variant_new_copy = @ptrCast(get_proc_address("variant_new_copy").?),
            .variant_new_nil = @ptrCast(get_proc_address("variant_new_nil").?),
            .variant_destroy = @ptrCast(get_proc_address("variant_destroy").?),
            .variant_call = @ptrCast(get_proc_address("variant_call").?),
            .variant_call_static = @ptrCast(get_proc_address("variant_call_static").?),
            .variant_evaluate = @ptrCast(get_proc_address("variant_evaluate").?),
            .variant_set = @ptrCast(get_proc_address("variant_set").?),
            .variant_set_named = @ptrCast(get_proc_address("variant_set_named").?),
            .variant_set_keyed = @ptrCast(get_proc_address("variant_set_keyed").?),
            .variant_set_indexed = @ptrCast(get_proc_address("variant_set_indexed").?),
            .variant_get = @ptrCast(get_proc_address("variant_get").?),
            .variant_get_named = @ptrCast(get_proc_address("variant_get_named").?),
            .variant_get_keyed = @ptrCast(get_proc_address("variant_get_keyed").?),
            .variant_get_indexed = @ptrCast(get_proc_address("variant_get_indexed").?),
            .variant_iter_init = @ptrCast(get_proc_address("variant_iter_init").?),
            .variant_iter_next = @ptrCast(get_proc_address("variant_iter_next").?),
            .variant_iter_get = @ptrCast(get_proc_address("variant_iter_get").?),
            .variant_hash = @ptrCast(get_proc_address("variant_hash").?),
            .variant_recursive_hash = @ptrCast(get_proc_address("variant_recursive_hash").?),
            .variant_hash_compare = @ptrCast(get_proc_address("variant_hash_compare").?),
            .variant_booleanize = @ptrCast(get_proc_address("variant_booleanize").?),
            .variant_duplicate = @ptrCast(get_proc_address("variant_duplicate").?),
            .variant_stringify = @ptrCast(get_proc_address("variant_stringify").?),
            .variant_get_type = @ptrCast(get_proc_address("variant_get_type").?),
            .variant_has_method = @ptrCast(get_proc_address("variant_has_method").?),
            .variant_has_member = @ptrCast(get_proc_address("variant_has_member").?),
            .variant_has_key = @ptrCast(get_proc_address("variant_has_key").?),
            .variant_get_object_instance_id = @ptrCast(get_proc_address("variant_get_object_instance_id").?),
            .variant_get_type_name = @ptrCast(get_proc_address("variant_get_type_name").?),
            .variant_can_convert = @ptrCast(get_proc_address("variant_can_convert").?),
            .variant_can_convert_strict = @ptrCast(get_proc_address("variant_can_convert_strict").?),

            // Variant type construction
            .get_variant_from_type_constructor = @ptrCast(get_proc_address("get_variant_from_type_constructor").?),
            .get_variant_to_type_constructor = @ptrCast(get_proc_address("get_variant_to_type_constructor").?),
            .get_variant_get_internal_ptr_func = @ptrCast(get_proc_address("get_variant_get_internal_ptr_func").?),

            // Variant ptr operations
            .variant_get_ptr_operator_evaluator = @ptrCast(get_proc_address("variant_get_ptr_operator_evaluator").?),
            .variant_get_ptr_builtin_method = @ptrCast(get_proc_address("variant_get_ptr_builtin_method").?),
            .variant_get_ptr_constructor = @ptrCast(get_proc_address("variant_get_ptr_constructor").?),
            .variant_get_ptr_destructor = @ptrCast(get_proc_address("variant_get_ptr_destructor").?),
            .variant_construct = @ptrCast(get_proc_address("variant_construct").?),
            .variant_get_ptr_setter = @ptrCast(get_proc_address("variant_get_ptr_setter").?),
            .variant_get_ptr_getter = @ptrCast(get_proc_address("variant_get_ptr_getter").?),
            .variant_get_ptr_indexed_setter = @ptrCast(get_proc_address("variant_get_ptr_indexed_setter").?),
            .variant_get_ptr_indexed_getter = @ptrCast(get_proc_address("variant_get_ptr_indexed_getter").?),
            .variant_get_ptr_keyed_setter = @ptrCast(get_proc_address("variant_get_ptr_keyed_setter").?),
            .variant_get_ptr_keyed_getter = @ptrCast(get_proc_address("variant_get_ptr_keyed_getter").?),
            .variant_get_ptr_keyed_checker = @ptrCast(get_proc_address("variant_get_ptr_keyed_checker").?),
            .variant_get_constant_value = @ptrCast(get_proc_address("variant_get_constant_value").?),
            .variant_get_ptr_utility_function = @ptrCast(get_proc_address("variant_get_ptr_utility_function").?),

            // String
            .string_new_with_latin1_chars = @ptrCast(get_proc_address("string_new_with_latin1_chars").?),
            .string_new_with_utf8_chars = @ptrCast(get_proc_address("string_new_with_utf8_chars").?),
            .string_new_with_utf16_chars = @ptrCast(get_proc_address("string_new_with_utf16_chars").?),
            .string_new_with_utf32_chars = @ptrCast(get_proc_address("string_new_with_utf32_chars").?),
            .string_new_with_wide_chars = @ptrCast(get_proc_address("string_new_with_wide_chars").?),
            .string_new_with_latin1_chars_and_len = @ptrCast(get_proc_address("string_new_with_latin1_chars_and_len").?),
            .string_new_with_utf8_chars_and_len = @ptrCast(get_proc_address("string_new_with_utf8_chars_and_len").?),
            .string_new_with_utf8_chars_and_len2 = @ptrCast(get_proc_address("string_new_with_utf8_chars_and_len2").?),
            .string_new_with_utf16_chars_and_len = @ptrCast(get_proc_address("string_new_with_utf16_chars_and_len").?),
            .string_new_with_utf16_chars_and_len2 = @ptrCast(get_proc_address("string_new_with_utf16_chars_and_len2").?),
            .string_new_with_utf32_chars_and_len = @ptrCast(get_proc_address("string_new_with_utf32_chars_and_len").?),
            .string_new_with_wide_chars_and_len = @ptrCast(get_proc_address("string_new_with_wide_chars_and_len").?),
            .string_to_latin1_chars = @ptrCast(get_proc_address("string_to_latin1_chars").?),
            .string_to_utf8_chars = @ptrCast(get_proc_address("string_to_utf8_chars").?),
            .string_to_utf16_chars = @ptrCast(get_proc_address("string_to_utf16_chars").?),
            .string_to_utf32_chars = @ptrCast(get_proc_address("string_to_utf32_chars").?),
            .string_to_wide_chars = @ptrCast(get_proc_address("string_to_wide_chars").?),
            .string_operator_index = @ptrCast(get_proc_address("string_operator_index").?),
            .string_operator_index_const = @ptrCast(get_proc_address("string_operator_index_const").?),
            .string_operator_plus_eq_string = @ptrCast(get_proc_address("string_operator_plus_eq_string").?),
            .string_operator_plus_eq_char = @ptrCast(get_proc_address("string_operator_plus_eq_char").?),
            .string_operator_plus_eq_cstr = @ptrCast(get_proc_address("string_operator_plus_eq_cstr").?),
            .string_operator_plus_eq_wcstr = @ptrCast(get_proc_address("string_operator_plus_eq_wcstr").?),
            .string_operator_plus_eq_c32str = @ptrCast(get_proc_address("string_operator_plus_eq_c32str").?),
            .string_resize = @ptrCast(get_proc_address("string_resize").?),

            // StringName
            .string_name_new_with_latin1_chars = @ptrCast(get_proc_address("string_name_new_with_latin1_chars").?),
            .string_name_new_with_utf8_chars = @ptrCast(get_proc_address("string_name_new_with_utf8_chars").?),
            .string_name_new_with_utf8_chars_and_len = @ptrCast(get_proc_address("string_name_new_with_utf8_chars_and_len").?),

            // XML/File/Image helpers
            .xml_parser_open_buffer = @ptrCast(get_proc_address("xml_parser_open_buffer").?),
            .file_access_store_buffer = @ptrCast(get_proc_address("file_access_store_buffer").?),
            .file_access_get_buffer = @ptrCast(get_proc_address("file_access_get_buffer").?),
            .image_ptrw = @ptrCast(get_proc_address("image_ptrw").?),
            .image_ptr = @ptrCast(get_proc_address("image_ptr").?),

            // WorkerThreadPool
            .worker_thread_pool_add_native_group_task = @ptrCast(get_proc_address("worker_thread_pool_add_native_group_task").?),
            .worker_thread_pool_add_native_task = @ptrCast(get_proc_address("worker_thread_pool_add_native_task").?),

            // Packed array operations
            .packed_byte_array_operator_index = @ptrCast(get_proc_address("packed_byte_array_operator_index").?),
            .packed_byte_array_operator_index_const = @ptrCast(get_proc_address("packed_byte_array_operator_index_const").?),
            .packed_float32_array_operator_index = @ptrCast(get_proc_address("packed_float32_array_operator_index").?),
            .packed_float32_array_operator_index_const = @ptrCast(get_proc_address("packed_float32_array_operator_index_const").?),
            .packed_float64_array_operator_index = @ptrCast(get_proc_address("packed_float64_array_operator_index").?),
            .packed_float64_array_operator_index_const = @ptrCast(get_proc_address("packed_float64_array_operator_index_const").?),
            .packed_int32_array_operator_index = @ptrCast(get_proc_address("packed_int32_array_operator_index").?),
            .packed_int32_array_operator_index_const = @ptrCast(get_proc_address("packed_int32_array_operator_index_const").?),
            .packed_int64_array_operator_index = @ptrCast(get_proc_address("packed_int64_array_operator_index").?),
            .packed_int64_array_operator_index_const = @ptrCast(get_proc_address("packed_int64_array_operator_index_const").?),
            .packed_string_array_operator_index = @ptrCast(get_proc_address("packed_string_array_operator_index").?),
            .packed_string_array_operator_index_const = @ptrCast(get_proc_address("packed_string_array_operator_index_const").?),
            .packed_vector2_array_operator_index = @ptrCast(get_proc_address("packed_vector2_array_operator_index").?),
            .packed_vector2_array_operator_index_const = @ptrCast(get_proc_address("packed_vector2_array_operator_index_const").?),
            .packed_vector3_array_operator_index = @ptrCast(get_proc_address("packed_vector3_array_operator_index").?),
            .packed_vector3_array_operator_index_const = @ptrCast(get_proc_address("packed_vector3_array_operator_index_const").?),
            .packed_vector4_array_operator_index = @ptrCast(get_proc_address("packed_vector4_array_operator_index").?),
            .packed_vector4_array_operator_index_const = @ptrCast(get_proc_address("packed_vector4_array_operator_index_const").?),
            .packed_color_array_operator_index = @ptrCast(get_proc_address("packed_color_array_operator_index").?),
            .packed_color_array_operator_index_const = @ptrCast(get_proc_address("packed_color_array_operator_index_const").?),

            // Array
            .array_operator_index = @ptrCast(get_proc_address("array_operator_index").?),
            .array_operator_index_const = @ptrCast(get_proc_address("array_operator_index_const").?),
            .array_ref = @ptrCast(get_proc_address("array_ref").?),
            .array_set_typed = @ptrCast(get_proc_address("array_set_typed").?),

            // Dictionary
            .dictionary_operator_index = @ptrCast(get_proc_address("dictionary_operator_index").?),
            .dictionary_operator_index_const = @ptrCast(get_proc_address("dictionary_operator_index_const").?),
            .dictionary_set_typed = @ptrCast(get_proc_address("dictionary_set_typed").?),

            // Object
            .object_method_bind_call = @ptrCast(get_proc_address("object_method_bind_call").?),
            .object_method_bind_ptrcall = @ptrCast(get_proc_address("object_method_bind_ptrcall").?),
            .object_destroy = @ptrCast(get_proc_address("object_destroy").?),
            .global_get_singleton = @ptrCast(get_proc_address("global_get_singleton").?),
            .object_get_instance_binding = @ptrCast(get_proc_address("object_get_instance_binding").?),
            .object_set_instance_binding = @ptrCast(get_proc_address("object_set_instance_binding").?),
            .object_free_instance_binding = @ptrCast(get_proc_address("object_free_instance_binding").?),
            .object_set_instance = @ptrCast(get_proc_address("object_set_instance").?),
            .object_get_class_name = @ptrCast(get_proc_address("object_get_class_name").?),
            .object_cast_to = @ptrCast(get_proc_address("object_cast_to").?),
            .object_get_instance_from_id = @ptrCast(get_proc_address("object_get_instance_from_id").?),
            .object_get_instance_id = @ptrCast(get_proc_address("object_get_instance_id").?),
            .object_has_script_method = @ptrCast(get_proc_address("object_has_script_method").?),
            .object_call_script_method = @ptrCast(get_proc_address("object_call_script_method").?),

            // Ref
            .ref_get_object = @ptrCast(get_proc_address("ref_get_object").?),
            .ref_set_object = @ptrCast(get_proc_address("ref_set_object").?),

            // Script instance
            .script_instance_create = @ptrCast(get_proc_address("script_instance_create").?),
            .script_instance_create2 = @ptrCast(get_proc_address("script_instance_create2").?),
            .script_instance_create3 = @ptrCast(get_proc_address("script_instance_create3").?),
            .placeholder_script_instance_create = @ptrCast(get_proc_address("placeholder_script_instance_create").?),
            .placeholder_script_instance_update = @ptrCast(get_proc_address("placeholder_script_instance_update").?),
            .object_get_script_instance = @ptrCast(get_proc_address("object_get_script_instance").?),

            // Callable
            .callable_custom_create = @ptrCast(get_proc_address("callable_custom_create").?),
            .callable_custom_create2 = @ptrCast(get_proc_address("callable_custom_create2").?),
            .callable_custom_get_user_data = @ptrCast(get_proc_address("callable_custom_get_user_data").?),

            // ClassDB
            .classdb_construct_object = @ptrCast(get_proc_address("classdb_construct_object").?),
            .classdb_construct_object2 = @ptrCast(get_proc_address("classdb_construct_object2").?),
            .classdb_get_method_bind = @ptrCast(get_proc_address("classdb_get_method_bind").?),
            .classdb_get_class_tag = @ptrCast(get_proc_address("classdb_get_class_tag").?),
            .classdb_register_extension_class = @ptrCast(get_proc_address("classdb_register_extension_class").?),
            .classdb_register_extension_class2 = @ptrCast(get_proc_address("classdb_register_extension_class2").?),
            .classdb_register_extension_class3 = @ptrCast(get_proc_address("classdb_register_extension_class3").?),
            .classdb_register_extension_class4 = @ptrCast(get_proc_address("classdb_register_extension_class4").?),
            .classdb_register_extension_class_method = @ptrCast(get_proc_address("classdb_register_extension_class_method").?),
            .classdb_register_extension_class_virtual_method = @ptrCast(get_proc_address("classdb_register_extension_class_virtual_method").?),
            .classdb_register_extension_class_integer_constant = @ptrCast(get_proc_address("classdb_register_extension_class_integer_constant").?),
            .classdb_register_extension_class_property = @ptrCast(get_proc_address("classdb_register_extension_class_property").?),
            .classdb_register_extension_class_property_indexed = @ptrCast(get_proc_address("classdb_register_extension_class_property_indexed").?),
            .classdb_register_extension_class_property_group = @ptrCast(get_proc_address("classdb_register_extension_class_property_group").?),
            .classdb_register_extension_class_property_subgroup = @ptrCast(get_proc_address("classdb_register_extension_class_property_subgroup").?),
            .classdb_register_extension_class_signal = @ptrCast(get_proc_address("classdb_register_extension_class_signal").?),
            .classdb_unregister_extension_class = @ptrCast(get_proc_address("classdb_unregister_extension_class").?),

            // Library path
            .get_library_path = @ptrCast(get_proc_address("get_library_path").?),

            // Editor
            .editor_add_plugin = @ptrCast(get_proc_address("editor_add_plugin").?),
            .editor_remove_plugin = @ptrCast(get_proc_address("editor_remove_plugin").?),
            .editor_help_load_xml_from_utf8_chars = @ptrCast(get_proc_address("editor_help_load_xml_from_utf8_chars").?),
            .editor_help_load_xml_from_utf8_chars_and_len = @ptrCast(get_proc_address("editor_help_load_xml_from_utf8_chars_and_len").?),

            // Version
            .get_godot_version = @ptrCast(get_proc_address("get_godot_version").?),
        };
    }
};

// Global interface instance
pub var raw: Interface = undefined;

// Helper functions

// Memory management
pub fn memAlloc(size: usize) *anyopaque {
    return raw.mem_alloc(size).?;
}

pub fn memRealloc(ptr: *anyopaque, size: usize) *anyopaque {
    return raw.mem_realloc(ptr, size).?;
}

pub fn memFree(ptr: *anyopaque) void {
    raw.mem_free(ptr);
}

// Error reporting
pub fn printError(description: [*:0]const u8, function: [*:0]const u8, file: [*:0]const u8, line: i32, editor_notify: bool) void {
    raw.print_error(description, function, file, line, @intFromBool(editor_notify));
}

pub fn printWarning(description: [*:0]const u8, function: [*:0]const u8, file: [*:0]const u8, line: i32, editor_notify: bool) void {
    raw.print_warning(description, function, file, line, @intFromBool(editor_notify));
}

pub fn printErrorWithMessage(description: [*:0]const u8, message: [*:0]const u8, function: [*:0]const u8, file: [*:0]const u8, line: i32, editor_notify: bool) void {
    raw.print_error_with_message(description, message, function, file, line, @intFromBool(editor_notify));
}

pub fn printWarningWithMessage(description: [*:0]const u8, message: [*:0]const u8, function: [*:0]const u8, file: [*:0]const u8, line: i32, editor_notify: bool) void {
    raw.print_warning_with_message(description, message, function, file, line, @intFromBool(editor_notify));
}

pub fn printScriptError(description: [*:0]const u8, function: [*:0]const u8, file: [*:0]const u8, line: i32, editor_notify: bool) void {
    raw.print_script_error(description, function, file, line, @intFromBool(editor_notify));
}

pub fn printScriptErrorWithMessage(description: [*:0]const u8, message: [*:0]const u8, function: [*:0]const u8, file: [*:0]const u8, line: i32, editor_notify: bool) void {
    raw.print_script_error_with_message(description, message, function, file, line, @intFromBool(editor_notify));
}

// Variant helpers
pub fn variantNewNil() Variant {
    var result: Variant = undefined;
    raw.variant_new_nil(result.ptr());
    return result;
}

pub fn variantNewCopy(src: *const Variant) Variant {
    var result: Variant = undefined;
    raw.variant_new_copy(result.ptr(), src);
    return result;
}

pub fn variantDestroy(variant: *Variant) void {
    raw.variant_destroy(variant);
}

pub fn variantGetType(variant: *const Variant) Variant.Tag {
    return @enumFromInt(raw.variant_get_type(variant));
}

// String helpers
pub fn stringNewWithUtf8Chars(str: [*:0]const u8) String {
    var string: String = undefined;
    raw.string_new_with_utf8_chars(string.ptr(), str);
    return string;
}

pub fn stringNewWithUtf8(str: []const u8) String {
    var string: String = undefined;
    raw.string_new_with_utf8_chars_and_len(string.ptr(), str.ptr, str.len);
    return string;
}

pub fn stringToUtf8Chars(string: *const String, buffer: []u8) i64 {
    return raw.string_to_utf8_chars(string.constPtr(), buffer.ptr, buffer.len);
}

// StringName helpers

pub fn stringNameNewWithLatin1Chars(str: [*:0]const u8) StringName {
    var string_name: StringName = undefined;
    raw.string_name_new_with_latin1_chars(string_name.ptr(), str);
    return string_name;
}

pub fn stringNameNewWithUtf8Chars(str: [*:0]const u8) StringName {
    var string_name: StringName = undefined;
    raw.string_name_new_with_utf8_chars(string_name.ptr(), str);
    return string_name;
}

pub fn stringNameNewWithUtf8(str: []const u8) StringName {
    var string_name: StringName = undefined;
    raw.string_name_new_with_utf8_chars_and_len(string_name.ptr(), str.ptr, str.len);
    return string_name;
}

// Object helpers
pub fn objectGetInstanceId(obj: *const Object) ObjectID {
    return raw.object_get_instance_id(obj);
}

pub fn objectGetInstanceFromId(id: ObjectID) ?*Object {
    return @ptrCast(raw.object_get_instance_from_id(id));
}

pub fn objectDestroy(obj: *Object) void {
    raw.object_destroy(obj);
}

// Singleton access
pub fn globalGetSingleton(name: *const StringName) ?*Object {
    return @ptrCast(raw.global_get_singleton(name.constPtr()));
}

// Method binding
pub fn classdbGetMethodBind(class_name: *const StringName, method_name: *const StringName, hash: i64) ?*MethodBind {
    const ptr = raw.classdb_get_method_bind(class_name.constPtr(), method_name.constPtr(), hash);
    return ptr;
}

// Variant operations
pub fn variantCall(self: *Variant, method: *const StringName, args: []const *const Variant) CallError!Variant {
    var ret: Variant = undefined;
    var result: CallResult = undefined;

    raw.variant_call(self.ptr(), method.constPtr(), @ptrCast(args.ptr), @intCast(args.len), @ptrCast(&ret), &result);

    try result.throw();

    return ret;
}

pub fn variantCallStatic(variant_tag: Variant.Tag, method: *const StringName, args: []const *const Variant) CallError!Variant {
    var ret: Variant = undefined;
    var result: CallResult = undefined;

    raw.variant_call_static(@intFromEnum(variant_tag), method.constPtr(), @ptrCast(args.ptr), @intCast(args.len), ret.ptr(), &result);

    try result.throw();

    return ret;
}

pub fn variantEvaluate(op: Variant.Operator, a: *const Variant, b: *const Variant) Error!Variant {
    var result: Variant = undefined;
    var valid: u8 = 0;

    raw.variant_evaluate(@intFromEnum(op), a.constPtr(), b.constPtr(), result.ptr(), &valid);

    if (valid == 0) {
        return error.InvalidOperation;
    }

    return result;
}

pub fn variantGet(self: *const Variant, key: *const Variant) Error!Variant {
    var result: Variant = undefined;
    var valid: u8 = 0;

    raw.variant_get(self.constPtr(), key.constPtr(), result.ptr(), &valid);

    if (valid == 0) {
        return error.InvalidKey;
    }

    return result;
}

pub fn variantSet(self: *Variant, key: *const Variant, value: *const Variant) Error!void {
    var valid: u8 = 0;

    raw.variant_set(self.ptr(), key.constPtr(), value.constPtr(), &valid);

    if (valid == 0) {
        return error.InvalidKey;
    }
}

pub fn variantSetNamed(self: *Variant, key: *const StringName, value: *const Variant) bool {
    var valid: u8 = 0;
    raw.variant_set_named(self.ptr(), key.constPtr(), value.constPtr(), &valid);
    return valid != 0;
}

pub fn variantSetKeyed(self: *Variant, key: *const Variant, value: *const Variant) bool {
    var valid: u8 = 0;
    raw.variant_set_keyed(self.ptr(), key.constPtr(), value.constPtr(), &valid);
    return valid != 0;
}

pub fn variantGetNamed(self: *const Variant, key: *const StringName) ?Variant {
    var result: Variant = undefined;
    var valid: u8 = 0;

    raw.variant_get_named(self.constPtr(), key.constPtr(), result.ptr(), &valid);

    if (valid == 0) {
        return null;
    }

    return result;
}

pub fn variantGetKeyed(self: *const Variant, key: *const Variant) ?Variant {
    var result: Variant = undefined;
    var valid: c.GDExtensionBool = 0;

    raw.variant_get_keyed(self.constPtr(), key.constPtr(), result.ptr(), &valid);

    if (valid == 0) {
        return null;
    }

    return result;
}

pub fn variantGetIndexed(self: *const Variant, index: i64) Error!Variant {
    var result: Variant = undefined;
    var valid: u8 = 0;
    var oob: u8 = 0;

    raw.variant_get_indexed(self.constPtr(), index, @ptrCast(&result), &valid, &oob);

    if (valid == 0) {
        return error.InvalidOperation;
    }
    if (oob != 0) {
        return error.IndexOutOfBounds;
    }

    return result;
}

pub fn variantSetIndexed(self: *Variant, index: i64, value: *const Variant) Error!void {
    var valid: u8 = 0;
    var oob: u8 = 0;

    raw.variant_set_indexed(self.ptr(), index, value.constPtr(), &valid, &oob);

    if (valid == 0) {
        return error.InvalidOperation;
    }
    if (oob != 0) {
        return error.IndexOutOfBounds;
    }
}

pub fn variantHasMethod(self: *const Variant, method: *const StringName) bool {
    return raw.variant_has_method(self.constPtr(), method.constPtr()) != 0;
}

pub fn variantHasKey(self: *const Variant, key: *const Variant) !bool {
    var valid: u8 = 0;

    const result = raw.variant_has_key(self.constPtr(), key.constPtr(), &valid);

    if (valid == 0) {
        return error.InvalidOperation;
    }

    return result != 0;
}

pub fn variantHash(self: *const Variant) i64 {
    return raw.variant_hash(self.constPtr());
}

pub fn variantHashCompare(self: *const Variant, other: *const Variant) bool {
    return raw.variant_hash_compare(self.constPtr(), other.constPtr()) != 0;
}

pub fn variantRecursiveHash(self: *const Variant, recursion_count: i64) i64 {
    return raw.variant_recursive_hash(self.constPtr(), recursion_count);
}

pub fn variantGetObjectInstanceId(self: *const Variant) ObjectID {
    return @enumFromInt(raw.variant_get_object_instance_id(self.constPtr()));
}

pub fn variantBooleanize(self: *const Variant) bool {
    return raw.variant_booleanize(self.constPtr()) != 0;
}

pub fn variantDuplicate(self: *const Variant, deep: bool) Variant {
    var result: Variant = undefined;
    raw.variant_duplicate(self.constPtr(), result.ptr(), @intFromBool(deep));
    return result;
}

pub fn variantStringify(self: *const Variant) String {
    var result: String = undefined;
    raw.variant_stringify(self.constPtr(), result.ptr());
    return result;
}

// String operations
pub fn stringOperatorPlusEqString(self: *String, other: *const String) void {
    raw.string_operator_plus_eq_string(self.ptr(), other.constPtr());
}

pub fn stringOperatorPlusEqChar(self: *String, ch: u32) void {
    raw.string_operator_plus_eq_char(self.ptr(), ch);
}

pub fn stringOperatorPlusEqCstr(self: *String, cstr: [*:0]const u8) void {
    raw.string_operator_plus_eq_cstr(self.ptr(), cstr);
}

pub fn stringResize(self: *String, new_size: i64) void {
    raw.string_resize(self.ptr(), new_size);
}

pub fn stringNewWithLatin1Chars(cstr: [*:0]const u8) String {
    var result: String = undefined;
    raw.string_new_with_latin1_chars(result.ptr(), cstr);
    return result;
}

pub fn stringNewWithLatin1(cstr: []const u8) String {
    var result: String = undefined;
    raw.string_new_with_latin1_chars_and_len(result.ptr(), cstr.ptr, cstr.len);
    return result;
}

pub fn stringNewWithUtf8_2(cstr: []const u8) String {
    var result: String = undefined;
    raw.string_new_with_utf8_chars_and_len2(result.ptr(), cstr.ptr, cstr.len);
    return result;
}

pub fn stringNewWithUtf16(utf16: []const u16) String {
    var result: String = undefined;
    raw.string_new_with_utf16_chars_and_len(result.ptr(), utf16.ptr, utf16.len);
    return result;
}

pub fn stringNewWithUtf16_2(utf16: []const u16, default_little_endian: bool) String {
    var result: String = undefined;
    raw.string_new_with_utf16_chars_and_len2(result.ptr(), utf16.ptr, utf16.len, @intFromBool(default_little_endian));
    return result;
}

pub fn stringNewWithUtf32(utf32: []const u32) String {
    var result: String = undefined;
    raw.string_new_with_utf32_chars_and_len(result.ptr(), utf32.ptr, utf32.len);
    return result;
}

pub fn stringNewWithWide(wcstr: []const c.wchar_t) String {
    var result: String = undefined;
    raw.string_new_with_wide_chars_and_len(result.ptr(), wcstr.ptr, wcstr.len);
    return result;
}

pub fn stringNewWithWideChars(wcstr: [*:0]const c.wchar_t) String {
    var result: String = undefined;
    raw.string_new_with_wide_chars(result.ptr(), wcstr);
    return result;
}

pub fn stringToLatin1Chars(self: *const String, buffer: []u8) i64 {
    return raw.string_to_latin1_chars(self.constPtr(), buffer.ptr, buffer.len);
}

pub fn stringToWideChars(self: *const String, buffer: []c.wchar_t) i64 {
    return raw.string_to_wide_chars(self.constPtr(), buffer.ptr, buffer.len);
}

pub fn stringOperatorPlusEqWcstr(self: *String, wcstr: [*:0]const c.wchar_t) void {
    raw.string_operator_plus_eq_wcstr(self.ptr(), wcstr);
}

pub fn stringOperatorPlusEqC32str(self: *String, c32str: [*:0]const u32) void {
    raw.string_operator_plus_eq_c32str(self.ptr(), c32str);
}

pub fn stringToUtf16Chars(self: *const String, buffer: []u16) i64 {
    return raw.string_to_utf16_chars(self.constPtr(), buffer.ptr, buffer.len);
}

pub fn stringToUtf32Chars(self: *const String, buffer: []u32) i64 {
    return raw.string_to_utf32_chars(self.constPtr(), buffer.ptr, buffer.len);
}

// Object operations
pub fn objectGetClassName(object: *const Object) StringName {
    var result: StringName = undefined;
    raw.object_get_class_name(object.constPtr(), raw.get_library_path, result.ptr());
    return result;
}

pub fn objectCastTo(object: *const Object, class_tag: *ClassTag) ?*Object {
    return @ptrCast(raw.object_cast_to(object.constPtr(), class_tag));
}

pub fn objectHasScriptMethod(object: *const Object, method: *const StringName) bool {
    return raw.object_has_script_method(object.constPtr(), method.constPtr()) != 0;
}

pub fn objectCallScriptMethod(object: *Object, method: *const StringName, args: []const *const Variant) CallError!Variant {
    var ret: Variant = undefined;
    var result: CallResult = undefined;

    raw.object_call_script_method(object.ptr(), method.constPtr(), @ptrCast(args.ptr), @intCast(args.len), ret.ptr(), &result);

    try result.throw();

    return ret;
}

pub fn objectSetInstance(object: *Object, class_name: *const StringName, instance: ?*anyopaque) void {
    raw.object_set_instance(object.ptr(), class_name.constPtr(), instance);
}

pub fn objectGetInstanceBinding(object: *Object, callbacks: ?*const InstanceBindingCallbacks) ?*anyopaque {
    return raw.object_get_instance_binding(object.ptr(), raw.library.ptr(), callbacks);
}

pub fn objectSetInstanceBinding(object: *Object, binding: *anyopaque, callbacks: ?*const InstanceBindingCallbacks) void {
    raw.object_set_instance_binding(object.ptr(), raw.library.ptr(), binding, callbacks);
}

pub fn objectFreeInstanceBinding(object: *Object) void {
    raw.object_free_instance_binding(object.ptr(), raw.library.ptr());
}

// Ref operations
pub fn refGetObject(ref: *const RefCounted) ?*Object {
    return @ptrCast(raw.ref_get_object(ref.constPtr()));
}

pub fn refSetObject(ref: *RefCounted, object: ?*Object) void {
    raw.ref_set_object(ref.ptr(), if (object) |o| o.ptr() else null);
}

// ClassDB operations
pub fn classdbConstructObject(class_name: *const StringName) ?*Object {
    return @ptrCast(raw.classdb_construct_object(class_name.constPtr()));
}

pub fn classdbConstructObject2(class_name: *const StringName) ?*Object {
    return @ptrCast(raw.classdb_construct_object2(class_name.constPtr()));
}

pub fn classdbGetClassTag(class_name: *const StringName) ?*ClassTag {
    return @ptrCast(raw.classdb_get_class_tag(class_name.constPtr()));
}

pub fn classdbRegisterExtensionClassMethod(class_name: *const StringName, method_info: *const ClassMethodInfo) void {
    raw.classdb_register_extension_class_method(raw.ptr(), class_name.constPtr(), method_info);
}

pub fn classdbRegisterExtensionClassProperty(class_name: *const StringName, info: *const PropertyInfo, setter: *const StringName, getter: *const StringName) void {
    raw.classdb_register_extension_class_property(raw.library.ptr(), class_name.constPtr(), info, setter.constPtr(), getter.constPtr());
}

pub fn classdbRegisterExtensionClassSignal(class_name: *const StringName, signal_name: *const StringName, argument_info: []const PropertyInfo) void {
    raw.classdb_register_extension_class_signal(raw.library.ptr(), class_name.constPtr(), signal_name.constPtr(), argument_info.ptr, @intCast(argument_info.len));
}

pub fn classdbUnregisterExtensionClass(class_name: *const StringName) void {
    raw.classdb_unregister_extension_class(raw.library.ptr(), class_name.constPtr());
}

// Editor operations
pub fn editorAddPlugin(class_name: *const StringName) void {
    raw.editor_add_plugin(class_name.constPtr());
}

pub fn editorRemovePlugin(class_name: *const StringName) void {
    raw.editor_remove_plugin(class_name.constPtr());
}

// Callable operations
pub fn callableCustomCreate(info: *CallableCustomInfo2) Callable {
    var result: Callable = undefined;
    raw.callable_custom_create(result.ptr(), info);
    return result;
}

pub fn callableCustomCreate2(info: *CallableCustomInfo2) Callable {
    var result: Callable = undefined;
    raw.callable_custom_create2(result.ptr(), info);
    return result;
}

// Array operations
pub fn arrayRef(self: *Array, from: *const Array) void {
    raw.array_ref(self.ptr(), from.constPtr());
}

pub fn arraySetTyped(self: *Array, var_tag: Variant.Tag, class_name: *const StringName, script: ?*const Variant) void {
    raw.array_set_typed(self.ptr(), @intFromEnum(var_tag), class_name.constPtr(), if (script) |s| s.constPtr() else null);
}

// Dictionary operations
pub fn dictionarySetTyped(
    self: *Array,
    key_tag: Variant.Tag,
    key_class_name: *const StringName,
    key_script: ?*const Variant,
    value_tag: Variant.Tag,
    value_class_name: *const StringName,
    value_script: ?*const Variant,
) void {
    raw.dictionary_set_typed(
        self.ptr(),
        @intFromEnum(key_tag),
        key_class_name.constPtr(),
        if (key_script) |s| s.constPtr() else null,
        @intFromEnum(value_tag),
        value_class_name.constPtr(),
        if (value_script) |s| s.constPtr() else null,
    );
}

// Utility functions
pub fn getGodotVersion() GodotVersion {
    var version: GodotVersion = undefined;
    raw.get_godot_version(&version);
    return version;
}

pub fn getLibraryPath() String {
    var path: String = undefined;
    raw.get_library_path(raw.library.ptr(), @ptrCast(&path));
    return path;
}

pub fn getNativeStructSize(name: *const StringName) usize {
    return @intCast(raw.get_native_struct_size(name.constPtr()));
}

// Script instance functions
pub fn scriptInstanceCreate(info: *const ScriptInstanceInfo, instance_data: *ScriptInstanceData) *ScriptInstance {
    return raw.script_instance_create(info, instance_data);
}

pub fn scriptInstanceCreate2(info: *const ScriptInstanceInfo2, instance_data: *ScriptInstanceData) *ScriptInstance {
    return raw.script_instance_create2(info, instance_data);
}

pub fn scriptInstanceCreate3(info: *const ScriptInstanceInfo3, instance_data: *ScriptInstanceData) *ScriptInstance {
    return raw.script_instance_create3(info, instance_data);
}

pub fn placeholderScriptInstanceCreate(language: *Object, script: *Object, owner: *Object) *ScriptInstance {
    return raw.placeholder_script_instance_create(language.ptr(), script.ptr(), owner.ptr());
}

pub fn placeholderScriptInstanceUpdate(placeholder: *ScriptInstance, properties: *const Array, values: *const Dictionary) void {
    raw.placeholder_script_instance_update(placeholder, properties.constPtr(), values.constPtr());
}

pub fn objectGetScriptInstance(object: *const Object, language: *Object) ?*ScriptInstance {
    return @ptrCast(raw.object_get_script_instance(object.constPtr(), language.ptr()));
}

// Method binding helpers
pub fn objectMethodBindCall(method_bind: *MethodBind, instance: ?*Object, args: []const *const Variant) CallError!Variant {
    var ret: Variant = undefined;
    var err: CallResult = undefined;

    raw.object_method_bind_call(
        method_bind.ptr(),
        if (instance) |i| i.ptr() else null,
        @ptrCast(args.ptr),
        @intCast(args.len),
        ret.ptr(),
        err.ptr(),
    );

    try err.throw();

    return ret;
}

pub fn objectMethodBindPtrcall(method_bind: *MethodBind, instance: ?*Object, args: []const *const anyopaque, ret: ?*anyopaque) void {
    raw.object_method_bind_ptrcall(
        method_bind.ptr(),
        if (instance) |i| i.ptr() else null,
        @ptrCast(args.ptr),
        ret,
    );
}

// Variant constructor helpers
pub fn getVariantFromTypeConstructor(variant_tag: Variant.Tag) c {
    return raw.get_variant_from_type_constructor(@intFromEnum(variant_tag));
}

pub fn getVariantToTypeConstructor(variant_tag: Variant.Tag) c.GDExtensionTypeFromVariantConstructorFunc {
    return raw.get_variant_to_type_constructor(@intFromEnum(variant_tag));
}

pub fn variantGetPtrConstructor(variant_tag: Variant.Tag, constructor: i32) c.GDExtensionPtrConstructor {
    return raw.variant_get_ptr_constructor(@intFromEnum(variant_tag), constructor);
}

pub fn variantGetPtrDestructor(variant_tag: Variant.Tag) c.GDExtensionPtrDestructor {
    return raw.variant_get_ptr_destructor(@intFromEnum(variant_tag));
}

pub fn variantConstruct(variant_tag: Variant.Tag, args: []const *const Variant, constructor: i32) CallError!Variant {
    var ret: Variant = undefined;
    var err: CallResult = undefined;

    raw.variant_construct(
        @intFromEnum(variant_tag),
        @ptrCast(&ret),
        @ptrCast(args.ptr),
        @intCast(constructor),
        &err,
    );

    try err.throw();

    return ret;
}

// Variant property access helpers
pub fn variantGetPtrSetter(variant_tag: Variant.Tag, member: *const StringName) c.GDExtensionPtrSetter {
    return raw.variant_get_ptr_setter(@intFromEnum(variant_tag), member.constPtr());
}

pub fn variantGetPtrGetter(variant_tag: Variant.Tag, member: *const StringName) c.GDExtensionPtrGetter {
    return raw.variant_get_ptr_getter(@intFromEnum(variant_tag), member.constPtr());
}

pub fn variantGetPtrIndexedSetter(variant_tag: Variant.Tag) c.GDExtensionPtrIndexedSetter {
    return raw.variant_get_ptr_indexed_setter(@intFromEnum(variant_tag));
}

pub fn variantGetPtrIndexedGetter(variant_tag: Variant.Tag) c.GDExtensionPtrIndexedGetter {
    return raw.variant_get_ptr_indexed_getter(@intFromEnum(variant_tag));
}

pub fn variantGetPtrKeyedSetter(variant_tag: Variant.Tag) c.GDExtensionPtrKeyedSetter {
    return raw.variant_get_ptr_keyed_setter(@intFromEnum(variant_tag));
}

pub fn variantGetPtrKeyedGetter(variant_tag: Variant.Tag) c.GDExtensionPtrKeyedGetter {
    return raw.variant_get_ptr_keyed_getter(@intFromEnum(variant_tag));
}

pub fn variantGetPtrKeyedChecker(variant_tag: Variant.Tag) c.GDExtensionPtrKeyedChecker {
    return raw.variant_get_ptr_keyed_checker(@intFromEnum(variant_tag));
}

// Variant utility functions
pub fn variantGetConstantValue(variant_tag: Variant.Tag, constant_name: *const StringName) Variant {
    var result: Variant = undefined;
    raw.variant_get_constant_value(@intFromEnum(variant_tag), constant_name.constPtr(), result.ptr());
    return result;
}

pub fn variantGetPtrUtilityFunction(function_name: *const StringName, hash: i64) c.GDExtensionPtrUtilityFunction {
    return raw.variant_get_ptr_utility_function(function_name.constPtr(), hash);
}

// Variant conversion helpers
pub fn variantCanConvert(from: Variant.Tag, to: Variant.Tag) bool {
    return raw.variant_can_convert(@intFromEnum(from), @intFromEnum(to)) != 0;
}

pub fn variantCanConvertStrict(from: Variant.Tag, to: Variant.Tag) bool {
    return raw.variant_can_convert_strict(@intFromEnum(from), @intFromEnum(to)) != 0;
}

// Packed array operator access helpers
pub fn packedByteArrayOperatorIndex(self: *PackedByteArray, index: i64) *u8 {
    return raw.packed_byte_array_operator_index(self.ptr(), index);
}

pub fn packedByteArrayOperatorIndexConst(self: *const PackedByteArray, index: i64) *const u8 {
    return raw.packed_byte_array_operator_index_const(self.constPtr(), index);
}

pub fn packedFloat32ArrayOperatorIndex(self: *PackedFloat32Array, index: i64) *f32 {
    return raw.packed_float32_array_operator_index(self.ptr(), index);
}

pub fn packedFloat32ArrayOperatorIndexConst(self: *const PackedFloat32Array, index: i64) *const f32 {
    return raw.packed_float32_array_operator_index_const(self.constPtr(), index);
}

pub fn packedFloat64ArrayOperatorIndex(self: *PackedFloat64Array, index: i64) *f64 {
    return raw.packed_float64_array_operator_index(self.ptr(), index);
}

pub fn packedFloat64ArrayOperatorIndexConst(self: *const PackedFloat64Array, index: i64) *const f64 {
    return raw.packed_float64_array_operator_index_const(self.constPtr(), index);
}

pub fn packedInt32ArrayOperatorIndex(self: *PackedInt32Array, index: i64) *i32 {
    return raw.packed_int32_array_operator_index(self.ptr(), index);
}

pub fn packedInt32ArrayOperatorIndexConst(self: *const PackedInt32Array, index: i64) *const i32 {
    return raw.packed_int32_array_operator_index_const(self.constPtr(), index);
}

pub fn packedInt64ArrayOperatorIndex(self: *PackedInt64Array, index: i64) *i64 {
    return raw.packed_int64_array_operator_index(self.ptr(), index);
}

pub fn packedInt64ArrayOperatorIndexConst(self: *const PackedInt64Array, index: i64) *const i64 {
    return raw.packed_int64_array_operator_index_const(self.constPtr(), index);
}

pub fn packedStringArrayOperatorIndex(self: *PackedStringArray, index: i64) *String {
    return raw.packed_string_array_operator_index(self.ptr(), index);
}

pub fn packedStringArrayOperatorIndexConst(self: *const PackedStringArray, index: i64) *const String {
    return raw.packed_string_array_operator_index_const(self.constPtr(), index);
}

pub fn packedVector2ArrayOperatorIndex(self: *PackedVector2Array, index: i64) *Vector2 {
    return raw.packed_vector2_array_operator_index(self.ptr(), index);
}

pub fn packedVector2ArrayOperatorIndexConst(self: *const PackedVector2Array, index: i64) *const Vector2 {
    return raw.packed_vector2_array_operator_index_const(self.constPtr(), index);
}

pub fn packedVector3ArrayOperatorIndex(self: *PackedVector3Array, index: i64) *Vector3 {
    return raw.packed_vector3_array_operator_index(self.ptr(), index);
}

pub fn packedVector3ArrayOperatorIndexConst(self: *const PackedVector3Array, index: i64) *const Vector3 {
    return raw.packed_vector3_array_operator_index_const(self.constPtr(), index);
}

pub fn packedVector4ArrayOperatorIndex(self: *PackedVector4Array, index: i64) *Vector4 {
    return raw.packed_vector4_array_operator_index(self.ptr(), index);
}

pub fn packedVector4ArrayOperatorIndexConst(self: *const PackedVector4Array, index: i64) *const Vector4 {
    return raw.packed_vector4_array_operator_index_const(self.constPtr(), index);
}

pub fn packedColorArrayOperatorIndex(self: *PackedColorArray, index: i64) *Color {
    return raw.packed_color_array_operator_index(self.ptr(), index);
}

pub fn packedColorArrayOperatorIndexConst(self: *const PackedColorArray, index: i64) *const Color {
    return raw.packed_color_array_operator_index_const(self.constPtr(), index);
}

// Array and Dictionary operators
pub fn arrayOperatorIndex(self: *Array, index: i64) *Variant {
    return raw.array_operator_index(self.ptr(), index);
}

pub fn arrayOperatorIndexConst(self: *const Array, index: i64) *const Variant {
    return raw.array_operator_index_const(self.constPtr(), index);
}

pub fn dictionaryOperatorIndex(self: *Dictionary, key: *const Variant) *Variant {
    return raw.dictionary_operator_index(self.ptr(), key.constPtr());
}

pub fn dictionaryOperatorIndexConst(self: *const Dictionary, key: *const Variant) *const Variant {
    return raw.dictionary_operator_index_const(self.constPtr(), key.constPtr());
}

// File access helpers
pub fn xmlParserOpenBuffer(parser: *Object, buffer: []const u8) void {
    raw.xml_parser_open_buffer(parser.ptr(), buffer.ptr, buffer.len);
}

pub fn fileAccessStoreBuffer(file: *Object, buffer: []const u8) void {
    raw.file_access_store_buffer(file.ptr(), buffer.ptr, buffer.len);
}

pub fn fileAccessGetBuffer(file: *const Object, buffer: []u8) u64 {
    return raw.file_access_get_buffer(file.constPtr(), buffer.ptr, buffer.len);
}

// Image helpers
pub fn imagePtrw(image: *Object) [*]u8 {
    return raw.image_ptrw(image.ptr());
}

pub fn imagePtr(image: *Object) [*]const u8 {
    return raw.image_ptr(image.ptr());
}

// Worker thread pool helpers
pub fn workerThreadPoolAddNativeGroupTask(
    pool: *Object,
    func: *const fn (userdata: ?*anyopaque, index: u32) callconv(.C) void,
    userdata: ?*anyopaque,
    elements: i32,
    tasks: i32,
    high_priority: bool,
    description: ?*const String,
) void {
    raw.worker_thread_pool_add_native_group_task(
        pool.ptr(),
        func,
        userdata,
        elements,
        tasks,
        @intFromBool(high_priority),
        if (description) |d| d.constPtr() else null,
    );
}

pub fn workerThreadPoolAddNativeTask(
    pool: *Object,
    func: *const fn (userdata: ?*anyopaque) callconv(.C) void,
    userdata: ?*anyopaque,
    high_priority: bool,
    description: ?*const String,
) void {
    raw.worker_thread_pool_add_native_task(
        pool.ptr(),
        func,
        userdata,
        @intFromBool(high_priority),
        if (description) |d| d.constPtr() else null,
    );
}

pub fn classdbRegisterExtensionClass(class_name: *const StringName, parent_class_name: *const StringName, class_info: *const ClassCreationInfo) void {
    raw.classdb_register_extension_class(raw.library.ptr(), class_name.constPtr(), parent_class_name.constPtr(), class_info);
}

pub fn classdbRegisterExtensionClass2(class_name: *const StringName, parent_class_name: *const StringName, class_info: *const ClassCreationInfo2) void {
    raw.classdb_register_extension_class2(raw.library.ptr(), class_name.constPtr(), parent_class_name.constPtr(), class_info);
}

pub fn classdbRegisterExtensionClass3(class_name: *const StringName, parent_class_name: *const StringName, class_info: *const ClassCreationInfo3) void {
    raw.classdb_register_extension_class3(raw.library.ptr(), class_name.constPtr(), parent_class_name.constPtr(), class_info);
}

pub fn classdbRegisterExtensionClass4(class_name: *const StringName, parent_class_name: *const StringName, class_info: *const ClassCreationInfo4) void {
    raw.classdb_register_extension_class4(raw.library.ptr(), class_name.constPtr(), parent_class_name.constPtr(), class_info);
}

// Variant type helpers
pub fn variantGetTypeName(variant_tag: Variant.Tag) String {
    var result: String = undefined;
    raw.variant_get_type_name(@intFromEnum(variant_tag), result.ptr());
    return result;
}

pub fn variantHasMember(variant_tag: Variant.Tag, member: *const StringName) bool {
    return raw.variant_has_member(@intFromEnum(variant_tag), member.constPtr()) != 0;
}

// Variant iterator helpers
pub fn variantIterInit(self: *const Variant) Error!Variant {
    var iter: Variant = undefined;
    var valid: u8 = 0;

    raw.variant_iter_init(self.constPtr(), iter.ptr(), &valid);

    if (valid == 0) {
        return error.IteratorInitFailed;
    }

    return iter;
}

pub fn variantIterNext(self: *const Variant, iter: *Variant) !bool {
    var valid: u8 = 0;
    const result = raw.variant_iter_next(self.constPtr(), iter.ptr(), &valid);

    if (valid == 0) {
        return error.InvalidIterator;
    }

    return result != 0;
}

pub fn variantIterGet(self: *const Variant, iter: *Variant) Error!Variant {
    var result: Variant = undefined;
    var valid: u8 = 0;

    raw.variant_iter_get(self.constPtr(), iter.ptr(), @ptrCast(&result), &valid);

    if (valid == 0) {
        return error.InvalidIterator;
    }

    return result;
}

// Editor help functions
pub fn editorHelpLoadXmlFromUtf8(data: []const u8) void {
    raw.editor_help_load_xml_from_utf8_chars_and_len(data.ptr, data.len);
}

pub fn editorHelpLoadXmlFromUtf8Chars(data: [*:0]const u8) void {
    raw.editor_help_load_xml_from_utf8_chars(data);
}

// Variant operator evaluation helper
pub fn variantGetPtrOperatorEvaluator(op: Variant.Operator, tag_a: Variant.Tag, tag_b: Variant.Tag) c.GDExtensionPtrOperatorEvaluator {
    return raw.variant_get_ptr_operator_evaluator(@intFromEnum(op), @intFromEnum(tag_a), @intFromEnum(tag_b));
}

// Variant builtin method helper
pub fn variantGetPtrBuiltinMethod(variant_tag: Variant.Tag, method: *const StringName, hash: i64) c.GDExtensionPtrBuiltInMethod {
    return raw.variant_get_ptr_builtin_method(@intFromEnum(variant_tag), method.constPtr(), hash);
}

// Convenience function for getting variant internal pointer

// String operator helpers
pub fn stringOperatorIndex(self: *String, index: i64) *u32 {
    return raw.string_operator_index(self.ptr(), index);
}

pub fn stringOperatorIndexConst(self: *const String, index: i64) *const u32 {
    return raw.string_operator_index_const(self.constPtr(), index);
}

// Callable custom user data helper
pub fn callableCustomGetUserData(callable: *const Callable) ?*anyopaque {
    return raw.callable_custom_get_user_data(callable.constPtr(), raw.library);
}

// Virtual method registration helper
pub fn classdbRegisterExtensionClassVirtualMethod(class_name: *const StringName, method_info: *const ClassVirtualMethodInfo) void {
    raw.classdb_register_extension_class_virtual_method(raw.library.ptr(), class_name.constPtr(), method_info);
}

// Integer constant registration helper
pub fn classdbRegisterExtensionClassIntegerConstant(class_name: *const StringName, enum_name: ?*const StringName, constant_name: *const StringName, constant_value: i64, is_bitfield: bool) void {
    raw.classdb_register_extension_class_integer_constant(
        raw.library.ptr(),
        class_name.constPtr(),
        if (enum_name) |e| e.constPtr() else null,
        constant_name.constPtr(),
        constant_value,
        @intFromBool(is_bitfield),
    );
}

// Property group registration helpers
pub fn classdbRegisterExtensionClassPropertyGroup(class_name: *const StringName, group_name: *const String, prefix: *const String) void {
    raw.classdb_register_extension_class_property_group(raw.library.ptr(), class_name.constPtr(), group_name.constPtr(), prefix.constPtr());
}

pub fn classdbRegisterExtensionClassPropertySubgroup(class_name: *const StringName, subgroup_name: *const String, prefix: *const String) void {
    raw.classdb_register_extension_class_property_subgroup(raw.library.ptr(), class_name.constPtr(), subgroup_name.constPtr(), prefix.constPtr());
}

// Property indexed registration helper
pub fn classdbRegisterExtensionClassPropertyIndexed(class_name: *const StringName, info: *const PropertyInfo, setter: *const StringName, getter: *const StringName, index: i64) void {
    raw.classdb_register_extension_class_property_indexed(raw.library.ptr(), class_name.constPtr(), info, setter.constPtr(), getter.constPtr(), index);
}

pub fn getVariantGetInternalPtrFunc(variant_tag: Variant.Tag) ?c.GDExtensionVariantGetInternalPtrFunc {
    return raw.get_variant_get_internal_ptr_func(@intFromEnum(variant_tag));
}

pub fn stringNewWithUtf16Chars(utf16: [*:0]const u16) String {
    var result: String = undefined;
    raw.string_new_with_utf16_chars(result.ptr(), utf16);
    return result;
}

pub fn stringNewWithUtf32Chars(utf32: [*:0]const u32) String {
    var result: String = undefined;
    raw.string_new_with_utf32_chars(result.ptr(), utf32);
    return result;
}

const std = @import("std");

const c = @import("gdextension");

const builtin = @import("./builtin.zig");
const Array = builtin.Array;
const Callable = builtin.Callable;
const Color = builtin.Color;
const Dictionary = builtin.Dictionary;
const PackedByteArray = builtin.PackedByteArray;
const PackedInt32Array = builtin.PackedInt32Array;
const PackedInt64Array = builtin.PackedInt64Array;
const PackedFloat32Array = builtin.PackedFloat32Array;
const PackedFloat64Array = builtin.PackedFloat64Array;
const PackedStringArray = builtin.PackedStringArray;
const PackedVector2Array = builtin.PackedVector2Array;
const PackedVector3Array = builtin.PackedVector3Array;
const PackedColorArray = builtin.PackedColorArray;
const PackedVector4Array = builtin.PackedVector4Array;
const String = builtin.String;
const StringName = builtin.StringName;
const Variant = builtin.Variant;
const Vector2 = builtin.Vector2;
const Vector3 = builtin.Vector3;
const Vector4 = builtin.Vector4;
const class = @import("./class.zig");
const Object = class.Object;
const RefCounted = class.RefCounted;
