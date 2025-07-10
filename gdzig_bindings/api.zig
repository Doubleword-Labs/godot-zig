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

// Memory management
/// Allocates memory.
///
/// @param size The amount of memory to allocate in bytes.
///
/// @return A pointer to the allocated memory, or NULL if unsuccessful.
///
/// @since 4.1
pub fn memAlloc(size: usize) *anyopaque {
    return raw.memAlloc(size).?;
}

/// Reallocates memory.
///
/// @param ptr A pointer to the previously allocated memory.
/// @param size The number of bytes to resize the memory block to.
///
/// @return A pointer to the allocated memory, or NULL if unsuccessful.
///
/// @since 4.1
pub fn memRealloc(ptr: *anyopaque, size: usize) *anyopaque {
    return raw.memRealloc(ptr, size).?;
}

/// Frees memory.
///
/// @param ptr A pointer to the previously allocated memory.
///
/// @since 4.1
pub fn memFree(ptr: *anyopaque) void {
    raw.memFree(ptr);
}

// Error reporting
/// Logs an error to Godot's built-in debugger and to the OS terminal.
///
/// @param description The code triggering the error.
/// @param function The function name where the error occurred.
/// @param file The file where the error occurred.
/// @param line The line where the error occurred.
/// @param editor_notify Whether or not to notify the editor.
///
/// @since 4.1
pub fn printError(description: [*:0]const u8, function: [*:0]const u8, file: [*:0]const u8, line: i32, editor_notify: bool) void {
    raw.printError(description, function, file, line, @intFromBool(editor_notify));
}

/// Logs a warning to Godot's built-in debugger and to the OS terminal.
///
/// @param description The code triggering the warning.
/// @param function The function name where the warning occurred.
/// @param file The file where the warning occurred.
/// @param line The line where the warning occurred.
/// @param editor_notify Whether or not to notify the editor.
///
/// @since 4.1
pub fn printWarning(description: [*:0]const u8, function: [*:0]const u8, file: [*:0]const u8, line: i32, editor_notify: bool) void {
    raw.printWarning(description, function, file, line, @intFromBool(editor_notify));
}

/// Logs an error with a message to Godot's built-in debugger and to the OS terminal.
///
/// @param description The code triggering the error.
/// @param message The message to show along with the error.
/// @param function The function name where the error occurred.
/// @param file The file where the error occurred.
/// @param line The line where the error occurred.
/// @param editor_notify Whether or not to notify the editor.
///
/// @since 4.1
pub fn printErrorWithMessage(description: [*:0]const u8, message: [*:0]const u8, function: [*:0]const u8, file: [*:0]const u8, line: i32, editor_notify: bool) void {
    raw.printErrorWithMessage(description, message, function, file, line, @intFromBool(editor_notify));
}

/// Logs a warning with a message to Godot's built-in debugger and to the OS terminal.
///
/// @param description The code triggering the warning.
/// @param message The message to show along with the warning.
/// @param function The function name where the warning occurred.
/// @param file The file where the warning occurred.
/// @param line The line where the warning occurred.
/// @param editor_notify Whether or not to notify the editor.
///
/// @since 4.1
pub fn printWarningWithMessage(description: [*:0]const u8, message: [*:0]const u8, function: [*:0]const u8, file: [*:0]const u8, line: i32, editor_notify: bool) void {
    raw.printWarningWithMessage(description, message, function, file, line, @intFromBool(editor_notify));
}

/// Logs a script error to Godot's built-in debugger and to the OS terminal.
///
/// @param description The code triggering the error.
/// @param function The function name where the error occurred.
/// @param file The file where the error occurred.
/// @param line The line where the error occurred.
/// @param editor_notify Whether or not to notify the editor.
///
/// @since 4.1
pub fn printScriptError(description: [*:0]const u8, function: [*:0]const u8, file: [*:0]const u8, line: i32, editor_notify: bool) void {
    raw.printScriptError(description, function, file, line, @intFromBool(editor_notify));
}

/// Logs a script error with a message to Godot's built-in debugger and to the OS terminal.
///
/// @param description The code triggering the error.
/// @param message The message to show along with the error.
/// @param function The function name where the error occurred.
/// @param file The file where the error occurred.
/// @param line The line where the error occurred.
/// @param editor_notify Whether or not to notify the editor.
///
/// @since 4.1
pub fn printScriptErrorWithMessage(description: [*:0]const u8, message: [*:0]const u8, function: [*:0]const u8, file: [*:0]const u8, line: i32, editor_notify: bool) void {
    raw.printScriptErrorWithMessage(description, message, function, file, line, @intFromBool(editor_notify));
}

// Variant helpers
/// Creates a new Variant containing nil.
///
/// @return A new nil Variant.
///
/// @since 4.1
pub fn variantNewNil() Variant {
    var result: Variant = undefined;
    raw.variantNewNil(result.ptr());
    return result;
}

/// Copies one Variant into a another.
///
/// @param src A pointer to the source Variant.
///
/// @return A new copy of the Variant.
///
/// @since 4.1
pub fn variantNewCopy(src: *const Variant) Variant {
    var result: Variant = undefined;
    raw.variantNewCopy(result.ptr(), src);
    return result;
}

/// Destroys a Variant.
///
/// @param self A pointer to the Variant to destroy.
///
/// @since 4.1
pub fn variantDestroy(variant: *Variant) void {
    raw.variantDestroy(variant);
}

/// Gets the type of a Variant.
///
/// @param self A pointer to the Variant.
///
/// @return The variant type.
///
/// @since 4.1
pub fn variantGetType(variant: *const Variant) Variant.Tag {
    return @enumFromInt(raw.variantGetType(variant));
}

// String helpers

/// Creates a String from a UTF-8 encoded C string.
///
/// @param str A pointer to a UTF-8 encoded C string (null terminated).
///
/// @return The newly created String.
///
/// @since 4.1
pub fn stringNewWithUtf8Chars(str: [*:0]const u8) String {
    var string: String = undefined;
    raw.stringNewWithUtf8Chars(string.ptr(), str);
    return string;
}

/// **Deprecated** in Godot 4.3. Use `stringNewWithUtf8_2` instead.
///
/// Creates a String from a UTF-8 encoded C string with the given length.
///
/// @param str A slice of UTF-8 encoded bytes.
///
/// @return The newly created String.
///
/// @since 4.1
pub fn stringNewWithUtf8(str: []const u8) String {
    var string: String = undefined;
    raw.stringNewWithUtf8CharsAndLen(string.ptr(), str.ptr, str.len);
    return string;
}

/// Converts a String to a UTF-8 encoded C string.
///
/// It doesn't write a null terminator.
///
/// @param string A pointer to the String.
/// @param buffer A slice to hold the resulting data.
///
/// @return The resulting encoded string length in characters (not bytes), not including a null terminator.
///
/// @since 4.1
pub fn stringToUtf8Chars(string: *const String, buffer: []u8) i64 {
    return raw.stringToUtf8Chars(string.constPtr(), buffer.ptr, buffer.len);
}

// StringName helpers

/// Creates a StringName from a Latin-1 encoded C string.
///
/// If `is_static` is true, then:
/// - The StringName will reuse the `p_contents` buffer instead of copying it.
///   You must guarantee that the buffer remains valid for the duration of the application (e.g. string literal).
/// - You must not call a destructor for this StringName. Incrementing the initial reference once should achieve this.
///
/// @param str A pointer to a Latin-1 encoded C string (null terminated).
/// @param is_static If true, the StringName will reuse the buffer instead of copying it.
///
/// @return The newly created StringName.
///
/// @since 4.2
pub fn stringNameNewWithLatin1Chars(str: [*:0]const u8, is_static: bool) StringName {
    var string_name: StringName = undefined;
    raw.stringNameNewWithLatin1Chars(string_name.ptr(), str, is_static != 0);
    return string_name;
}

/// Creates a StringName from a UTF-8 encoded C string.
///
/// @param str A pointer to a C string (null terminated and UTF-8 encoded).
///
/// @return The newly created StringName.
///
/// @since 4.2
pub fn stringNameNewWithUtf8Chars(str: [*:0]const u8) StringName {
    var string_name: StringName = undefined;
    raw.stringNameNewWithUtf8Chars(string_name.ptr(), str);
    return string_name;
}

pub fn stringNameNewWithUtf8(str: []const u8) StringName {
    var string_name: StringName = undefined;
    raw.stringNameNewWithUtf8CharsAndLen(string_name.ptr(), str.ptr, str.len);
    return string_name;
}

// Object helpers
/// Gets the instance ID from an Object.
///
/// @param obj A pointer to the Object.
///
/// @return The instance ID.
///
/// @since 4.1
pub fn objectGetInstanceId(obj: *const Object) ObjectID {
    return raw.objectGetInstanceId(obj);
}

/// Gets an Object by its instance ID.
///
/// @param instance_id The instance ID.
///
/// @return A pointer to the Object, or null if it can't be found.
///
/// @since 4.1
pub fn objectGetInstanceFromId(id: ObjectID) ?*Object {
    return @ptrCast(raw.objectGetInstanceFromId(id));
}

/// Destroys an Object.
///
/// @param obj A pointer to the Object.
///
/// @since 4.1
pub fn objectDestroy(obj: *Object) void {
    raw.objectDestroy(obj);
}

// Singleton access
/// Gets a global singleton by name.
///
/// @param name A pointer to a StringName with the singleton name.
///
/// @return A pointer to the singleton Object.
///
/// @since 4.1
pub fn globalGetSingleton(name: *const StringName) ?*Object {
    return @ptrCast(raw.globalGetSingleton(name.constPtr()));
}

// Method binding
/// Gets a pointer to the MethodBind in ClassDB for the given class, method and hash.
///
/// @param classname A pointer to a StringName with the class name.
/// @param methodname A pointer to a StringName with the method name.
/// @param hash A hash representing the function signature.
///
/// @return A pointer to the MethodBind from ClassDB.
///
/// @since 4.1
pub fn classdbGetMethodBind(class_name: *const StringName, method_name: *const StringName, hash: i64) ?*MethodBind {
    const ptr = raw.classdbGetMethodBind(class_name.constPtr(), method_name.constPtr(), hash);
    return ptr;
}

// Variant operations
/// Calls a method on a Variant.
///
/// @param self A pointer to the Variant.
/// @param method A pointer to a StringName with the method name.
/// @param args A slice of Variant pointers representing the arguments.
///
/// @return The return value from the method call.
///
/// @see Variant::callp()
///
/// @since 4.1
pub fn variantCall(self: *Variant, method: *const StringName, args: []const *const Variant) CallError!Variant {
    var ret: Variant = undefined;
    var result: CallResult = undefined;

    raw.variantCall(self.ptr(), method.constPtr(), @ptrCast(args.ptr), @intCast(args.len), @ptrCast(&ret), &result);

    try result.throw();

    return ret;
}

/// Calls a static method on a Variant.
///
/// @param variant_tag The type of Variant to call the static method on.
/// @param method A pointer to a StringName identifying the method.
/// @param args A slice of Variant pointers representing the arguments.
///
/// @return The return value from the static method call.
///
/// @see Variant::call_static()
///
/// @since 4.1
pub fn variantCallStatic(variant_tag: Variant.Tag, method: *const StringName, args: []const *const Variant) CallError!Variant {
    var ret: Variant = undefined;
    var result: CallResult = undefined;

    raw.variantCallStatic(@intFromEnum(variant_tag), method.constPtr(), @ptrCast(args.ptr), @intCast(args.len), ret.ptr(), &result);

    try result.throw();

    return ret;
}

/// Evaluate an operator on two Variants.
///
/// @param op The operator to evaluate.
/// @param a The first Variant.
/// @param b The second Variant.
///
/// @return The result of the operation. Returns an error if the operation is invalid.
///
/// @see Variant::evaluate()
///
/// @since 4.1
pub fn variantEvaluate(op: Variant.Operator, a: *const Variant, b: *const Variant) Error!Variant {
    var result: Variant = undefined;
    var valid: u8 = 0;

    raw.variantEvaluate(@intFromEnum(op), a.constPtr(), b.constPtr(), result.ptr(), &valid);

    if (valid == 0) {
        return error.InvalidOperation;
    }

    return result;
}

/// Gets the value of a key from a Variant.
///
/// @param self A pointer to the Variant.
/// @param key A pointer to a Variant representing the key.
///
/// @return The value for the given key. Returns an error if the key is invalid.
///
/// @since 4.1
pub fn variantGet(self: *const Variant, key: *const Variant) Error!Variant {
    var result: Variant = undefined;
    var valid: u8 = 0;

    raw.variantGet(self.constPtr(), key.constPtr(), result.ptr(), &valid);

    if (valid == 0) {
        return error.InvalidOperation;
    }

    return result;
}

/// Sets a key on a Variant to a value.
///
/// @param self A pointer to the Variant.
/// @param key A pointer to a Variant representing the key.
/// @param value A pointer to a Variant representing the value.
///
/// @see Variant::set()
///
/// @since 4.1
pub fn variantSet(self: *Variant, key: *const Variant, value: *const Variant) Error!void {
    var valid: u8 = 0;

    raw.variantSet(self.ptr(), key.constPtr(), value.constPtr(), &valid);

    if (valid == 0) {
        return error.InvalidOperation;
    }
}

/// Sets a named key on a Variant to a value.
///
/// @param self A pointer to the Variant.
/// @param key A pointer to a StringName representing the key.
/// @param value A pointer to a Variant representing the value.
///
/// @see Variant::set_named()
///
/// @since 4.1
pub fn variantSetNamed(self: *Variant, key: *const StringName, value: *const Variant) Error!void {
    var valid: u8 = 0;
    raw.variantSetNamed(self.ptr(), key.constPtr(), value.constPtr(), &valid);
    if (valid == 0) {
        return error.InvalidOperation;
    }
}

/// Sets a keyed property on a Variant to a value.
///
/// @param self A pointer to the Variant.
/// @param key A pointer to a Variant representing the key.
/// @param value A pointer to a Variant representing the value.
///
/// @see Variant::set_keyed()
///
/// @since 4.1
pub fn variantSetKeyed(self: *Variant, key: *const Variant, value: *const Variant) Error!void {
    var valid: u8 = 0;
    raw.variantSetKeyed(self.ptr(), key.constPtr(), value.constPtr(), &valid);
    if (valid == 0) {
        return error.InvalidOperation;
    }
}

/// Gets the value of a named key from a Variant.
///
/// @param self A pointer to the Variant.
/// @param key A pointer to a StringName representing the key.
///
/// @return The value for the given key, or null if the operation is invalid.
///
/// @since 4.1
pub fn variantGetNamed(self: *const Variant, key: *const StringName) ?Variant {
    var result: Variant = undefined;
    var valid: u8 = 0;

    raw.variantGetNamed(self.constPtr(), key.constPtr(), result.ptr(), &valid);

    if (valid == 0) {
        return null;
    }

    return result;
}

/// Gets the value of a keyed property from a Variant.
///
/// @param self A pointer to the Variant.
/// @param key A pointer to a Variant representing the key.
///
/// @return The value for the given key, or null if the operation is invalid.
///
/// @since 4.1
pub fn variantGetKeyed(self: *const Variant, key: *const Variant) ?Variant {
    var result: Variant = undefined;
    var valid: c.GDExtensionBool = 0;

    raw.variantGetKeyed(self.constPtr(), key.constPtr(), result.ptr(), &valid);

    if (valid == 0) {
        return null;
    }

    return result;
}

/// Gets the value of an index from a Variant.
///
/// @param self A pointer to the Variant.
/// @param index The index.
///
/// @return The value at the given index. Returns an error if the operation is invalid or the index is out of bounds.
///
/// @since 4.1
pub fn variantGetIndexed(self: *const Variant, index: i64) Error!Variant {
    var result: Variant = undefined;
    var valid: u8 = 0;
    var oob: u8 = 0;

    raw.variantGetIndexed(self.constPtr(), index, @ptrCast(&result), &valid, &oob);

    if (valid == 0) {
        return error.InvalidOperation;
    }
    if (oob != 0) {
        return error.IndexOutOfBounds;
    }

    return result;
}

/// Sets an index on a Variant to a value.
///
/// @param self A pointer to the Variant.
/// @param index The index.
/// @param value A pointer to a Variant representing the value.
///
/// @since 4.1
pub fn variantSetIndexed(self: *Variant, index: i64, value: *const Variant) Error!void {
    var valid: u8 = 0;
    var oob: u8 = 0;

    raw.variantSetIndexed(self.ptr(), index, value.constPtr(), &valid, &oob);

    if (valid == 0) {
        return error.InvalidOperation;
    }
    if (oob != 0) {
        return error.IndexOutOfBounds;
    }
}

/// Checks if a Variant has the given method.
///
/// @param self A pointer to the Variant.
/// @param method A pointer to a StringName with the method name.
///
/// @return true if the method exists; otherwise false.
///
/// @since 4.1
pub fn variantHasMethod(self: *const Variant, method: *const StringName) bool {
    return raw.variantHasMethod(self.constPtr(), method.constPtr()) != 0;
}

/// Checks if a Variant has a key.
///
/// @param self A pointer to the Variant.
/// @param key A pointer to a Variant representing the key.
///
/// @return true if the key exists; otherwise false. Returns an error if the check was invalid.
///
/// @since 4.1
pub fn variantHasKey(self: *const Variant, key: *const Variant) !bool {
    var valid: u8 = 0;

    const result = raw.variantHasKey(self.constPtr(), key.constPtr(), &valid);

    if (valid == 0) {
        return error.InvalidOperation;
    }

    return result != 0;
}

/// Gets the hash of a Variant.
///
/// @param self A pointer to the Variant.
///
/// @return The hash value.
///
/// @see Variant::hash()
///
/// @since 4.1
pub fn variantHash(self: *const Variant) i64 {
    return raw.variantHash(self.constPtr());
}

/// Compares two Variants by their hash.
///
/// @param self A pointer to the Variant.
/// @param other A pointer to the other Variant to compare it to.
///
/// @return true if the variants are equal by hash comparison; otherwise false.
///
/// @see Variant::hash_compare()
///
/// @since 4.1
pub fn variantHashCompare(self: *const Variant, other: *const Variant) bool {
    return raw.variantHashCompare(self.constPtr(), other.constPtr()) != 0;
}

/// Gets the recursive hash of a Variant.
///
/// @param self A pointer to the Variant.
/// @param recursion_count The recursion count.
///
/// @return The hash value.
///
/// @see Variant::recursive_hash()
///
/// @since 4.1
pub fn variantRecursiveHash(self: *const Variant, recursion_count: i64) i64 {
    return raw.variantRecursiveHash(self.constPtr(), recursion_count);
}

/// Gets the object instance ID from a variant of type GDEXTENSION_VARIANT_TYPE_OBJECT.
///
/// If the variant isn't of type GDEXTENSION_VARIANT_TYPE_OBJECT, then zero will be returned.
/// The instance ID will be returned even if the object is no longer valid - use `object_get_instance_by_id()` to check if the object is still valid.
///
/// @param self A pointer to the Variant.
///
/// @return The instance ID for the contained object.
///
/// @since 4.4
pub fn variantGetObjectInstanceId(self: *const Variant) ObjectID {
    return @enumFromInt(raw.variantGetObjectInstanceId(self.constPtr()));
}

/// Converts a Variant to a boolean.
///
/// @param self A pointer to the Variant.
///
/// @return The boolean value of the Variant.
///
/// @since 4.1
pub fn variantBooleanize(self: *const Variant) bool {
    return raw.variantBooleanize(self.constPtr()) != 0;
}

/// Duplicates a Variant.
///
/// @param self A pointer to the Variant.
/// @param deep Whether or not to duplicate deeply (when supported by the Variant type).
///
/// @return The duplicated Variant.
///
/// @since 4.1
pub fn variantDuplicate(self: *const Variant, deep: bool) Variant {
    var result: Variant = undefined;
    raw.variantDuplicate(self.constPtr(), result.ptr(), @intFromBool(deep));
    return result;
}

/// Converts a Variant to a string.
///
/// @param self A pointer to the Variant.
///
/// @return The string representation.
///
/// @since 4.1
pub fn variantStringify(self: *const Variant) String {
    var result: String = undefined;
    raw.variantStringify(self.constPtr(), result.ptr());
    return result;
}

// String operations
/// Appends another String to a String.
///
/// @param self A pointer to the String.
/// @param other A pointer to the other String to append.
///
/// @since 4.1
pub fn stringOperatorPlusEqString(self: *String, other: *const String) void {
    raw.stringOperatorPlusEqString(self.ptr(), other.constPtr());
}

/// Appends a character to a String.
///
/// @param self A pointer to the String.
/// @param ch The character to append.
///
/// @since 4.1
pub fn stringOperatorPlusEqChar(self: *String, ch: u32) void {
    raw.stringOperatorPlusEqChar(self.ptr(), ch);
}

/// Appends a Latin-1 encoded C string to a String.
///
/// @param self A pointer to the String.
/// @param cstr A Latin-1 encoded C string (null terminated).
///
/// @since 4.1
pub fn stringOperatorPlusEqCstr(self: *String, cstr: [*:0]const u8) void {
    raw.stringOperatorPlusEqCstr(self.ptr(), cstr);
}

/// Resizes the underlying string data to the given number of characters.
///
/// Space needs to be allocated for the null terminating character ('\0') which
/// also must be added manually, in order for all string functions to work correctly.
///
/// Warning: This is an error-prone operation - only use it if there's no other
/// efficient way to accomplish your goal.
///
/// @param self A pointer to the String.
/// @param new_size The new length for the String.
///
/// @since 4.2
pub fn stringResize(self: *String, new_size: i64) void {
    raw.stringResize(self.ptr(), new_size);
}

/// Creates a String from a Latin-1 encoded C string.
///
/// @param str A pointer to a Latin-1 encoded C string (null terminated).
///
/// @return The newly created String.
///
/// @since 4.1
pub fn stringNewWithLatin1Chars(cstr: [*:0]const u8) String {
    var result: String = undefined;
    raw.stringNewWithLatin1Chars(result.ptr(), cstr);
    return result;
}

/// Creates a String from a Latin-1 encoded C string with the given length.
///
/// @param cstr A slice of Latin-1 encoded bytes.
///
/// @return The newly created String.
///
/// @since 4.1
pub fn stringNewWithLatin1(cstr: []const u8) String {
    var result: String = undefined;
    raw.stringNewWithLatin1CharsAndLen(result.ptr(), cstr.ptr, cstr.len);
    return result;
}

/// Creates a String from a UTF-8 encoded C string with the given length.
///
/// @param cstr A slice of UTF-8 encoded bytes.
///
/// @return The newly created String.
///
/// @since 4.3
pub fn stringNewWithUtf8_2(cstr: []const u8) String {
    var result: String = undefined;
    raw.stringNewWithUtf8CharsAndLen2(result.ptr(), cstr.ptr, cstr.len);
    return result;
}

/// **Deprecated** in Godot 4.3. Use `stringNewWithUtf16_2` instead.
///
/// Creates a String from a UTF-16 encoded C string with the given length.
///
/// @param utf16 A slice of UTF-16 encoded characters.
///
/// @return The newly created String.
///
/// @since 4.1
pub fn stringNewWithUtf16(utf16: []const u16) String {
    var result: String = undefined;
    raw.stringNewWithUtf16CharsAndLen(result.ptr(), utf16.ptr, utf16.len);
    return result;
}

/// Creates a String from a UTF-16 encoded C string with the given length.
///
/// @param utf16 A slice of UTF-16 encoded characters.
/// @param default_little_endian If true, UTF-16 use little endian.
///
/// @return The newly created String.
///
/// @since 4.3
pub fn stringNewWithUtf16_2(utf16: []const u16, default_little_endian: bool) String {
    var result: String = undefined;
    raw.stringNewWithUtf16CharsAndLen2(result.ptr(), utf16.ptr, utf16.len, @intFromBool(default_little_endian));
    return result;
}

/// Creates a String from a UTF-32 encoded C string with the given length.
///
/// @param utf32 A slice of UTF-32 encoded characters.
///
/// @return The newly created String.
///
/// @since 4.1
pub fn stringNewWithUtf32(utf32: []const u32) String {
    var result: String = undefined;
    raw.stringNewWithUtf32CharsAndLen(result.ptr(), utf32.ptr, utf32.len);
    return result;
}

/// Creates a String from a wide C string with the given length.
///
/// @param wcstr A slice of wide characters.
///
/// @return The newly created String.
///
/// @since 4.1
pub fn stringNewWithWide(wcstr: []const c.wchar_t) String {
    var result: String = undefined;
    raw.stringNewWithWideCharsAndLen(result.ptr(), wcstr.ptr, wcstr.len);
    return result;
}

/// Creates a String from a wide string.
///
/// @param wcstr A pointer to a wide C string (null terminated).
///
/// @return The newly created String.
///
/// @since 4.1
pub fn stringNewWithWideChars(wcstr: [*:0]const c.wchar_t) String {
    var result: String = undefined;
    raw.stringNewWithWideChars(result.ptr(), wcstr);
    return result;
}

/// Converts a String to a Latin-1 encoded C string.
///
/// It doesn't write a null terminator.
///
/// @param string A pointer to the String.
/// @param buffer A slice to hold the resulting data.
///
/// @return The resulting encoded string length in characters (not bytes), not including a null terminator.
///
/// @since 4.1
pub fn stringToLatin1Chars(self: *const String, buffer: []u8) i64 {
    return raw.stringToLatin1Chars(self.constPtr(), buffer.ptr, buffer.len);
}

/// Converts a String to a wide C string.
///
/// It doesn't write a null terminator.
///
/// @param string A pointer to the String.
/// @param buffer A slice to hold the resulting data.
///
/// @return The resulting encoded string length in characters (not bytes), not including a null terminator.
///
/// @since 4.1
pub fn stringToWideChars(self: *const String, buffer: []c.wchar_t) i64 {
    return raw.stringToWideChars(self.constPtr(), buffer.ptr, buffer.len);
}

/// Appends a wide C string to a String.
///
/// @param self A pointer to the String.
/// @param wcstr A pointer to a wide C string (null terminated).
///
/// @since 4.1
pub fn stringOperatorPlusEqWcstr(self: *String, wcstr: [*:0]const c.wchar_t) void {
    raw.stringOperatorPlusEqWcstr(self.ptr(), wcstr);
}

/// Appends a UTF-32 encoded C string to a String.
///
/// @param self A pointer to the String.
/// @param c32str A pointer to a UTF-32 encoded C string (null terminated).
///
/// @since 4.1
pub fn stringOperatorPlusEqC32str(self: *String, c32str: [*:0]const u32) void {
    raw.stringOperatorPlusEqC32Str(self.ptr(), c32str);
}

/// Converts a String to a UTF-16 encoded C string.
///
/// It doesn't write a null terminator.
///
/// @param string A pointer to the String.
/// @param buffer A slice to hold the resulting data.
///
/// @return The resulting encoded string length in characters (not bytes), not including a null terminator.
///
/// @since 4.1
pub fn stringToUtf16Chars(self: *const String, buffer: []u16) i64 {
    return raw.stringToUtf16Chars(self.constPtr(), buffer.ptr, buffer.len);
}

/// Converts a String to a UTF-32 encoded C string.
///
/// It doesn't write a null terminator.
///
/// @param string A pointer to the String.
/// @param buffer A slice to hold the resulting data.
///
/// @return The resulting encoded string length in characters (not bytes), not including a null terminator.
///
/// @since 4.1
pub fn stringToUtf32Chars(self: *const String, buffer: []u32) i64 {
    return raw.stringToUtf32Chars(self.constPtr(), buffer.ptr, buffer.len);
}

// Object operations
/// Gets the class name of an Object.
///
/// If the GDExtension wraps the Godot object in an abstraction specific to its class, this is the
/// function that should be used to determine which wrapper to use.
///
/// @param object A pointer to the Object.
///
/// @return The class name as a StringName.
///
/// @since 4.1
pub fn objectGetClassName(object: *const Object) StringName {
    var result: StringName = undefined;
    raw.objectGetClassName(object.constPtr(), raw.getLibraryPath, result.ptr());
    return result;
}

/// Casts an Object to a different type.
///
/// @param object A pointer to the Object.
/// @param class_tag A pointer uniquely identifying a built-in class in the ClassDB.
///
/// @return Returns a pointer to the Object, or null if it can't be cast to the requested type.
///
/// @since 4.1
pub fn objectCastTo(object: *const Object, class_tag: *ClassTag) ?*Object {
    return @ptrCast(raw.objectCastTo(object.constPtr(), class_tag));
}

/// Checks if this object has a script with the given method.
///
/// @param object A pointer to the Object.
/// @param method A pointer to a StringName identifying the method.
///
/// @return true if the object has a script and that script has a method with the given name. Returns false if the object has no script.
///
/// @since 4.3
pub fn objectHasScriptMethod(object: *const Object, method: *const StringName) bool {
    return raw.objectHasScriptMethod(object.constPtr(), method.constPtr()) != 0;
}

/// Call the given script method on this object.
///
/// @param object A pointer to the Object.
/// @param method A pointer to a StringName identifying the method.
/// @param args A slice of Variant pointers representing the arguments.
///
/// @return The return value from the method call.
///
/// @since 4.3
pub fn objectCallScriptMethod(object: *Object, method: *const StringName, args: []const *const Variant) CallError!Variant {
    var ret: Variant = undefined;
    var result: CallResult = undefined;

    raw.objectCallScriptMethod(object.ptr(), method.constPtr(), @ptrCast(args.ptr), @intCast(args.len), ret.ptr(), &result);

    try result.throw();

    return ret;
}

/// Sets an extension class instance on a Object.
///
/// @param object A pointer to the Object.
/// @param class_name A pointer to a StringName with the registered extension class's name.
/// @param instance A pointer to the extension class instance (can be null).
///
/// @since 4.1
pub fn objectSetInstance(object: *Object, class_name: *const StringName, instance: ?*anyopaque) void {
    raw.objectSetInstance(object.ptr(), class_name.constPtr(), instance);
}

/// Gets a pointer representing an Object's instance binding.
///
/// @param object A pointer to the Object.
/// @param callbacks A pointer to a GDExtensionInstanceBindingCallbacks struct.
///
/// @return A pointer to the instance binding.
///
/// @since 4.1
pub fn objectGetInstanceBinding(object: *Object, callbacks: ?*const InstanceBindingCallbacks) ?*anyopaque {
    return raw.objectGetInstanceBinding(object.ptr(), raw.library.ptr(), callbacks);
}

/// Sets an Object's instance binding.
///
/// @param object A pointer to the Object.
/// @param binding A pointer to the instance binding.
/// @param callbacks An optional pointer to a GDExtensionInstanceBindingCallbacks struct.
///
/// @since 4.1
pub fn objectSetInstanceBinding(object: *Object, binding: *anyopaque, callbacks: ?*const InstanceBindingCallbacks) void {
    raw.objectSetInstanceBinding(object.ptr(), raw.library.ptr(), binding, callbacks);
}

/// Free an Object's instance binding.
///
/// @param object A pointer to the Object.
///
/// @since 4.2
pub fn objectFreeInstanceBinding(object: *Object) void {
    raw.objectFreeInstanceBinding(object.ptr(), raw.library.ptr());
}

// Ref operations
/// Gets the Object from a reference.
///
/// @param ref A pointer to the reference.
///
/// @return A pointer to the Object from the reference.
///
/// @since 4.1
pub fn refGetObject(ref: *const RefCounted) ?*Object {
    return @ptrCast(raw.refGetObject(ref.constPtr()));
}

/// Sets the Object referred to by a reference.
///
/// @param ref A pointer to the reference.
/// @param object A pointer to the Object to refer to (can be null).
///
/// @since 4.1
pub fn refSetObject(ref: *RefCounted, object: ?*Object) void {
    raw.refSetObject(ref.ptr(), if (object) |o| o.ptr() else null);
}

// ClassDB operations
/// **Deprecated** in Godot 4.4. Use `classdbConstructObject2` instead.
///
/// Constructs an Object of the requested class.
///
/// The passed class must be a built-in godot class, or an already-registered extension class. In both cases, object_set_instance() should be called to fully initialize the object.
///
/// @param class_name A pointer to a StringName with the class name.
///
/// @return A pointer to the newly created Object.
///
/// @since 4.1
pub fn classdbConstructObject(class_name: *const StringName) ?*Object {
    return @ptrCast(raw.classdbConstructObject(class_name.constPtr()));
}

/// Constructs an Object of the requested class.
///
/// The passed class must be a built-in godot class, or an already-registered extension class. In both cases, object_set_instance() should be called to fully initialize the object.
///
/// "NOTIFICATION_POSTINITIALIZE" must be sent after construction.
///
/// @param class_name A pointer to a StringName with the class name.
///
/// @return A pointer to the newly created Object.
///
/// @since 4.4
pub fn classdbConstructObject2(class_name: *const StringName) ?*Object {
    return @ptrCast(raw.classdbConstructObject2(class_name.constPtr()));
}

/// Gets a pointer uniquely identifying the given built-in class in the ClassDB.
///
/// @param class_name A pointer to a StringName with the class name.
///
/// @return A pointer uniquely identifying the built-in class in the ClassDB.
///
/// @since 4.1
pub fn classdbGetClassTag(class_name: *const StringName) ?*ClassTag {
    return @ptrCast(raw.classdbGetClassTag(class_name.constPtr()));
}

/// Registers a method on an extension class in the ClassDB.
///
/// Provided struct can be safely freed once the function returns.
///
/// @param class_name A pointer to a StringName with the class name.
/// @param method_info A pointer to a GDExtensionClassMethodInfo struct.
///
/// @since 4.1
pub fn classdbRegisterExtensionClassMethod(class_name: *const StringName, method_info: *const ClassMethodInfo) void {
    raw.classdbRegisterExtensionClassMethod(raw.ptr(), class_name.constPtr(), method_info);
}

/// Registers a property on an extension class in the ClassDB.
///
/// Provided struct can be safely freed once the function returns.
///
/// @param class_name A pointer to a StringName with the class name.
/// @param info A pointer to a GDExtensionPropertyInfo struct.
/// @param setter A pointer to a StringName with the name of the setter method.
/// @param getter A pointer to a StringName with the name of the getter method.
///
/// @since 4.1
pub fn classdbRegisterExtensionClassProperty(class_name: *const StringName, info: *const PropertyInfo, setter: *const StringName, getter: *const StringName) void {
    raw.classdbRegisterExtensionClassProperty(raw.library.ptr(), class_name.constPtr(), info, setter.constPtr(), getter.constPtr());
}

/// Registers a signal on an extension class in the ClassDB.
///
/// Provided structs can be safely freed once the function returns.
/// @param class_name A pointer to a StringName with the class name.
/// @param signal_name A pointer to a StringName with the signal name.
/// @param argument_info A slice of PropertyInfo structs describing the signal arguments.
///
/// @since 4.1
pub fn classdbRegisterExtensionClassSignal(class_name: *const StringName, signal_name: *const StringName, argument_info: []const PropertyInfo) void {
    raw.classdbRegisterExtensionClassSignal(raw.library.ptr(), class_name.constPtr(), signal_name.constPtr(), argument_info.ptr, @intCast(argument_info.len));
}

/// Unregisters an extension class in the ClassDB.
///
/// @param class_name A pointer to a StringName with the class name.
///
/// @since 4.1
pub fn classdbUnregisterExtensionClass(class_name: *const StringName) void {
    raw.classdbUnregisterExtensionClass(raw.library.ptr(), class_name.constPtr());
}

// Editor operations
/// Adds an editor plugin.
///
/// It's safe to call during initialization.
///
/// @param class_name A pointer to a StringName with the name of a class (descending from EditorPlugin) which is already registered with ClassDB.
///
/// @since 4.1
pub fn editorAddPlugin(class_name: *const StringName) void {
    raw.editorAddPlugin(class_name.constPtr());
}

/// Removes an editor plugin.
///
/// @param class_name A pointer to a StringName with the name of a class that was previously added as an editor plugin.
///
/// @since 4.1
pub fn editorRemovePlugin(class_name: *const StringName) void {
    raw.editorRemovePlugin(class_name.constPtr());
}

// Callable operations
/// **Deprecated** in Godot 4.3. Use `callableCustomCreate2` instead.
///
/// Creates a custom Callable object from a function pointer.
///
/// Provided struct can be safely freed once the function returns.
///
/// @param info The info required to construct a Callable.
///
/// @return The newly created Callable.
///
/// @since 4.2
pub fn callableCustomCreate(info: *CallableCustomInfo) Callable {
    var result: Callable = undefined;
    raw.callableCustomCreate(result.ptr(), info);
    return result;
}

/// Creates a custom Callable object from a function pointer.
///
/// Provided struct can be safely freed once the function returns.
///
/// @param info The info required to construct a Callable.
///
/// @return The newly created Callable.
///
/// @since 4.3
pub fn callableCustomCreate2(info: *CallableCustomInfo2) Callable {
    var result: Callable = undefined;
    raw.callableCustomCreate2(result.ptr(), info);
    return result;
}

// Array operations
/// Sets an Array to be a reference to another Array object.
///
/// @param self A pointer to the Array object to update.
/// @param from A pointer to the Array object to reference.
///
/// @since 4.1
pub fn arrayRef(self: *Array, from: *const Array) void {
    raw.arrayRef(self.ptr(), from.constPtr());
}

/// Makes an Array into a typed Array.
///
/// @param self A pointer to the Array.
/// @param var_tag The type of Variant the Array will store.
/// @param class_name A pointer to a StringName with the name of the object (if var_tag is OBJECT).
/// @param script An optional pointer to a Script object (if var_tag is OBJECT and the base class is extended by a script).
///
/// @since 4.1
pub fn arraySetTyped(self: *Array, var_tag: Variant.Tag, class_name: *const StringName, script: ?*const Variant) void {
    raw.arraySetTyped(self.ptr(), @intFromEnum(var_tag), class_name.constPtr(), if (script) |s| s.constPtr() else null);
}

// Dictionary operations
/// Makes a Dictionary into a typed Dictionary.
///
/// @param self A pointer to the Dictionary.
/// @param key_tag The type of Variant the Dictionary key will store.
/// @param key_class_name A pointer to a StringName with the name of the object (if key_tag is OBJECT).
/// @param key_script An optional pointer to a Script object (if key_tag is OBJECT and the base class is extended by a script).
/// @param value_tag The type of Variant the Dictionary value will store.
/// @param value_class_name A pointer to a StringName with the name of the object (if value_tag is OBJECT).
/// @param value_script An optional pointer to a Script object (if value_tag is OBJECT and the base class is extended by a script).
///
/// @since 4.4
pub fn dictionarySetTyped(
    self: *Array,
    key_tag: Variant.Tag,
    key_class_name: *const StringName,
    key_script: ?*const Variant,
    value_tag: Variant.Tag,
    value_class_name: *const StringName,
    value_script: ?*const Variant,
) void {
    raw.dictionarySetTyped(
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
/// Gets the Godot version that the GDExtension was loaded into.
///
/// @return The Godot version information.
///
/// @since 4.1
pub fn getGodotVersion() GodotVersion {
    var version: GodotVersion = undefined;
    raw.getGodotVersion(&version);
    return version;
}

/// Gets the path to the current GDExtension library.
///
/// @return The library path as a String.
///
/// @since 4.1
pub fn getLibraryPath() String {
    var path: String = undefined;
    raw.getLibraryPath(raw.library.ptr(), @ptrCast(&path));
    return path;
}

/// Gets the size of a native struct (ex. ObjectID) in bytes.
///
/// @param name A pointer to a StringName identifying the struct name.
///
/// @return The size in bytes.
///
/// @since 4.1
pub fn getNativeStructSize(name: *const StringName) usize {
    return @intCast(raw.getNativeStructSize(name.constPtr()));
}

// Script instance functions
/// **Deprecated** in Godot 4.2. Use `scriptInstanceCreate3` instead.
///
/// Creates a script instance that contains the given info and instance data.
///
/// @param info A pointer to a GDExtensionScriptInstanceInfo struct.
/// @param instance_data A pointer to a data representing the script instance in the GDExtension. This will be passed to all the function pointers on info.
///
/// @return A pointer to a ScriptInstanceExtension object.
///
/// @since 4.1
pub fn scriptInstanceCreate(info: *const ScriptInstanceInfo, instance_data: *ScriptInstanceData) *ScriptInstance {
    return raw.scriptInstanceCreate(info, instance_data);
}

/// **Deprecated** in Godot 4.3. Use `scriptInstanceCreate3` instead.
///
/// Creates a script instance that contains the given info and instance data.
///
/// @param info A pointer to a GDExtensionScriptInstanceInfo2 struct.
/// @param instance_data A pointer to a data representing the script instance in the GDExtension. This will be passed to all the function pointers on info.
///
/// @return A pointer to a ScriptInstanceExtension object.
///
/// @since 4.2
pub fn scriptInstanceCreate2(info: *const ScriptInstanceInfo2, instance_data: *ScriptInstanceData) *ScriptInstance {
    return raw.scriptInstanceCreate2(info, instance_data);
}

/// Creates a script instance that contains the given info and instance data.
///
/// @param info A pointer to a GDExtensionScriptInstanceInfo3 struct.
/// @param instance_data A pointer to a data representing the script instance in the GDExtension. This will be passed to all the function pointers on info.
///
/// @return A pointer to a ScriptInstanceExtension object.
///
/// @since 4.3
pub fn scriptInstanceCreate3(info: *const ScriptInstanceInfo3, instance_data: *ScriptInstanceData) *ScriptInstance {
    return raw.scriptInstanceCreate3(info, instance_data);
}

/// Creates a placeholder script instance for a given script and instance.
///
/// This interface is optional as a custom placeholder could also be created with script_instance_create().
///
/// @param language A pointer to a ScriptLanguage.
/// @param script A pointer to a Script.
/// @param owner A pointer to an Object.
///
/// @return A pointer to a PlaceHolderScriptInstance object.
///
/// @since 4.2
pub fn placeholderScriptInstanceCreate(language: *Object, script: *Object, owner: *Object) *ScriptInstance {
    return raw.placeholderScriptInstanceCreate(language.ptr(), script.ptr(), owner.ptr());
}

/// Updates a placeholder script instance with the given properties and values.
///
/// The passed in placeholder must be an instance of PlaceHolderScriptInstance
/// such as the one returned by placeholder_script_instance_create().
///
/// @param placeholder A pointer to a PlaceHolderScriptInstance.
/// @param properties A pointer to an Array of Dictionary representing PropertyInfo.
/// @param values A pointer to a Dictionary mapping StringName to Variant values.
///
/// @since 4.2
pub fn placeholderScriptInstanceUpdate(placeholder: *ScriptInstance, properties: *const Array, values: *const Dictionary) void {
    raw.placeholderScriptInstanceUpdate(placeholder, properties.constPtr(), values.constPtr());
}

/// Get the script instance data attached to this object.
///
/// @param object A pointer to the Object.
/// @param language A pointer to the language expected for this script instance.
///
/// @return A GDExtensionScriptInstanceDataPtr that was attached to this object as part of script_instance_create.
///
/// @since 4.2
pub fn objectGetScriptInstance(object: *const Object, language: *Object) ?*ScriptInstance {
    return @ptrCast(raw.objectGetScriptInstance(object.constPtr(), language.ptr()));
}

// Method binding helpers
/// Calls a method on an Object.
///
/// @param method_bind A pointer to the MethodBind representing the method on the Object's class.
/// @param instance A pointer to the Object (can be null for static methods).
/// @param args A slice of Variant pointers representing the arguments.
///
/// @return The return value from the method call.
///
/// @since 4.1
pub fn objectMethodBindCall(method_bind: *MethodBind, instance: ?*Object, args: []const *const Variant) CallError!Variant {
    var ret: Variant = undefined;
    var err: CallResult = undefined;

    raw.objectMethodBindCall(
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

/// Calls a method on an Object (using a "ptrcall").
///
/// @param method_bind A pointer to the MethodBind representing the method on the Object's class.
/// @param instance A pointer to the Object (can be null for static methods).
/// @param args A slice of pointers representing the arguments.
/// @param ret A pointer that will receive the return value (can be null).
///
/// @since 4.1
pub fn objectMethodBindPtrcall(method_bind: *MethodBind, instance: ?*Object, args: []const *const anyopaque, ret: ?*anyopaque) void {
    raw.objectMethodBindPtrcall(
        method_bind.ptr(),
        if (instance) |i| i.ptr() else null,
        @ptrCast(args.ptr),
        ret,
    );
}

// Variant constructor helpers
/// Gets a pointer to a function that can create a Variant of the given type from a raw value.
///
/// @param variant_tag The Variant type.
///
/// @return A pointer to a function that can create a Variant of the given type from a raw value.
///
/// @since 4.1
pub fn getVariantFromTypeConstructor(variant_tag: Variant.Tag) c {
    return raw.getVariantFromTypeConstructor(@intFromEnum(variant_tag));
}

/// Gets a pointer to a function that can get the raw value from a Variant of the given type.
///
/// @param variant_tag The Variant type.
///
/// @return A pointer to a function that can get the raw value from a Variant of the given type.
///
/// @since 4.1
pub fn getVariantToTypeConstructor(variant_tag: Variant.Tag) c.GDExtensionTypeFromVariantConstructorFunc {
    return raw.getVariantToTypeConstructor(@intFromEnum(variant_tag));
}

/// Gets a pointer to a function that can call one of the constructors for a type of Variant.
///
/// @param variant_tag The Variant type.
/// @param constructor The index of the constructor.
///
/// @return A pointer to a function that can call one of the constructors for a type of Variant.
///
/// @since 4.1
pub fn variantGetPtrConstructor(variant_tag: Variant.Tag, constructor: i32) c.GDExtensionPtrConstructor {
    return raw.variantGetPtrConstructor(@intFromEnum(variant_tag), constructor);
}

/// Gets a pointer to a function than can call the destructor for a type of Variant.
///
/// @param variant_tag The Variant type.
///
/// @return A pointer to a function than can call the destructor for a type of Variant.
///
/// @since 4.1
pub fn variantGetPtrDestructor(variant_tag: Variant.Tag) c.GDExtensionPtrDestructor {
    return raw.variantGetPtrDestructor(@intFromEnum(variant_tag));
}

/// Constructs a Variant of the given type, using the first constructor that matches the given arguments.
///
/// @param variant_tag The Variant type to construct.
/// @param args A slice of Variant pointers representing the arguments for the constructor.
///
/// @return The constructed Variant.
///
/// @since 4.1
pub fn variantConstruct(variant_tag: Variant.Tag, args: []const *const Variant) CallError!Variant {
    var ret: Variant = undefined;
    var err: CallResult = undefined;

    raw.variantConstruct(
        @intFromEnum(variant_tag),
        @ptrCast(&ret),
        @ptrCast(args.ptr),
        @intCast(args.len),
        &err,
    );

    try err.throw();

    return ret;
}

// Variant property access helpers
/// Gets a pointer to a function that can call a member's setter on the given Variant type.
///
/// @param variant_tag The Variant type.
/// @param member A pointer to a StringName with the member name.
///
/// @return A pointer to a function that can call a member's setter on the given Variant type.
///
/// @since 4.1
pub fn variantGetPtrSetter(variant_tag: Variant.Tag, member: *const StringName) c.GDExtensionPtrSetter {
    return raw.variantGetPtrSetter(@intFromEnum(variant_tag), member.constPtr());
}

/// Gets a pointer to a function that can call a member's getter on the given Variant type.
///
/// @param variant_tag The Variant type.
/// @param member A pointer to a StringName with the member name.
///
/// @return A pointer to a function that can call a member's getter on the given Variant type.
///
/// @since 4.1
pub fn variantGetPtrGetter(variant_tag: Variant.Tag, member: *const StringName) c.GDExtensionPtrGetter {
    return raw.variantGetPtrGetter(@intFromEnum(variant_tag), member.constPtr());
}

/// Gets a pointer to a function that can set an index on the given Variant type.
///
/// @param variant_tag The Variant type.
///
/// @return A pointer to a function that can set an index on the given Variant type.
///
/// @since 4.1
pub fn variantGetPtrIndexedSetter(variant_tag: Variant.Tag) c.GDExtensionPtrIndexedSetter {
    return raw.variantGetPtrIndexedSetter(@intFromEnum(variant_tag));
}

/// Gets a pointer to a function that can get an index on the given Variant type.
///
/// @param variant_tag The Variant type.
///
/// @return A pointer to a function that can get an index on the given Variant type.
///
/// @since 4.1
pub fn variantGetPtrIndexedGetter(variant_tag: Variant.Tag) c.GDExtensionPtrIndexedGetter {
    return raw.variantGetPtrIndexedGetter(@intFromEnum(variant_tag));
}

/// Gets a pointer to a function that can set a key on the given Variant type.
///
/// @param variant_tag The Variant type.
///
/// @return A pointer to a function that can set a key on the given Variant type.
///
/// @since 4.1
pub fn variantGetPtrKeyedSetter(variant_tag: Variant.Tag) c.GDExtensionPtrKeyedSetter {
    return raw.variantGetPtrKeyedSetter(@intFromEnum(variant_tag));
}

/// Gets a pointer to a function that can get a key on the given Variant type.
///
/// @param variant_tag The Variant type.
///
/// @return A pointer to a function that can get a key on the given Variant type.
///
/// @since 4.1
pub fn variantGetPtrKeyedGetter(variant_tag: Variant.Tag) c.GDExtensionPtrKeyedGetter {
    return raw.variantGetPtrKeyedGetter(@intFromEnum(variant_tag));
}

/// Gets a pointer to a function that can check a key on the given Variant type.
///
/// @param variant_tag The Variant type.
///
/// @return A pointer to a function that can check a key on the given Variant type.
///
/// @since 4.1
pub fn variantGetPtrKeyedChecker(variant_tag: Variant.Tag) c.GDExtensionPtrKeyedChecker {
    return raw.variantGetPtrKeyedChecker(@intFromEnum(variant_tag));
}

// Variant utility functions
/// Gets the value of a constant from the given Variant type.
///
/// @param variant_tag The Variant type.
/// @param constant_name A pointer to a StringName with the constant name.
///
/// @return The constant value as a Variant.
///
/// @since 4.1
pub fn variantGetConstantValue(variant_tag: Variant.Tag, constant_name: *const StringName) Variant {
    var result: Variant = undefined;
    raw.variantGetConstantValue(@intFromEnum(variant_tag), constant_name.constPtr(), result.ptr());
    return result;
}

/// Gets a pointer to a function that can call a Variant utility function.
///
/// @param function A pointer to a StringName with the function name.
/// @param hash A hash representing the function signature.
///
/// @return A pointer to a function that can call a Variant utility function.
///
/// @since 4.1
pub fn variantGetPtrUtilityFunction(function_name: *const StringName, hash: i64) c.GDExtensionPtrUtilityFunction {
    return raw.variantGetPtrUtilityFunction(function_name.constPtr(), hash);
}

// Variant conversion helpers
/// Checks if Variants can be converted from one type to another.
///
/// @param from The Variant type to convert from.
/// @param to The Variant type to convert to.
///
/// @return true if the conversion is possible; otherwise false.
///
/// @since 4.1
pub fn variantCanConvert(from: Variant.Tag, to: Variant.Tag) bool {
    return raw.variantCanConvert(@intFromEnum(from), @intFromEnum(to)) != 0;
}

/// Checks if Variant can be converted from one type to another using stricter rules.
///
/// @param from The Variant type to convert from.
/// @param to The Variant type to convert to.
///
/// @return true if the conversion is possible; otherwise false.
///
/// @since 4.1
pub fn variantCanConvertStrict(from: Variant.Tag, to: Variant.Tag) bool {
    return raw.variantCanConvertStrict(@intFromEnum(from), @intFromEnum(to)) != 0;
}

// Packed array operator access helpers
/// Gets a pointer to a byte in a PackedByteArray.
///
/// @param self A pointer to a PackedByteArray object.
/// @param index The index of the byte to get.
///
/// @return A pointer to the requested byte.
///
/// @since 4.1
pub fn packedByteArrayOperatorIndex(self: *PackedByteArray, index: i64) *u8 {
    return raw.packedByteArrayOperatorIndex(self.ptr(), index);
}

/// Gets a const pointer to a byte in a PackedByteArray.
///
/// @param self A const pointer to a PackedByteArray object.
/// @param index The index of the byte to get.
///
/// @return A const pointer to the requested byte.
///
/// @since 4.1
pub fn packedByteArrayOperatorIndexConst(self: *const PackedByteArray, index: i64) *const u8 {
    return raw.packedByteArrayOperatorIndexConst(self.constPtr(), index);
}

/// Gets a pointer to a 32-bit float in a PackedFloat32Array.
///
/// @param self A pointer to a PackedFloat32Array object.
/// @param index The index of the float to get.
///
/// @return A pointer to the requested 32-bit float.
///
/// @since 4.1
pub fn packedFloat32ArrayOperatorIndex(self: *PackedFloat32Array, index: i64) *f32 {
    return raw.packedFloat32ArrayOperatorIndex(self.ptr(), index);
}

/// Gets a const pointer to a 32-bit float in a PackedFloat32Array.
///
/// @param self A const pointer to a PackedFloat32Array object.
/// @param index The index of the float to get.
///
/// @return A const pointer to the requested 32-bit float.
///
/// @since 4.1
pub fn packedFloat32ArrayOperatorIndexConst(self: *const PackedFloat32Array, index: i64) *const f32 {
    return raw.packedFloat32ArrayOperatorIndexConst(self.constPtr(), index);
}

/// Gets a pointer to a 64-bit float in a PackedFloat64Array.
///
/// @param self A pointer to a PackedFloat64Array object.
/// @param index The index of the float to get.
///
/// @return A pointer to the requested 64-bit float.
///
/// @since 4.1
pub fn packedFloat64ArrayOperatorIndex(self: *PackedFloat64Array, index: i64) *f64 {
    return raw.packedFloat64ArrayOperatorIndex(self.ptr(), index);
}

/// Gets a const pointer to a 64-bit float in a PackedFloat64Array.
///
/// @param self A const pointer to a PackedFloat64Array object.
/// @param index The index of the float to get.
///
/// @return A const pointer to the requested 64-bit float.
///
/// @since 4.1
pub fn packedFloat64ArrayOperatorIndexConst(self: *const PackedFloat64Array, index: i64) *const f64 {
    return raw.packedFloat64ArrayOperatorIndexConst(self.constPtr(), index);
}

/// Gets a pointer to a 32-bit integer in a PackedInt32Array.
///
/// @param self A pointer to a PackedInt32Array object.
/// @param index The index of the integer to get.
///
/// @return A pointer to the requested 32-bit integer.
///
/// @since 4.1
pub fn packedInt32ArrayOperatorIndex(self: *PackedInt32Array, index: i64) *i32 {
    return raw.packedInt32ArrayOperatorIndex(self.ptr(), index);
}

/// Gets a const pointer to a 32-bit integer in a PackedInt32Array.
///
/// @param self A const pointer to a PackedInt32Array object.
/// @param index The index of the integer to get.
///
/// @return A const pointer to the requested 32-bit integer.
///
/// @since 4.1
pub fn packedInt32ArrayOperatorIndexConst(self: *const PackedInt32Array, index: i64) *const i32 {
    return raw.packedInt32ArrayOperatorIndexConst(self.constPtr(), index);
}

/// Gets a pointer to a 64-bit integer in a PackedInt64Array.
///
/// @param self A pointer to a PackedInt64Array object.
/// @param index The index of the integer to get.
///
/// @return A pointer to the requested 64-bit integer.
///
/// @since 4.1
pub fn packedInt64ArrayOperatorIndex(self: *PackedInt64Array, index: i64) *i64 {
    return raw.packedInt64ArrayOperatorIndex(self.ptr(), index);
}

/// Gets a const pointer to a 64-bit integer in a PackedInt64Array.
///
/// @param self A const pointer to a PackedInt64Array object.
/// @param index The index of the integer to get.
///
/// @return A const pointer to the requested 64-bit integer.
///
/// @since 4.1
pub fn packedInt64ArrayOperatorIndexConst(self: *const PackedInt64Array, index: i64) *const i64 {
    return raw.packedInt64ArrayOperatorIndexConst(self.constPtr(), index);
}

/// Gets a pointer to a string in a PackedStringArray.
///
/// @param self A pointer to a PackedStringArray object.
/// @param index The index of the String to get.
///
/// @return A pointer to the requested String.
///
/// @since 4.1
pub fn packedStringArrayOperatorIndex(self: *PackedStringArray, index: i64) *String {
    return raw.packedStringArrayOperatorIndex(self.ptr(), index);
}

/// Gets a const pointer to a string in a PackedStringArray.
///
/// @param self A const pointer to a PackedStringArray object.
/// @param index The index of the String to get.
///
/// @return A const pointer to the requested String.
///
/// @since 4.1
pub fn packedStringArrayOperatorIndexConst(self: *const PackedStringArray, index: i64) *const String {
    return raw.packedStringArrayOperatorIndexConst(self.constPtr(), index);
}

/// Gets a pointer to a Vector2 in a PackedVector2Array.
///
/// @param self A pointer to a PackedVector2Array object.
/// @param index The index of the Vector2 to get.
///
/// @return A pointer to the requested Vector2.
///
/// @since 4.1
pub fn packedVector2ArrayOperatorIndex(self: *PackedVector2Array, index: i64) *Vector2 {
    return raw.packedVector2ArrayOperatorIndex(self.ptr(), index);
}

/// Gets a const pointer to a Vector2 in a PackedVector2Array.
///
/// @param self A const pointer to a PackedVector2Array object.
/// @param index The index of the Vector2 to get.
///
/// @return A const pointer to the requested Vector2.
///
/// @since 4.1
pub fn packedVector2ArrayOperatorIndexConst(self: *const PackedVector2Array, index: i64) *const Vector2 {
    return raw.packedVector2ArrayOperatorIndexConst(self.constPtr(), index);
}

/// Gets a pointer to a Vector3 in a PackedVector3Array.
///
/// @param self A pointer to a PackedVector3Array object.
/// @param index The index of the Vector3 to get.
///
/// @return A pointer to the requested Vector3.
///
/// @since 4.1
pub fn packedVector3ArrayOperatorIndex(self: *PackedVector3Array, index: i64) *Vector3 {
    return raw.packedVector3ArrayOperatorIndex(self.ptr(), index);
}

/// Gets a const pointer to a Vector3 in a PackedVector3Array.
///
/// @param self A const pointer to a PackedVector3Array object.
/// @param index The index of the Vector3 to get.
///
/// @return A const pointer to the requested Vector3.
///
/// @since 4.1
pub fn packedVector3ArrayOperatorIndexConst(self: *const PackedVector3Array, index: i64) *const Vector3 {
    return raw.packedVector3ArrayOperatorIndexConst(self.constPtr(), index);
}

/// Gets a pointer to a Vector4 in a PackedVector4Array.
///
/// @param self A pointer to a PackedVector4Array object.
/// @param index The index of the Vector4 to get.
///
/// @return A pointer to the requested Vector4.
///
/// @since 4.3
pub fn packedVector4ArrayOperatorIndex(self: *PackedVector4Array, index: i64) *Vector4 {
    return raw.packedVector4ArrayOperatorIndex(self.ptr(), index);
}

/// Gets a const pointer to a Vector4 in a PackedVector4Array.
///
/// @param self A const pointer to a PackedVector4Array object.
/// @param index The index of the Vector4 to get.
///
/// @return A const pointer to the requested Vector4.
///
/// @since 4.3
pub fn packedVector4ArrayOperatorIndexConst(self: *const PackedVector4Array, index: i64) *const Vector4 {
    return raw.packedVector4ArrayOperatorIndexConst(self.constPtr(), index);
}

/// Gets a pointer to a color in a PackedColorArray.
///
/// @param self A pointer to a PackedColorArray object.
/// @param index The index of the Color to get.
///
/// @return A pointer to the requested Color.
///
/// @since 4.1
pub fn packedColorArrayOperatorIndex(self: *PackedColorArray, index: i64) *Color {
    return raw.packedColorArrayOperatorIndex(self.ptr(), index);
}

/// Gets a const pointer to a color in a PackedColorArray.
///
/// @param self A const pointer to a PackedColorArray object.
/// @param index The index of the Color to get.
///
/// @return A const pointer to the requested Color.
///
/// @since 4.1
pub fn packedColorArrayOperatorIndexConst(self: *const PackedColorArray, index: i64) *const Color {
    return raw.packedColorArrayOperatorIndexConst(self.constPtr(), index);
}

// Array and Dictionary operators
/// Gets a pointer to a Variant in an Array.
///
/// @param self A pointer to an Array object.
/// @param index The index of the Variant to get.
///
/// @return A pointer to the requested Variant.
///
/// @since 4.1
pub fn arrayOperatorIndex(self: *Array, index: i64) *Variant {
    return raw.arrayOperatorIndex(self.ptr(), index);
}

/// Gets a const pointer to a Variant in an Array.
///
/// @param self A const pointer to an Array object.
/// @param index The index of the Variant to get.
///
/// @return A const pointer to the requested Variant.
///
/// @since 4.1
pub fn arrayOperatorIndexConst(self: *const Array, index: i64) *const Variant {
    return raw.arrayOperatorIndexConst(self.constPtr(), index);
}

/// Gets a pointer to a Variant in a Dictionary with the given key.
///
/// @param self A pointer to a Dictionary object.
/// @param key A pointer to a Variant representing the key.
///
/// @return A pointer to a Variant representing the value at the given key.
///
/// @since 4.1
pub fn dictionaryOperatorIndex(self: *Dictionary, key: *const Variant) *Variant {
    return raw.dictionaryOperatorIndex(self.ptr(), key.constPtr());
}

/// Gets a const pointer to a Variant in a Dictionary with the given key.
///
/// @param self A const pointer to a Dictionary object.
/// @param key A pointer to a Variant representing the key.
///
/// @return A const pointer to a Variant representing the value at the given key.
///
/// @since 4.1
pub fn dictionaryOperatorIndexConst(self: *const Dictionary, key: *const Variant) *const Variant {
    return raw.dictionaryOperatorIndexConst(self.constPtr(), key.constPtr());
}

// File access helpers
/// Opens a raw XML buffer on an XMLParser instance.
///
/// @param parser A pointer to an XMLParser object.
/// @param buffer A slice containing the buffer data.
///
/// @see XMLParser::open_buffer()
///
/// @since 4.1
pub fn xmlParserOpenBuffer(parser: *Object, buffer: []const u8) void {
    raw.xmlParserOpenBuffer(parser.ptr(), buffer.ptr, buffer.len);
}

/// Stores the given buffer using an instance of FileAccess.
///
/// @param file A pointer to a FileAccess object.
/// @param buffer A slice containing the data to store.
///
/// @see FileAccess::store_buffer()
///
/// @since 4.1
pub fn fileAccessStoreBuffer(file: *Object, buffer: []const u8) void {
    raw.fileAccessStoreBuffer(file.ptr(), buffer.ptr, buffer.len);
}

/// Reads the next bytes into the given buffer using an instance of FileAccess.
///
/// @param file A pointer to a FileAccess object.
/// @param buffer A slice to store the data.
///
/// @return The actual number of bytes read (may be less than requested).
///
/// @since 4.1
pub fn fileAccessGetBuffer(file: *const Object, buffer: []u8) u64 {
    return raw.fileAccessGetBuffer(file.constPtr(), buffer.ptr, buffer.len);
}

// Image helpers
/// Returns writable pointer to internal Image buffer.
///
/// @param image A pointer to a Image object.
///
/// @return Pointer to internal Image buffer.
///
/// @see Image::ptrw()
///
/// @since 4.3
pub fn imagePtrw(image: *Object) [*]u8 {
    return raw.imagePtrw(image.ptr());
}

/// Returns read only pointer to internal Image buffer.
///
/// @param image A pointer to a Image object.
///
/// @return Pointer to internal Image buffer.
///
/// @see Image::ptr()
///
/// @since 4.3
pub fn imagePtr(image: *Object) [*]const u8 {
    return raw.imagePtr(image.ptr());
}

// Worker thread pool helpers
/// Adds a group task to an instance of WorkerThreadPool.
///
/// @param pool A pointer to a WorkerThreadPool object.
/// @param func A pointer to a function to run in the thread pool.
/// @param userdata A pointer to arbitrary data which will be passed to func.
/// @param elements The number of elements to process.
/// @param tasks The number of tasks needed in the group.
/// @param high_priority Whether or not this is a high priority task.
/// @param description An optional pointer to a String with the task description.
///
/// @see WorkerThreadPool::add_group_task()
///
/// @since 4.1
pub fn workerThreadPoolAddNativeGroupTask(
    pool: *Object,
    func: *const fn (userdata: ?*anyopaque, index: u32) callconv(.C) void,
    userdata: ?*anyopaque,
    elements: i32,
    tasks: i32,
    high_priority: bool,
    description: ?*const String,
) void {
    raw.workerThreadPoolAddNativeGroupTask(
        pool.ptr(),
        func,
        userdata,
        elements,
        tasks,
        @intFromBool(high_priority),
        if (description) |d| d.constPtr() else null,
    );
}

/// Adds a task to an instance of WorkerThreadPool.
///
/// @param pool A pointer to a WorkerThreadPool object.
/// @param func A pointer to a function to run in the thread pool.
/// @param userdata A pointer to arbitrary data which will be passed to func.
/// @param high_priority Whether or not this is a high priority task.
/// @param description An optional pointer to a String with the task description.
///
/// @since 4.1
pub fn workerThreadPoolAddNativeTask(
    pool: *Object,
    func: *const fn (userdata: ?*anyopaque) callconv(.C) void,
    userdata: ?*anyopaque,
    high_priority: bool,
    description: ?*const String,
) void {
    raw.workerThreadPoolAddNativeTask(
        pool.ptr(),
        func,
        userdata,
        @intFromBool(high_priority),
        if (description) |d| d.constPtr() else null,
    );
}

/// **Deprecated** in Godot 4.2. Use `classdbRegisterExtensionClass4` instead.
///
/// Registers an extension class in the ClassDB.
///
/// Provided struct can be safely freed once the function returns.
///
/// @param class_name A pointer to a StringName with the class name.
/// @param parent_class_name A pointer to a StringName with the parent class name.
/// @param class_info A pointer to a GDExtensionClassCreationInfo struct.
///
/// @since 4.1
pub fn classdbRegisterExtensionClass(class_name: *const StringName, parent_class_name: *const StringName, class_info: *const ClassCreationInfo) void {
    raw.classdbRegisterExtensionClass(raw.library.ptr(), class_name.constPtr(), parent_class_name.constPtr(), class_info);
}

/// **Deprecated** in Godot 4.3. Use `classdbRegisterExtensionClass4` instead.
///
/// Registers an extension class in the ClassDB.
///
/// Provided struct can be safely freed once the function returns.
///
/// @param class_name A pointer to a StringName with the class name.
/// @param parent_class_name A pointer to a StringName with the parent class name.
/// @param class_info A pointer to a GDExtensionClassCreationInfo2 struct.
///
/// @since 4.2
pub fn classdbRegisterExtensionClass2(class_name: *const StringName, parent_class_name: *const StringName, class_info: *const ClassCreationInfo2) void {
    raw.classdbRegisterExtensionClass2(raw.library.ptr(), class_name.constPtr(), parent_class_name.constPtr(), class_info);
}

/// **Deprecated** in Godot 4.4. Use `classdbRegisterExtensionClass4` instead.
///
/// Registers an extension class in the ClassDB.
///
/// Provided struct can be safely freed once the function returns.
///
/// @param class_name A pointer to a StringName with the class name.
/// @param parent_class_name A pointer to a StringName with the parent class name.
/// @param class_info A pointer to a GDExtensionClassCreationInfo3 struct.
///
/// @since 4.3
pub fn classdbRegisterExtensionClass3(class_name: *const StringName, parent_class_name: *const StringName, class_info: *const ClassCreationInfo3) void {
    raw.classdbRegisterExtensionClass3(raw.library.ptr(), class_name.constPtr(), parent_class_name.constPtr(), class_info);
}

/// Registers an extension class in the ClassDB.
///
/// Provided struct can be safely freed once the function returns.
///
/// @param class_name A pointer to a StringName with the class name.
/// @param parent_class_name A pointer to a StringName with the parent class name.
/// @param class_info A pointer to a GDExtensionClassCreationInfo4 struct.
///
/// @since 4.4
pub fn classdbRegisterExtensionClass4(class_name: *const StringName, parent_class_name: *const StringName, class_info: *const ClassCreationInfo4) void {
    raw.classdbRegisterExtensionClass4(raw.library.ptr(), class_name.constPtr(), parent_class_name.constPtr(), class_info);
}

// Variant type helpers
/// Gets the name of a Variant type.
///
/// @param variant_tag The Variant type.
///
/// @return The Variant type name as a String.
///
/// @since 4.1
pub fn variantGetTypeName(variant_tag: Variant.Tag) String {
    var result: String = undefined;
    raw.variantGetTypeName(@intFromEnum(variant_tag), result.ptr());
    return result;
}

/// Checks if a type of Variant has the given member.
///
/// @param variant_tag The Variant type.
/// @param member A pointer to a StringName with the member name.
///
/// @return true if the type has the member; otherwise false.
///
/// @since 4.1
pub fn variantHasMember(variant_tag: Variant.Tag, member: *const StringName) bool {
    return raw.variantHasMember(@intFromEnum(variant_tag), member.constPtr()) != 0;
}

// Variant iterator helpers
/// Initializes an iterator over a Variant.
///
/// @param self A pointer to the Variant.
///
/// @return The iterator as a Variant. Returns an error if the iterator initialization failed.
///
/// @return true if the operation is valid; otherwise false.
///
/// @see Variant::iter_init()
///
/// @since 4.1
pub fn variantIterInit(self: *const Variant) Error!Variant {
    var iter: Variant = undefined;
    var valid: u8 = 0;

    raw.variantIterInit(self.constPtr(), iter.ptr(), &valid);

    if (valid == 0) {
        return error.IteratorInitFailed;
    }

    return iter;
}

/// Gets the next value for an iterator over a Variant.
///
/// @param self A pointer to the Variant.
/// @param iter A pointer to a Variant iterator.
///
/// @return true if there are more items to iterate over; otherwise false. Returns an error if the iterator is invalid.
///
/// @see Variant::iter_next()
///
/// @since 4.1
pub fn variantIterNext(self: *const Variant, iter: *Variant) !bool {
    var valid: u8 = 0;
    const result = raw.variantIterNext(self.constPtr(), iter.ptr(), &valid);

    if (valid == 0) {
        return error.InvalidIterator;
    }

    return result != 0;
}

/// Gets the next value for an iterator over a Variant.
///
/// @param self A pointer to the Variant.
/// @param iter A pointer to a Variant iterator.
///
/// @return The current value at the iterator position. Returns an error if the iterator is invalid.
///
/// @see Variant::iter_get()
///
/// @since 4.1
pub fn variantIterGet(self: *const Variant, iter: *Variant) Error!Variant {
    var result: Variant = undefined;
    var valid: u8 = 0;

    raw.variantIterGet(self.constPtr(), iter.ptr(), @ptrCast(&result), &valid);

    if (valid == 0) {
        return error.InvalidIterator;
    }

    return result;
}

// Editor help functions
/// Loads new XML-formatted documentation data in the editor.
///
/// The provided pointer can be immediately freed once the function returns.
///
/// @param data A slice containing a UTF-8 encoded C string.
///
/// @since 4.3
pub fn editorHelpLoadXmlFromUtf8(data: []const u8) void {
    raw.editorHelpLoadXmlFromUtf8CharsAndLen(data.ptr, data.len);
}

/// Loads new XML-formatted documentation data in the editor.
///
/// The provided pointer can be immediately freed once the function returns.
///
/// @param data A pointer to a UTF-8 encoded C string (null terminated).
///
/// @since 4.3
pub fn editorHelpLoadXmlFromUtf8Chars(data: [*:0]const u8) void {
    raw.editorHelpLoadXmlFromUtf8Chars(data);
}

// Variant operator evaluation helper
/// Gets a pointer to a function that can evaluate the given Variant operator on the given Variant types.
///
/// @param op The variant operator.
/// @param a The type of the first Variant.
/// @param b The type of the second Variant.
///
/// @return A pointer to a function that can evaluate the given Variant operator on the given Variant types.
///
/// @since 4.1
pub fn variantGetPtrOperatorEvaluator(op: Variant.Operator, a: Variant.Tag, b: Variant.Tag) c.GDExtensionPtrOperatorEvaluator {
    return raw.variantGetPtrOperatorEvaluator(@intFromEnum(op), @intFromEnum(a), @intFromEnum(b));
}

// Variant builtin method helper
/// Gets a pointer to a function that can call a builtin method on a type of Variant.
///
/// @param p_type The Variant type.
/// @param p_method A pointer to a StringName with the method name.
/// @param p_hash A hash representing the method signature.
///
/// @return A pointer to a function that can call a builtin method on a type of Variant.
///
/// @since 4.1
pub fn variantGetPtrBuiltinMethod(variant_tag: Variant.Tag, method: *const StringName, hash: i64) c.GDExtensionPtrBuiltInMethod {
    return raw.variantGetPtrBuiltinMethod(@intFromEnum(variant_tag), method.constPtr(), hash);
}

// Convenience function for getting variant internal pointer

// String operator helpers
/// Gets a pointer to the character at the given index from a String.
///
/// @param p_self A pointer to the String.
/// @param p_index The index.
///
/// @return A pointer to the requested character.
///
/// @since 4.1
pub fn stringOperatorIndex(self: *String, index: i64) *u32 {
    return raw.stringOperatorIndex(self.ptr(), index);
}

/// Gets a const pointer to the character at the given index from a String.
///
/// @param p_self A pointer to the String.
/// @param p_index The index.
///
/// @return A const pointer to the requested character.
///
/// @since 4.1
pub fn stringOperatorIndexConst(self: *const String, index: i64) *const u32 {
    return raw.stringOperatorIndexConst(self.constPtr(), index);
}

// Callable custom user data helper
/// Retrieves the userdata pointer from a custom Callable.
///
/// If the Callable is not a custom Callable or the token does not match the one provided to callable_custom_create() via GDExtensionCallableCustomInfo then NULL will be returned.
///
/// @param p_callable A pointer to a Callable.
/// @param p_token A pointer to an address that uniquely identifies the GDExtension.
///
/// @since 4.2
pub fn callableCustomGetUserData(callable: *const Callable) ?*anyopaque {
    return raw.callableCustomGetUserData(callable.constPtr(), raw.library);
}

// Virtual method registration helper
/// Registers a virtual method on an extension class in ClassDB, that can be implemented by scripts or other extensions.
///
/// Provided struct can be safely freed once the function returns.
///
/// @param p_library A pointer the library received by the GDExtension's entry point function.
/// @param p_class_name A pointer to a StringName with the class name.
/// @param p_method_info A pointer to a GDExtensionClassMethodInfo struct.
///
/// @since 4.3
pub fn classdbRegisterExtensionClassVirtualMethod(class_name: *const StringName, method_info: *const ClassVirtualMethodInfo) void {
    raw.classdbRegisterExtensionClassVirtualMethod(raw.library.ptr(), class_name.constPtr(), method_info);
}

// Integer constant registration helper
/// Registers an integer constant on an extension class in the ClassDB.
///
/// Note about registering bitfield values (if p_is_bitfield is true): even though p_constant_value is signed, language bindings are
/// advised to treat bitfields as uint64_t, since this is generally clearer and can prevent mistakes like using -1 for setting all bits.
/// Language APIs should thus provide an abstraction that registers bitfields (uint64_t) separately from regular constants (int64_t).
///
/// @param p_library A pointer the library received by the GDExtension's entry point function.
/// @param class_name A pointer to a StringName with the class name.
/// @param enum_name An optional pointer to a StringName with the enum name.
/// @param constant_name A pointer to a StringName with the constant name.
/// @param constant_value The constant value.
/// @param is_bitfield Whether or not this constant is part of a bitfield.
///
/// @since 4.1
pub fn classdbRegisterExtensionClassIntegerConstant(class_name: *const StringName, enum_name: ?*const StringName, constant_name: *const StringName, constant_value: i64, is_bitfield: bool) void {
    raw.classdbRegisterExtensionClassIntegerConstant(
        raw.library.ptr(),
        class_name.constPtr(),
        if (enum_name) |e| e.constPtr() else null,
        constant_name.constPtr(),
        constant_value,
        @intFromBool(is_bitfield),
    );
}

// Property group registration helpers
/// Registers a property group on an extension class in the ClassDB.
///
/// @param class_name A pointer to a StringName with the class name.
/// @param group_name A pointer to a String with the group name.
/// @param prefix A pointer to a String with the prefix used by properties in this group.
///
/// @since 4.1
pub fn classdbRegisterExtensionClassPropertyGroup(class_name: *const StringName, group_name: *const String, prefix: *const String) void {
    raw.classdbRegisterExtensionClassPropertyGroup(raw.library.ptr(), class_name.constPtr(), group_name.constPtr(), prefix.constPtr());
}

/// Registers a property subgroup on an extension class in the ClassDB.
///
/// @param class_name A pointer to a StringName with the class name.
/// @param subgroup_name A pointer to a String with the subgroup name.
/// @param prefix A pointer to a String with the prefix used by properties in this subgroup.
///
/// @since 4.1
pub fn classdbRegisterExtensionClassPropertySubgroup(class_name: *const StringName, subgroup_name: *const String, prefix: *const String) void {
    raw.classdbRegisterExtensionClassPropertySubgroup(raw.library.ptr(), class_name.constPtr(), subgroup_name.constPtr(), prefix.constPtr());
}

// Property indexed registration helper
/// Registers an indexed property on an extension class in the ClassDB.
///
/// Provided struct can be safely freed once the function returns.
///
/// @param class_name A pointer to a StringName with the class name.
/// @param info A pointer to a GDExtensionPropertyInfo struct.
/// @param setter A pointer to a StringName with the name of the setter method.
/// @param getter A pointer to a StringName with the name of the getter method.
/// @param index The index to pass as the first argument to the getter and setter methods.
///
/// @since 4.2
pub fn classdbRegisterExtensionClassPropertyIndexed(class_name: *const StringName, info: *const PropertyInfo, setter: *const StringName, getter: *const StringName, index: i64) void {
    raw.classdbRegisterExtensionClassPropertyIndexed(raw.library.ptr(), class_name.constPtr(), info, setter.constPtr(), getter.constPtr(), index);
}

/// Provides a function pointer for retrieving a pointer to a variant's internal value.
/// Access to a variant's internal value can be used to modify it in-place, or to retrieve its value without the overhead of variant conversion functions.
/// It is recommended to cache the getter for all variant types in a function table to avoid retrieval overhead upon use.
///
/// @note Each function assumes the variant's type has already been determined and matches the function.
/// Invoking the function with a variant of a mismatched type has undefined behavior, and may lead to a segmentation fault.
///
/// @param variant_tag The Variant type.
///
/// @return A pointer to a type-specific function that returns a pointer to the internal value of a variant. Check the implementation of this function (gdextension_variant_get_ptr_internal_getter) for pointee type info of each variant type.
///
/// @since 4.4
pub fn getVariantGetInternalPtrFunc(variant_tag: Variant.Tag) ?c.GDExtensionVariantGetInternalPtrFunc {
    return raw.getVariantGetInternalPtrFunc(@intFromEnum(variant_tag));
}

/// Creates a String from a UTF-16 encoded C string.
///
/// @param utf16 A pointer to a UTF-16 encoded C string (null terminated).
///
/// @return The newly created String.
///
/// @since 4.1
pub fn stringNewWithUtf16Chars(utf16: [*:0]const u16) String {
    var result: String = undefined;
    raw.stringNewWithUtf16Chars(result.ptr(), utf16);
    return result;
}

/// Creates a String from a UTF-32 encoded C string.
///
/// @param utf32 A pointer to a UTF-32 encoded C string (null terminated).
///
/// @return The newly created String.
///
/// @since 4.1
pub fn stringNewWithUtf32Chars(utf32: [*:0]const u32) String {
    var result: String = undefined;
    raw.stringNewWithUtf32Chars(result.ptr(), utf32);
    return result;
}

const raw: *Interface = &@import("../gdzig_bindings.zig").raw;

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
const Interface = @import("./Interface.zig");
const ClassLibrary = Interface.ClassLibrary;
