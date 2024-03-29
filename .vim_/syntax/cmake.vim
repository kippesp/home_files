" Vim syntax file
" Program:      CMake - Cross-Platform Makefile Generator
" Version:      cmake version 3.13.20181010-ga3598
" Language:     CMake
" Author:       Andy Cedilnik <andy.cedilnik@kitware.com>,
"               Nicholas Hutchinson <nshutchinson@gmail.com>,
"               Patrick Boettcher <patrick.boettcher@posteo.de>
" Maintainer:   Dimitri Merejkowsky <d.merej@gmail.com>
" Former Maintainer: Karthik Krishnan <karthik.krishnan@kitware.com>
" Last Change:  2018 Oct 18
"
" Licence:      The CMake license applies to this file. See
"               https://cmake.org/licensing
"               This implies that distribution with Vim is allowed

if exists("b:current_syntax")
  finish
endif
let s:keepcpo= &cpo
set cpo&vim

syn region cmakeBracketArgument start="\[\z(=\?\|=[0-9]*\)\[" end="\]\z1\]" contains=cmakeTodo,@Spell

syn region cmakeComment start="#" end="$" contains=cmakeTodo,@Spell
syn region cmakeBracketComment start="#\[\z(=\?\|=[0-9]*\)\[" end="\]\z1\]" contains=cmakeTodo,@Spell

syn match cmakeEscaped /\(\\\\\|\\"\|\\n\|\\t\)/ contained
syn region cmakeRegistry start="\[" end="]" contained oneline contains=cmakeTodo,cmakeEscaped

syn region cmakeGeneratorExpression start="$<" end=">" contained oneline contains=cmakeVariableValue,cmakeProperty,cmakeGeneratorExpressions,cmakeTodo

syn region cmakeString start='"' end='"' contained contains=cmakeTodo,cmakeVariableValue,cmakeEscaped

syn region cmakeVariableValue start="${" end="}" contained oneline contains=cmakeVariable,cmakeTodo

syn region cmakeEnvironment start="$ENV{" end="}" contained oneline contains=cmakeTodo

syn region cmakeArguments start="(" end=")" contains=ALLBUT,cmakeCommand,cmakeCommandConditional,cmakeCommandRepeat,cmakeCommandDeprecated,cmakeCommandManuallyAdded,cmakeArguments,cmakeTodo

syn case match

syn keyword cmakeProperty contained
            \ ABSTRACT
            \ ADDITIONAL_MAKE_CLEAN_FILES
            \ ADVANCED
            \ ALIASED_TARGET
            \ ALLOW_DUPLICATE_CUSTOM_TARGETS
            \ ANDROID_ANT_ADDITIONAL_OPTIONS
            \ ANDROID_API
            \ ANDROID_API_MIN
            \ ANDROID_ARCH
            \ ANDROID_ASSETS_DIRECTORIES
            \ ANDROID_GUI
            \ ANDROID_JAR_DEPENDENCIES
            \ ANDROID_JAR_DIRECTORIES
            \ ANDROID_JAVA_SOURCE_DIR
            \ ANDROID_NATIVE_LIB_DEPENDENCIES
            \ ANDROID_NATIVE_LIB_DIRECTORIES
            \ ANDROID_PROCESS_MAX
            \ ANDROID_PROGUARD
            \ ANDROID_PROGUARD_CONFIG_PATH
            \ ANDROID_SECURE_PROPS_PATH
            \ ANDROID_SKIP_ANT_STEP
            \ ANDROID_STL_TYPE
            \ ARCHIVE_OUTPUT_DIRECTORY
            \ ARCHIVE_OUTPUT_NAME
            \ ATTACHED_FILES
            \ ATTACHED_FILES_ON_FAIL
            \ AUTOGEN_BUILD_DIR
            \ AUTOGEN_PARALLEL
            \ AUTOGEN_SOURCE_GROUP
            \ AUTOGEN_TARGETS_FOLDER
            \ AUTOGEN_TARGET_DEPENDS
            \ AUTOMOC
            \ AUTOMOC_COMPILER_PREDEFINES
            \ AUTOMOC_DEPEND_FILTERS
            \ AUTOMOC_MACRO_NAMES
            \ AUTOMOC_MOC_OPTIONS
            \ AUTOMOC_SOURCE_GROUP
            \ AUTOMOC_TARGETS_FOLDER
            \ AUTORCC
            \ AUTORCC_OPTIONS
            \ AUTORCC_SOURCE_GROUP
            \ AUTOUIC
            \ AUTOUIC_OPTIONS
            \ AUTOUIC_SEARCH_PATHS
            \ BINARY_DIR
            \ BUILDSYSTEM_TARGETS
            \ BUILD_RPATH
            \ BUILD_WITH_INSTALL_NAME_DIR
            \ BUILD_WITH_INSTALL_RPATH
            \ BUNDLE
            \ BUNDLE_EXTENSION
            \ CACHE_VARIABLES
            \ CLEAN_NO_CUSTOM
            \ CMAKE_CONFIGURE_DEPENDS
            \ CMAKE_CXX_KNOWN_FEATURES
            \ CMAKE_C_KNOWN_FEATURES
            \ COMMON_LANGUAGE_RUNTIME
            \ COMPATIBLE_INTERFACE_BOOL
            \ COMPATIBLE_INTERFACE_NUMBER_MAX
            \ COMPATIBLE_INTERFACE_NUMBER_MIN
            \ COMPATIBLE_INTERFACE_STRING
            \ COMPILE_DEFINITIONS
            \ COMPILE_FEATURES
            \ COMPILE_FLAGS
            \ COMPILE_OPTIONS
            \ COMPILE_PDB_NAME
            \ COMPILE_PDB_OUTPUT_DIRECTORY
            \ COST
            \ CPACK_DESKTOP_SHORTCUTS
            \ CPACK_NEVER_OVERWRITE
            \ CPACK_PERMANENT
            \ CPACK_STARTUP_SHORTCUTS
            \ CPACK_START_MENU_SHORTCUTS
            \ CPACK_WIX_ACL
            \ CROSSCOMPILING_EMULATOR
            \ CUDA_EXTENSIONS
            \ CUDA_PTX_COMPILATION
            \ CUDA_RESOLVE_DEVICE_SYMBOLS
            \ CUDA_SEPARABLE_COMPILATION
            \ CUDA_STANDARD
            \ CUDA_STANDARD_REQUIRED
            \ CXX_EXTENSIONS
            \ CXX_STANDARD
            \ CXX_STANDARD_REQUIRED
            \ C_EXTENSIONS
            \ C_STANDARD
            \ C_STANDARD_REQUIRED
            \ DEBUG_CONFIGURATIONS
            \ DEBUG_POSTFIX
            \ DEFINE_SYMBOL
            \ DEFINITIONS
            \ DEPENDS
            \ DEPLOYMENT_ADDITIONAL_FILES
            \ DEPLOYMENT_REMOTE_DIRECTORY
            \ DISABLED
            \ DISABLED_FEATURES
            \ DOTNET_TARGET_FRAMEWORK_VERSION
            \ ECLIPSE_EXTRA_CPROJECT_CONTENTS
            \ ECLIPSE_EXTRA_NATURES
            \ ENABLED_FEATURES
            \ ENABLED_LANGUAGES
            \ ENABLE_EXPORTS
            \ ENVIRONMENT
            \ EXCLUDE_FROM_ALL
            \ EXCLUDE_FROM_DEFAULT_BUILD
            \ EXPORT_NAME
            \ EXPORT_PROPERTIES
            \ EXTERNAL_OBJECT
            \ EchoString
            \ FAIL_REGULAR_EXPRESSION
            \ FIND_LIBRARY_USE_LIB32_PATHS
            \ FIND_LIBRARY_USE_LIB64_PATHS
            \ FIND_LIBRARY_USE_LIBX32_PATHS
            \ FIND_LIBRARY_USE_OPENBSD_VERSIONING
            \ FIXTURES_CLEANUP
            \ FIXTURES_REQUIRED
            \ FIXTURES_SETUP
            \ FOLDER
            \ FRAMEWORK
            \ FRAMEWORK_VERSION
            \ Fortran_FORMAT
            \ Fortran_MODULE_DIRECTORY
            \ GENERATED
            \ GENERATOR_FILE_NAME
            \ GENERATOR_IS_MULTI_CONFIG
            \ GLOBAL_DEPENDS_DEBUG_MODE
            \ GLOBAL_DEPENDS_NO_CYCLES
            \ GNUtoMS
            \ HAS_CXX
            \ HEADER_FILE_ONLY
            \ HELPSTRING
            \ IMPLICIT_DEPENDS_INCLUDE_TRANSFORM
            \ IMPORTED
            \ IMPORTED_COMMON_LANGUAGE_RUNTIME
            \ IMPORTED_CONFIGURATIONS
            \ IMPORTED_GLOBAL
            \ IMPORTED_IMPLIB
            \ IMPORTED_LIBNAME
            \ IMPORTED_LINK_DEPENDENT_LIBRARIES
            \ IMPORTED_LINK_INTERFACE_LANGUAGES
            \ IMPORTED_LINK_INTERFACE_LIBRARIES
            \ IMPORTED_LINK_INTERFACE_MULTIPLICITY
            \ IMPORTED_LOCATION
            \ IMPORTED_NO_SONAME
            \ IMPORTED_OBJECTS
            \ IMPORTED_SONAME
            \ IMPORT_PREFIX
            \ IMPORT_SUFFIX
            \ INCLUDE_DIRECTORIES
            \ INCLUDE_REGULAR_EXPRESSION
            \ INSTALL_NAME_DIR
            \ INSTALL_RPATH
            \ INSTALL_RPATH_USE_LINK_PATH
            \ INTERFACE_AUTOUIC_OPTIONS
            \ INTERFACE_COMPILE_DEFINITIONS
            \ INTERFACE_COMPILE_FEATURES
            \ INTERFACE_COMPILE_OPTIONS
            \ INTERFACE_INCLUDE_DIRECTORIES
            \ INTERFACE_LINK_DEPENDS
            \ INTERFACE_LINK_DIRECTORIES
            \ INTERFACE_LINK_LIBRARIES
            \ INTERFACE_LINK_OPTIONS
            \ INTERFACE_POSITION_INDEPENDENT_CODE
            \ INTERFACE_SOURCES
            \ INTERFACE_SYSTEM_INCLUDE_DIRECTORIES
            \ INTERPROCEDURAL_OPTIMIZATION
            \ IN_TRY_COMPILE
            \ IOS_INSTALL_COMBINED
            \ JOB_POOLS
            \ JOB_POOL_COMPILE
            \ JOB_POOL_LINK
            \ KEEP_EXTENSION
            \ LABELS
            \ LANGUAGE
            \ LIBRARY_OUTPUT_DIRECTORY
            \ LIBRARY_OUTPUT_NAME
            \ LINKER_LANGUAGE
            \ LINK_DEPENDS
            \ LINK_DEPENDS_NO_SHARED
            \ LINK_DIRECTORIES
            \ LINK_FLAGS
            \ LINK_INTERFACE_LIBRARIES
            \ LINK_INTERFACE_MULTIPLICITY
            \ LINK_LIBRARIES
            \ LINK_OPTIONS
            \ LINK_SEARCH_END_STATIC
            \ LINK_SEARCH_START_STATIC
            \ LINK_WHAT_YOU_USE
            \ LISTFILE_STACK
            \ LOCATION
            \ MACOSX_BUNDLE
            \ MACOSX_BUNDLE_INFO_PLIST
            \ MACOSX_FRAMEWORK_INFO_PLIST
            \ MACOSX_PACKAGE_LOCATION
            \ MACOSX_RPATH
            \ MACROS
            \ MANUALLY_ADDED_DEPENDENCIES
            \ MEASUREMENT
            \ MODIFIED
            \ NAME
            \ NO_SONAME
            \ NO_SYSTEM_FROM_IMPORTED
            \ OBJECT_DEPENDS
            \ OBJECT_OUTPUTS
            \ OSX_ARCHITECTURES
            \ OUTPUT_NAME
            \ PACKAGES_FOUND
            \ PACKAGES_NOT_FOUND
            \ PARENT_DIRECTORY
            \ PASS_REGULAR_EXPRESSION
            \ PDB_NAME
            \ PDB_OUTPUT_DIRECTORY
            \ POSITION_INDEPENDENT_CODE
            \ POST_INSTALL_SCRIPT
            \ PREDEFINED_TARGETS_FOLDER
            \ PREFIX
            \ PRE_INSTALL_SCRIPT
            \ PRIVATE_HEADER
            \ PROCESSORS
            \ PROCESSOR_AFFINITY
            \ PROJECT_LABEL
            \ PUBLIC_HEADER
            \ REPORT_UNDEFINED_PROPERTIES
            \ REQUIRED_FILES
            \ RESOURCE
            \ RESOURCE_LOCK
            \ RULE_LAUNCH_COMPILE
            \ RULE_LAUNCH_CUSTOM
            \ RULE_LAUNCH_LINK
            \ RULE_MESSAGES
            \ RUNTIME_OUTPUT_DIRECTORY
            \ RUNTIME_OUTPUT_NAME
            \ RUN_SERIAL
            \ SKIP_AUTOGEN
            \ SKIP_AUTOMOC
            \ SKIP_AUTORCC
            \ SKIP_AUTOUIC
            \ SKIP_BUILD_RPATH
            \ SKIP_RETURN_CODE
            \ SOURCES
            \ SOURCE_DIR
            \ SOVERSION
            \ STATIC_LIBRARY_FLAGS
            \ STATIC_LIBRARY_OPTIONS
            \ STRINGS
            \ SUBDIRECTORIES
            \ SUFFIX
            \ SYMBOLIC
            \ TARGET_ARCHIVES_MAY_BE_SHARED_LIBS
            \ TARGET_MESSAGES
            \ TARGET_SUPPORTS_SHARED_LIBS
            \ TESTS
            \ TEST_INCLUDE_FILE
            \ TEST_INCLUDE_FILES
            \ TIMEOUT
            \ TIMEOUT_AFTER_MATCH
            \ TYPE
            \ USE_FOLDERS
            \ VALUE
            \ VARIABLES
            \ VERSION
            \ VISIBILITY_INLINES_HIDDEN
            \ VS_CONFIGURATION_TYPE
            \ VS_COPY_TO_OUT_DIR
            \ VS_DEBUGGER_COMMAND
            \ VS_DEBUGGER_COMMAND_ARGUMENTS
            \ VS_DEBUGGER_ENVIRONMENT
            \ VS_DEBUGGER_WORKING_DIRECTORY
            \ VS_DEPLOYMENT_CONTENT
            \ VS_DEPLOYMENT_LOCATION
            \ VS_DESKTOP_EXTENSIONS_VERSION
            \ VS_DOTNET_REFERENCES
            \ VS_DOTNET_REFERENCES_COPY_LOCAL
            \ VS_DOTNET_TARGET_FRAMEWORK_VERSION
            \ VS_GLOBAL_KEYWORD
            \ VS_GLOBAL_PROJECT_TYPES
            \ VS_GLOBAL_ROOTNAMESPACE
            \ VS_INCLUDE_IN_VSIX
            \ VS_IOT_EXTENSIONS_VERSION
            \ VS_IOT_STARTUP_TASK
            \ VS_KEYWORD
            \ VS_MOBILE_EXTENSIONS_VERSION
            \ VS_RESOURCE_GENERATOR
            \ VS_SCC_AUXPATH
            \ VS_SCC_LOCALPATH
            \ VS_SCC_PROJECTNAME
            \ VS_SCC_PROVIDER
            \ VS_SDK_REFERENCES
            \ VS_SHADER_DISABLE_OPTIMIZATIONS
            \ VS_SHADER_ENABLE_DEBUG
            \ VS_SHADER_ENTRYPOINT
            \ VS_SHADER_FLAGS
            \ VS_SHADER_MODEL
            \ VS_SHADER_OBJECT_FILE_NAME
            \ VS_SHADER_OUTPUT_HEADER_FILE
            \ VS_SHADER_TYPE
            \ VS_SHADER_VARIABLE_NAME
            \ VS_STARTUP_PROJECT
            \ VS_TOOL_OVERRIDE
            \ VS_USER_PROPS
            \ VS_WINDOWS_TARGET_PLATFORM_MIN_VERSION
            \ VS_WINRT_COMPONENT
            \ VS_WINRT_EXTENSIONS
            \ VS_WINRT_REFERENCES
            \ VS_XAML_TYPE
            \ WILL_FAIL
            \ WIN32_EXECUTABLE
            \ WINDOWS_EXPORT_ALL_SYMBOLS
            \ WORKING_DIRECTORY
            \ WRAP_EXCLUDE
            \ XCODE_EMIT_EFFECTIVE_PLATFORM_NAME
            \ XCODE_EXPLICIT_FILE_TYPE
            \ XCODE_FILE_ATTRIBUTES
            \ XCODE_LAST_KNOWN_FILE_TYPE
            \ XCODE_PRODUCT_TYPE
            \ XCODE_SCHEME_ADDRESS_SANITIZER
            \ XCODE_SCHEME_ADDRESS_SANITIZER_USE_AFTER_RETURN
            \ XCODE_SCHEME_ARGUMENTS
            \ XCODE_SCHEME_DISABLE_MAIN_THREAD_CHECKER
            \ XCODE_SCHEME_DYNAMIC_LIBRARY_LOADS
            \ XCODE_SCHEME_DYNAMIC_LINKER_API_USAGE
            \ XCODE_SCHEME_ENVIRONMENT
            \ XCODE_SCHEME_EXECUTABLE
            \ XCODE_SCHEME_GUARD_MALLOC
            \ XCODE_SCHEME_MAIN_THREAD_CHECKER_STOP
            \ XCODE_SCHEME_MALLOC_GUARD_EDGES
            \ XCODE_SCHEME_MALLOC_SCRIBBLE
            \ XCODE_SCHEME_MALLOC_STACK
            \ XCODE_SCHEME_THREAD_SANITIZER
            \ XCODE_SCHEME_THREAD_SANITIZER_STOP
            \ XCODE_SCHEME_UNDEFINED_BEHAVIOUR_SANITIZER
            \ XCODE_SCHEME_UNDEFINED_BEHAVIOUR_SANITIZER_STOP
            \ XCODE_SCHEME_ZOMBIE_OBJECTS
            \ XCTEST

syn keyword cmakeVariable contained
            \ ANDROID
            \ APPLE
            \ BORLAND
            \ BUILD_SHARED_LIBS
            \ CACHE
            \ CMAKE_ABSOLUTE_DESTINATION_FILES
            \ CMAKE_ANDROID_ANT_ADDITIONAL_OPTIONS
            \ CMAKE_ANDROID_API
            \ CMAKE_ANDROID_API_MIN
            \ CMAKE_ANDROID_ARCH
            \ CMAKE_ANDROID_ARCH_ABI
            \ CMAKE_ANDROID_ARM_MODE
            \ CMAKE_ANDROID_ARM_NEON
            \ CMAKE_ANDROID_ASSETS_DIRECTORIES
            \ CMAKE_ANDROID_GUI
            \ CMAKE_ANDROID_JAR_DEPENDENCIES
            \ CMAKE_ANDROID_JAR_DIRECTORIES
            \ CMAKE_ANDROID_JAVA_SOURCE_DIR
            \ CMAKE_ANDROID_NATIVE_LIB_DEPENDENCIES
            \ CMAKE_ANDROID_NATIVE_LIB_DIRECTORIES
            \ CMAKE_ANDROID_NDK
            \ CMAKE_ANDROID_NDK_DEPRECATED_HEADERS
            \ CMAKE_ANDROID_NDK_TOOLCHAIN_HOST_TAG
            \ CMAKE_ANDROID_NDK_TOOLCHAIN_VERSION
            \ CMAKE_ANDROID_PROCESS_MAX
            \ CMAKE_ANDROID_PROGUARD
            \ CMAKE_ANDROID_PROGUARD_CONFIG_PATH
            \ CMAKE_ANDROID_SECURE_PROPS_PATH
            \ CMAKE_ANDROID_SKIP_ANT_STEP
            \ CMAKE_ANDROID_STANDALONE_TOOLCHAIN
            \ CMAKE_ANDROID_STL_TYPE
            \ CMAKE_APPBUNDLE_PATH
            \ CMAKE_AR
            \ CMAKE_ARCHIVE_OUTPUT_DIRECTORY
            \ CMAKE_ARGC
            \ CMAKE_ARGV0
            \ CMAKE_AUTOGEN_PARALLEL
            \ CMAKE_AUTOGEN_VERBOSE
            \ CMAKE_AUTOMOC
            \ CMAKE_AUTOMOC_COMPILER_PREDEFINES
            \ CMAKE_AUTOMOC_DEPEND_FILTERS
            \ CMAKE_AUTOMOC_MACRO_NAMES
            \ CMAKE_AUTOMOC_MOC_OPTIONS
            \ CMAKE_AUTOMOC_RELAXED_MODE
            \ CMAKE_AUTORCC
            \ CMAKE_AUTORCC_OPTIONS
            \ CMAKE_AUTOUIC
            \ CMAKE_AUTOUIC_OPTIONS
            \ CMAKE_AUTOUIC_SEARCH_PATHS
            \ CMAKE_BACKWARDS_COMPATIBILITY
            \ CMAKE_BINARY_DIR
            \ CMAKE_BUILD_RPATH
            \ CMAKE_BUILD_TOOL
            \ CMAKE_BUILD_TYPE
            \ CMAKE_BUILD_WITH_INSTALL_NAME_DIR
            \ CMAKE_BUILD_WITH_INSTALL_RPATH
            \ CMAKE_CACHEFILE_DIR
            \ CMAKE_CACHE_MAJOR_VERSION
            \ CMAKE_CACHE_MINOR_VERSION
            \ CMAKE_CACHE_PATCH_VERSION
            \ CMAKE_CFG_INTDIR
            \ CMAKE_CL_64
            \ CMAKE_CODEBLOCKS_COMPILER_ID
            \ CMAKE_CODEBLOCKS_EXCLUDE_EXTERNAL_FILES
            \ CMAKE_CODELITE_USE_TARGETS
            \ CMAKE_COLOR_MAKEFILE
            \ CMAKE_COMMAND
            \ CMAKE_COMPILER_2005
            \ CMAKE_COMPILER_IS_GNUCC
            \ CMAKE_COMPILER_IS_GNUCXX
            \ CMAKE_COMPILER_IS_GNUG77
            \ CMAKE_COMPILE_PDB_OUTPUT_DIRECTORY
            \ CMAKE_CONFIGURATION_TYPES
            \ CMAKE_CPACK_COMMAND
            \ CMAKE_CROSSCOMPILING
            \ CMAKE_CROSSCOMPILING_EMULATOR
            \ CMAKE_CTEST_COMMAND
            \ CMAKE_CUDA_EXTENSIONS
            \ CMAKE_CUDA_HOST_COMPILER
            \ CMAKE_CUDA_SEPARABLE_COMPILATION
            \ CMAKE_CUDA_STANDARD
            \ CMAKE_CUDA_STANDARD_REQUIRED
            \ CMAKE_CUDA_TOOLKIT_INCLUDE_DIRECTORIES
            \ CMAKE_CURRENT_BINARY_DIR
            \ CMAKE_CURRENT_LIST_DIR
            \ CMAKE_CURRENT_LIST_FILE
            \ CMAKE_CURRENT_LIST_LINE
            \ CMAKE_CURRENT_SOURCE_DIR
            \ CMAKE_CXX_COMPILE_FEATURES
            \ CMAKE_CXX_EXTENSIONS
            \ CMAKE_CXX_STANDARD
            \ CMAKE_CXX_STANDARD_REQUIRED
            \ CMAKE_C_COMPILE_FEATURES
            \ CMAKE_C_EXTENSIONS
            \ CMAKE_C_STANDARD
            \ CMAKE_C_STANDARD_REQUIRED
            \ CMAKE_DEBUG_POSTFIX
            \ CMAKE_DEBUG_TARGET_PROPERTIES
            \ CMAKE_DEPENDS_IN_PROJECT_ONLY
            \ CMAKE_DIRECTORY_LABELS
            \ CMAKE_DL_LIBS
            \ CMAKE_DOTNET_TARGET_FRAMEWORK_VERSION
            \ CMAKE_ECLIPSE_GENERATE_LINKED_RESOURCES
            \ CMAKE_ECLIPSE_GENERATE_SOURCE_PROJECT
            \ CMAKE_ECLIPSE_MAKE_ARGUMENTS
            \ CMAKE_ECLIPSE_VERSION
            \ CMAKE_EDIT_COMMAND
            \ CMAKE_ENABLE_EXPORTS
            \ CMAKE_ERROR_DEPRECATED
            \ CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION
            \ CMAKE_EXECUTABLE_SUFFIX
            \ CMAKE_EXE_LINKER_FLAGS
            \ CMAKE_EXE_LINKER_FLAGS_INIT
            \ CMAKE_EXPORT_COMPILE_COMMANDS
            \ CMAKE_EXPORT_NO_PACKAGE_REGISTRY
            \ CMAKE_EXTRA_GENERATOR
            \ CMAKE_EXTRA_SHARED_LIBRARY_SUFFIXES
            \ CMAKE_FIND_APPBUNDLE
            \ CMAKE_FIND_FRAMEWORK
            \ CMAKE_FIND_LIBRARY_CUSTOM_LIB_SUFFIX
            \ CMAKE_FIND_LIBRARY_PREFIXES
            \ CMAKE_FIND_LIBRARY_SUFFIXES
            \ CMAKE_FIND_NO_INSTALL_PREFIX
            \ CMAKE_FIND_PACKAGE_NAME
            \ CMAKE_FIND_PACKAGE_NO_PACKAGE_REGISTRY
            \ CMAKE_FIND_PACKAGE_NO_SYSTEM_PACKAGE_REGISTRY
            \ CMAKE_FIND_PACKAGE_SORT_DIRECTION
            \ CMAKE_FIND_PACKAGE_SORT_ORDER
            \ CMAKE_FIND_PACKAGE_WARN_NO_MODULE
            \ CMAKE_FIND_ROOT_PATH
            \ CMAKE_FIND_ROOT_PATH_MODE_INCLUDE
            \ CMAKE_FIND_ROOT_PATH_MODE_LIBRARY
            \ CMAKE_FIND_ROOT_PATH_MODE_PACKAGE
            \ CMAKE_FIND_ROOT_PATH_MODE_PROGRAM
            \ CMAKE_FOLDER
            \ CMAKE_FRAMEWORK_PATH
            \ CMAKE_Fortran_FORMAT
            \ CMAKE_Fortran_MODDIR_DEFAULT
            \ CMAKE_Fortran_MODDIR_FLAG
            \ CMAKE_Fortran_MODOUT_FLAG
            \ CMAKE_Fortran_MODULE_DIRECTORY
            \ CMAKE_GENERATOR
            \ CMAKE_GENERATOR_INSTANCE
            \ CMAKE_GENERATOR_PLATFORM
            \ CMAKE_GENERATOR_TOOLSET
            \ CMAKE_GNUtoMS
            \ CMAKE_HOME_DIRECTORY
            \ CMAKE_HOST_APPLE
            \ CMAKE_HOST_SOLARIS
            \ CMAKE_HOST_SYSTEM
            \ CMAKE_HOST_SYSTEM_NAME
            \ CMAKE_HOST_SYSTEM_PROCESSOR
            \ CMAKE_HOST_SYSTEM_VERSION
            \ CMAKE_HOST_UNIX
            \ CMAKE_HOST_WIN32
            \ CMAKE_IGNORE_PATH
            \ CMAKE_IMPORT_LIBRARY_PREFIX
            \ CMAKE_IMPORT_LIBRARY_SUFFIX
            \ CMAKE_INCLUDE_CURRENT_DIR
            \ CMAKE_INCLUDE_CURRENT_DIR_IN_INTERFACE
            \ CMAKE_INCLUDE_DIRECTORIES_BEFORE
            \ CMAKE_INCLUDE_DIRECTORIES_PROJECT_BEFORE
            \ CMAKE_INCLUDE_PATH
            \ CMAKE_INSTALL_DEFAULT_COMPONENT_NAME
            \ CMAKE_INSTALL_DEFAULT_DIRECTORY_PERMISSIONS
            \ CMAKE_INSTALL_MESSAGE
            \ CMAKE_INSTALL_NAME_DIR
            \ CMAKE_INSTALL_PREFIX
            \ CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT
            \ CMAKE_INSTALL_RPATH
            \ CMAKE_INSTALL_RPATH_USE_LINK_PATH
            \ CMAKE_INTERNAL_PLATFORM_ABI
            \ CMAKE_INTERPROCEDURAL_OPTIMIZATION
            \ CMAKE_IOS_INSTALL_COMBINED
            \ CMAKE_JOB_POOLS
            \ CMAKE_JOB_POOL_COMPILE
            \ CMAKE_JOB_POOL_LINK
            \ CMAKE_LIBRARY_ARCHITECTURE
            \ CMAKE_LIBRARY_ARCHITECTURE_REGEX
            \ CMAKE_LIBRARY_OUTPUT_DIRECTORY
            \ CMAKE_LIBRARY_PATH
            \ CMAKE_LIBRARY_PATH_FLAG
            \ CMAKE_LINK_DEF_FILE_FLAG
            \ CMAKE_LINK_DEPENDS_NO_SHARED
            \ CMAKE_LINK_DIRECTORIES_BEFORE
            \ CMAKE_LINK_INTERFACE_LIBRARIES
            \ CMAKE_LINK_LIBRARY_FILE_FLAG
            \ CMAKE_LINK_LIBRARY_FLAG
            \ CMAKE_LINK_LIBRARY_SUFFIX
            \ CMAKE_LINK_SEARCH_END_STATIC
            \ CMAKE_LINK_SEARCH_START_STATIC
            \ CMAKE_LINK_WHAT_YOU_USE
            \ CMAKE_MACOSX_BUNDLE
            \ CMAKE_MACOSX_RPATH
            \ CMAKE_MAJOR_VERSION
            \ CMAKE_MAKE_PROGRAM
            \ CMAKE_MATCH_COUNT
            \ CMAKE_MFC_FLAG
            \ CMAKE_MINIMUM_REQUIRED_VERSION
            \ CMAKE_MINOR_VERSION
            \ CMAKE_MODULE_LINKER_FLAGS
            \ CMAKE_MODULE_LINKER_FLAGS_INIT
            \ CMAKE_MODULE_PATH
            \ CMAKE_MSVCIDE_RUN_PATH
            \ CMAKE_NETRC
            \ CMAKE_NETRC_FILE
            \ CMAKE_NINJA_OUTPUT_PATH_PREFIX
            \ CMAKE_NOT_USING_CONFIG_FLAGS
            \ CMAKE_NO_BUILTIN_CHRPATH
            \ CMAKE_NO_SYSTEM_FROM_IMPORTED
            \ CMAKE_OBJECT_PATH_MAX
            \ CMAKE_OSX_ARCHITECTURES
            \ CMAKE_OSX_DEPLOYMENT_TARGET
            \ CMAKE_OSX_SYSROOT
            \ CMAKE_PARENT_LIST_FILE
            \ CMAKE_PATCH_VERSION
            \ CMAKE_PDB_OUTPUT_DIRECTORY
            \ CMAKE_POSITION_INDEPENDENT_CODE
            \ CMAKE_PREFIX_PATH
            \ CMAKE_PROGRAM_PATH
            \ CMAKE_PROJECT_DESCRIPTION
            \ CMAKE_PROJECT_HOMEPAGE_URL
            \ CMAKE_PROJECT_NAME
            \ CMAKE_PROJECT_VERSION
            \ CMAKE_PROJECT_VERSION_MAJOR
            \ CMAKE_PROJECT_VERSION_MINOR
            \ CMAKE_PROJECT_VERSION_PATCH
            \ CMAKE_PROJECT_VERSION_TWEAK
            \ CMAKE_RANLIB
            \ CMAKE_ROOT
            \ CMAKE_RULE_MESSAGES
            \ CMAKE_RUNTIME_OUTPUT_DIRECTORY
            \ CMAKE_SCRIPT_MODE_FILE
            \ CMAKE_SHARED_LIBRARY_PREFIX
            \ CMAKE_SHARED_LIBRARY_SUFFIX
            \ CMAKE_SHARED_LINKER_FLAGS
            \ CMAKE_SHARED_LINKER_FLAGS_INIT
            \ CMAKE_SHARED_MODULE_PREFIX
            \ CMAKE_SHARED_MODULE_SUFFIX
            \ CMAKE_SIZEOF_VOID_P
            \ CMAKE_SKIP_BUILD_RPATH
            \ CMAKE_SKIP_INSTALL_ALL_DEPENDENCY
            \ CMAKE_SKIP_INSTALL_RPATH
            \ CMAKE_SKIP_INSTALL_RULES
            \ CMAKE_SKIP_RPATH
            \ CMAKE_SOURCE_DIR
            \ CMAKE_STAGING_PREFIX
            \ CMAKE_STATIC_LIBRARY_PREFIX
            \ CMAKE_STATIC_LIBRARY_SUFFIX
            \ CMAKE_STATIC_LINKER_FLAGS
            \ CMAKE_STATIC_LINKER_FLAGS_INIT
            \ CMAKE_SUBLIME_TEXT_2_ENV_SETTINGS
            \ CMAKE_SUBLIME_TEXT_2_EXCLUDE_BUILD_TREE
            \ CMAKE_SUPPRESS_REGENERATION
            \ CMAKE_SYSROOT
            \ CMAKE_SYSROOT_COMPILE
            \ CMAKE_SYSROOT_LINK
            \ CMAKE_SYSTEM
            \ CMAKE_SYSTEM_APPBUNDLE_PATH
            \ CMAKE_SYSTEM_FRAMEWORK_PATH
            \ CMAKE_SYSTEM_IGNORE_PATH
            \ CMAKE_SYSTEM_INCLUDE_PATH
            \ CMAKE_SYSTEM_LIBRARY_PATH
            \ CMAKE_SYSTEM_NAME
            \ CMAKE_SYSTEM_PREFIX_PATH
            \ CMAKE_SYSTEM_PROCESSOR
            \ CMAKE_SYSTEM_PROGRAM_PATH
            \ CMAKE_SYSTEM_VERSION
            \ CMAKE_Swift_LANGUAGE_VERSION
            \ CMAKE_TOOLCHAIN_FILE
            \ CMAKE_TRY_COMPILE_CONFIGURATION
            \ CMAKE_TRY_COMPILE_PLATFORM_VARIABLES
            \ CMAKE_TRY_COMPILE_TARGET_TYPE
            \ CMAKE_TWEAK_VERSION
            \ CMAKE_USER_MAKE_RULES_OVERRIDE
            \ CMAKE_USE_RELATIVE_PATHS
            \ CMAKE_VERBOSE_MAKEFILE
            \ CMAKE_VERSION
            \ CMAKE_VISIBILITY_INLINES_HIDDEN
            \ CMAKE_VS_DEVENV_COMMAND
            \ CMAKE_VS_GLOBALS
            \ CMAKE_VS_INCLUDE_INSTALL_TO_DEFAULT_BUILD
            \ CMAKE_VS_INCLUDE_PACKAGE_TO_DEFAULT_BUILD
            \ CMAKE_VS_INTEL_Fortran_PROJECT_VERSION
            \ CMAKE_VS_MSBUILD_COMMAND
            \ CMAKE_VS_NsightTegra_VERSION
            \ CMAKE_VS_PLATFORM_NAME
            \ CMAKE_VS_PLATFORM_TOOLSET
            \ CMAKE_VS_PLATFORM_TOOLSET_CUDA
            \ CMAKE_VS_PLATFORM_TOOLSET_HOST_ARCHITECTURE
            \ CMAKE_VS_PLATFORM_TOOLSET_VERSION
            \ CMAKE_VS_SDK_EXCLUDE_DIRECTORIES
            \ CMAKE_VS_SDK_EXECUTABLE_DIRECTORIES
            \ CMAKE_VS_SDK_INCLUDE_DIRECTORIES
            \ CMAKE_VS_SDK_LIBRARY_DIRECTORIES
            \ CMAKE_VS_SDK_LIBRARY_WINRT_DIRECTORIES
            \ CMAKE_VS_SDK_REFERENCE_DIRECTORIES
            \ CMAKE_VS_SDK_SOURCE_DIRECTORIES
            \ CMAKE_VS_WINDOWS_TARGET_PLATFORM_VERSION
            \ CMAKE_VS_WINRT_BY_DEFAULT
            \ CMAKE_WARN_DEPRECATED
            \ CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION
            \ CMAKE_WIN32_EXECUTABLE
            \ CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS
            \ CMAKE_XCODE_GENERATE_SCHEME
            \ CMAKE_XCODE_GENERATE_TOP_LEVEL_PROJECT_ONLY
            \ CMAKE_XCODE_PLATFORM_TOOLSET
            \ CMAKE_XCODE_SCHEME_ADDRESS_SANITIZER
            \ CMAKE_XCODE_SCHEME_ADDRESS_SANITIZER_USE_AFTER_RETURN
            \ CMAKE_XCODE_SCHEME_DISABLE_MAIN_THREAD_CHECKER
            \ CMAKE_XCODE_SCHEME_DYNAMIC_LIBRARY_LOADS
            \ CMAKE_XCODE_SCHEME_DYNAMIC_LINKER_API_USAGE
            \ CMAKE_XCODE_SCHEME_GUARD_MALLOC
            \ CMAKE_XCODE_SCHEME_MAIN_THREAD_CHECKER_STOP
            \ CMAKE_XCODE_SCHEME_MALLOC_GUARD_EDGES
            \ CMAKE_XCODE_SCHEME_MALLOC_SCRIBBLE
            \ CMAKE_XCODE_SCHEME_MALLOC_STACK
            \ CMAKE_XCODE_SCHEME_THREAD_SANITIZER
            \ CMAKE_XCODE_SCHEME_THREAD_SANITIZER_STOP
            \ CMAKE_XCODE_SCHEME_UNDEFINED_BEHAVIOUR_SANITIZER
            \ CMAKE_XCODE_SCHEME_UNDEFINED_BEHAVIOUR_SANITIZER_STOP
            \ CMAKE_XCODE_SCHEME_ZOMBIE_OBJECTS
            \ CPACK_ABSOLUTE_DESTINATION_FILES
            \ CPACK_COMPONENT_INCLUDE_TOPLEVEL_DIRECTORY
            \ CPACK_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION
            \ CPACK_INCLUDE_TOPLEVEL_DIRECTORY
            \ CPACK_INSTALL_DEFAULT_DIRECTORY_PERMISSIONS
            \ CPACK_INSTALL_SCRIPT
            \ CPACK_PACKAGING_INSTALL_PREFIX
            \ CPACK_SET_DESTDIR
            \ CPACK_WARN_ON_ABSOLUTE_INSTALL_DESTINATION
            \ CTEST_BINARY_DIRECTORY
            \ CTEST_BUILD_COMMAND
            \ CTEST_BUILD_NAME
            \ CTEST_BZR_COMMAND
            \ CTEST_BZR_UPDATE_OPTIONS
            \ CTEST_CHANGE_ID
            \ CTEST_CHECKOUT_COMMAND
            \ CTEST_CONFIGURATION_TYPE
            \ CTEST_CONFIGURE_COMMAND
            \ CTEST_COVERAGE_COMMAND
            \ CTEST_COVERAGE_EXTRA_FLAGS
            \ CTEST_CURL_OPTIONS
            \ CTEST_CUSTOM_COVERAGE_EXCLUDE
            \ CTEST_CUSTOM_ERROR_EXCEPTION
            \ CTEST_CUSTOM_ERROR_MATCH
            \ CTEST_CUSTOM_ERROR_POST_CONTEXT
            \ CTEST_CUSTOM_ERROR_PRE_CONTEXT
            \ CTEST_CUSTOM_MAXIMUM_FAILED_TEST_OUTPUT_SIZE
            \ CTEST_CUSTOM_MAXIMUM_NUMBER_OF_ERRORS
            \ CTEST_CUSTOM_MAXIMUM_NUMBER_OF_WARNINGS
            \ CTEST_CUSTOM_MAXIMUM_PASSED_TEST_OUTPUT_SIZE
            \ CTEST_CUSTOM_MEMCHECK_IGNORE
            \ CTEST_CUSTOM_POST_MEMCHECK
            \ CTEST_CUSTOM_POST_TEST
            \ CTEST_CUSTOM_PRE_MEMCHECK
            \ CTEST_CUSTOM_PRE_TEST
            \ CTEST_CUSTOM_TESTS_IGNORE
            \ CTEST_CUSTOM_WARNING_EXCEPTION
            \ CTEST_CUSTOM_WARNING_MATCH
            \ CTEST_CVS_CHECKOUT
            \ CTEST_CVS_COMMAND
            \ CTEST_CVS_UPDATE_OPTIONS
            \ CTEST_DROP_LOCATION
            \ CTEST_DROP_METHOD
            \ CTEST_DROP_SITE
            \ CTEST_DROP_SITE_CDASH
            \ CTEST_DROP_SITE_PASSWORD
            \ CTEST_DROP_SITE_USER
            \ CTEST_EXTRA_COVERAGE_GLOB
            \ CTEST_GIT_COMMAND
            \ CTEST_GIT_INIT_SUBMODULES
            \ CTEST_GIT_UPDATE_CUSTOM
            \ CTEST_GIT_UPDATE_OPTIONS
            \ CTEST_HG_COMMAND
            \ CTEST_HG_UPDATE_OPTIONS
            \ CTEST_LABELS_FOR_SUBPROJECTS
            \ CTEST_MEMORYCHECK_COMMAND
            \ CTEST_MEMORYCHECK_COMMAND_OPTIONS
            \ CTEST_MEMORYCHECK_SANITIZER_OPTIONS
            \ CTEST_MEMORYCHECK_SUPPRESSIONS_FILE
            \ CTEST_MEMORYCHECK_TYPE
            \ CTEST_NIGHTLY_START_TIME
            \ CTEST_P4_CLIENT
            \ CTEST_P4_COMMAND
            \ CTEST_P4_OPTIONS
            \ CTEST_P4_UPDATE_OPTIONS
            \ CTEST_RUN_CURRENT_SCRIPT
            \ CTEST_SCP_COMMAND
            \ CTEST_SITE
            \ CTEST_SOURCE_DIRECTORY
            \ CTEST_SVN_COMMAND
            \ CTEST_SVN_OPTIONS
            \ CTEST_SVN_UPDATE_OPTIONS
            \ CTEST_TEST_LOAD
            \ CTEST_TEST_TIMEOUT
            \ CTEST_TRIGGER_SITE
            \ CTEST_UPDATE_COMMAND
            \ CTEST_UPDATE_OPTIONS
            \ CTEST_UPDATE_VERSION_ONLY
            \ CTEST_USE_LAUNCHERS
            \ CYGWIN
            \ ENV
            \ EXECUTABLE_OUTPUT_PATH
            \ GHS-MULTI
            \ LIBRARY_OUTPUT_PATH
            \ MINGW
            \ MSVC
            \ MSVC10
            \ MSVC11
            \ MSVC12
            \ MSVC14
            \ MSVC60
            \ MSVC70
            \ MSVC71
            \ MSVC80
            \ MSVC90
            \ MSVC_IDE
            \ MSVC_TOOLSET_VERSION
            \ MSVC_VERSION
            \ PROJECT_BINARY_DIR
            \ PROJECT_DESCRIPTION
            \ PROJECT_HOMEPAGE_URL
            \ PROJECT_NAME
            \ PROJECT_SOURCE_DIR
            \ PROJECT_VERSION
            \ PROJECT_VERSION_MAJOR
            \ PROJECT_VERSION_MINOR
            \ PROJECT_VERSION_PATCH
            \ PROJECT_VERSION_TWEAK
            \ UNIX
            \ WIN32
            \ WINCE
            \ WINDOWS_PHONE
            \ WINDOWS_STORE
            \ XCODE
            \ XCODE_VERSION

syn keyword cmakeModule contained
            \ ExternalProject

syn keyword cmakeKWExternalProject contained
            \ AWS
            \ BINARY_DIR
            \ BUILD_ALWAYS
            \ BUILD_BYPRODUCTS
            \ BUILD_COMMAND
            \ BUILD_IN_SOURCE
            \ CMAKE_ARGS
            \ CMAKE_CACHE_ARGS
            \ CMAKE_CACHE_DEFAULT_ARGS
            \ CMAKE_TLS_CAINFO
            \ CMAKE_TLS_VERIFY
            \ COMMENT
            \ CONFIGURE_COMMAND
            \ CVS
            \ CVSROOT
            \ CVS_MODULE
            \ CVS_REPOSITORY
            \ CVS_TAG
            \ DEPENDEES
            \ DEPENDERS
            \ DEPENDS
            \ DOWNLOADED_FILE
            \ DOWNLOAD_COMMAND
            \ DOWNLOAD_DIR
            \ DOWNLOAD_NAME
            \ DOWNLOAD_NO_EXTRACT
            \ DOWNLOAD_NO_PROGRESS
            \ EP_BASE
            \ EP_INDEPENDENT_STEP_TARGETS
            \ EP_PREFIX
            \ EP_STEP_TARGETS
            \ EP_UPDATE_DISCONNECTED
            \ EXCLUDE_FROM_ALL
            \ FORCE
            \ GIT_CONFIG
            \ GIT_PROGRESS
            \ GIT_REMOTE_NAME
            \ GIT_REPOSITORY
            \ GIT_SHALLOW
            \ GIT_SUBMODULES
            \ GIT_TAG
            \ HG_REPOSITORY
            \ HG_TAG
            \ HTTP_HEADER
            \ HTTP_PASSWORD
            \ HTTP_USERNAME
            \ IGNORED
            \ INDEPENDENT_STEP_TARGETS
            \ INSTALL_COMMAND
            \ INSTALL_DIR
            \ JOB_POOLS
            \ LIST_SEPARATOR
            \ LOG_
            \ LOG_BUILD
            \ LOG_CONFIGURE
            \ LOG_DIR
            \ LOG_DOWNLOAD
            \ LOG_INSTALL
            \ LOG_MERGED_STDOUTERR
            \ LOG_OUTPUT_ON_FAILURE
            \ LOG_PATCH
            \ LOG_TEST
            \ LOG_UPDATE
            \ MAKE_EXE
            \ NAMES
            \ NETRC
            \ NETRC_FILE
            \ NOTE
            \ NO_DEPENDS
            \ OPTIONAL
            \ PATCH_COMMAND
            \ PREFIX
            \ PROPERTY
            \ REQUIRED
            \ SOURCE_DIR
            \ SOURCE_SUBDIR
            \ STAMP_DIR
            \ STEP_TARGETS
            \ STRING
            \ SVN_PASSWORD
            \ SVN_REPOSITORY
            \ SVN_REVISION
            \ SVN_TRUST_CERT
            \ SVN_USERNAME
            \ TEST_AFTER_INSTALL
            \ TEST_BEFORE_INSTALL
            \ TEST_COMMAND
            \ TEST_EXCLUDE_FROM_MAIN
            \ TIMEOUT
            \ TLS_CAINFO
            \ TLS_VERIFY
            \ TMP_DIR
            \ TRUE
            \ UPDATE_COMMAND
            \ UPDATE_DISCONNECTED
            \ URL
            \ URL_HASH
            \ USES_TERMINAL_BUILD
            \ USES_TERMINAL_CONFIGURE
            \ USES_TERMINAL_DOWNLOAD
            \ USES_TERMINAL_INSTALL
            \ USES_TERMINAL_TEST
            \ USES_TERMINAL_UPDATE
            \ WORKING_DIRECTORY

syn keyword cmakeKWadd_compile_definitions contained
            \ COMPILE_DEFINITIONS
            \ VAR

syn keyword cmakeKWadd_compile_options contained
            \ COMPILE_OPTIONS
            \ SHELL
            \ UNIX_COMMAND

syn keyword cmakeKWadd_custom_command contained
            \ APPEND
            \ ARGS
            \ BYPRODUCTS
            \ CC
            \ COMMAND
            \ COMMAND_EXPAND_LISTS
            \ COMMENT
            \ CROSSCOMPILING_EMULATOR
            \ DEPENDS
            \ DEPFILE
            \ GENERATED
            \ IMPLICIT_DEPENDS
            \ INCLUDE_DIRECTORIES
            \ JOIN
            \ MAIN_DEPENDENCY
            \ NOT
            \ OUTPUT
            \ POST_BUILD
            \ PRE_BUILD
            \ PRE_LINK
            \ SYMBOLIC
            \ TARGET_FILE
            \ TARGET_PROPERTY
            \ USES_TERMINAL
            \ VERBATIM
            \ WORKING_DIRECTORY

syn keyword cmakeKWadd_custom_target contained
            \ ALL
            \ BYPRODUCTS
            \ CC
            \ COMMAND
            \ COMMAND_EXPAND_LISTS
            \ COMMENT
            \ CROSSCOMPILING_EMULATOR
            \ DEPENDS
            \ GENERATED
            \ INCLUDE_DIRECTORIES
            \ JOIN
            \ SOURCES
            \ TARGET_PROPERTY
            \ USES_TERMINAL
            \ VERBATIM
            \ WORKING_DIRECTORY

syn keyword cmakeKWadd_definitions contained
            \ COMPILE_DEFINITIONS

syn keyword cmakeKWadd_dependencies contained
            \ DEPENDS
            \ OBJECT_DEPENDS

syn keyword cmakeKWadd_executable contained
            \ ALIAS
            \ CONFIG
            \ EXCLUDE_FROM_ALL
            \ GLOBAL
            \ HEADER_FILE_ONLY
            \ IMPORTED
            \ IMPORTED_
            \ IMPORTED_LOCATION
            \ IMPORTED_LOCATION_
            \ MACOSX_BUNDLE
            \ OUTPUT_NAME
            \ RUNTIME_OUTPUT_DIRECTORY
            \ TARGET

syn keyword cmakeKWadd_library contained
            \ ALIAS
            \ ARCHIVE_OUTPUT_DIRECTORY
            \ CLI
            \ CONFIG
            \ DLL
            \ EXCLUDE_FROM_ALL
            \ FRAMEWORK
            \ GLOBAL
            \ HEADER_FILE_ONLY
            \ IMPORTED
            \ IMPORTED_
            \ IMPORTED_LOCATION
            \ IMPORTED_LOCATION_
            \ IMPORTED_OBJECTS
            \ IMPORTED_OBJECTS_
            \ INTERFACE_
            \ LIBRARY_OUTPUT_DIRECTORY
            \ MODULE
            \ OBJECT
            \ ON
            \ OUTPUT_NAME
            \ POSITION_INDEPENDENT_CODE
            \ POST_BUILD
            \ PRE_BUILD
            \ PRE_LINK
            \ RUNTIME_OUTPUT_DIRECTORY
            \ SHARED
            \ STATIC
            \ TARGET_OBJECTS
            \ UNKNOWN

syn keyword cmakeKWadd_link_options contained
            \ CMAKE_
            \ GCC
            \ GNU
            \ LANG
            \ LINKER
            \ LINK_OPTIONS
            \ SHELL
            \ UNIX_COMMAND
            \ _LINKER_WRAPPER_FLAG
            \ _LINKER_WRAPPER_FLAG_SEP

syn keyword cmakeKWadd_subdirectory contained
            \ EXCLUDE_FROM_ALL

syn keyword cmakeKWadd_test contained
            \ BUILD_TESTING
            \ COMMAND
            \ CONFIGURATIONS
            \ FAIL_REGULAR_EXPRESSION
            \ NAME
            \ PASS_REGULAR_EXPRESSION
            \ TARGET_FILE
            \ WILL_FAIL
            \ WORKING_DIRECTORY

syn keyword cmakeKWbuild_command contained
            \ CONFIGURATION
            \ TARGET

syn keyword cmakeKWbuild_name contained
            \ CMAKE_CXX_COMPILER

syn keyword cmakeKWcmake_host_system_information contained
            \ AVAILABLE_PHYSICAL_MEMORY
            \ AVAILABLE_VIRTUAL_MEMORY
            \ FQDN
            \ HAS_FPU
            \ HAS_MMX
            \ HAS_MMX_PLUS
            \ HAS_SERIAL_NUMBER
            \ HAS_SSE
            \ HAS_SSE_FP
            \ HAS_SSE_MMX
            \ HOSTNAME
            \ ID
            \ NUMBER_OF_LOGICAL_CORES
            \ NUMBER_OF_PHYSICAL_CORES
            \ OS_NAME
            \ OS_PLATFORM
            \ OS_RELEASE
            \ OS_VERSION
            \ PROCESSOR_DESCRIPTION
            \ PROCESSOR_NAME
            \ PROCESSOR_SERIAL_NUMBER
            \ QUERY
            \ RESULT
            \ TOTAL_PHYSICAL_MEMORY
            \ TOTAL_VIRTUAL_MEMORY

syn keyword cmakeKWcmake_minimum_required contained
            \ FATAL_ERROR
            \ VERSION

syn keyword cmakeKWcmake_parse_arguments contained
            \ ARGN
            \ CONFIGURATIONS
            \ DESTINATION
            \ FALSE
            \ FAST
            \ FILES
            \ MY_INSTALL
            \ MY_INSTALL_CONFIGURATIONS
            \ MY_INSTALL_DESTINATION
            \ MY_INSTALL_FAST
            \ MY_INSTALL_OPTIONAL
            \ MY_INSTALL_RENAME
            \ MY_INSTALL_TARGETS
            \ MY_INSTALL_UNPARSED_ARGUMENTS
            \ OPTIONAL
            \ PARSE_ARGV
            \ RENAME
            \ TARGETS
            \ TRUE
            \ UNDEFINED
            \ _UNPARSED_ARGUMENTS

syn keyword cmakeKWcmake_policy contained
            \ CMAKE_POLICY_DEFAULT_CMP
            \ CMP
            \ GET
            \ NNNN
            \ NO_POLICY_SCOPE
            \ OLD
            \ POP
            \ PUSH
            \ SET
            \ VERSION

syn keyword cmakeKWconfigure_file contained
            \ COPYONLY
            \ CRLF
            \ DOS
            \ ESCAPE_QUOTES
            \ FOO_ENABLE
            \ FOO_STRING
            \ LF
            \ NEWLINE_STYLE
            \ VAR

syn keyword cmakeKWcreate_test_sourcelist contained
            \ CMAKE_TESTDRIVER_AFTER_TESTMAIN
            \ CMAKE_TESTDRIVER_BEFORE_TESTMAIN
            \ EXTRA_INCLUDE
            \ FUNCTION

syn keyword cmakeKWctest_build contained
            \ ALL_BUILD
            \ APPEND
            \ BUILD
            \ CAPTURE_CMAKE_ERROR
            \ CONFIGURATION
            \ CTEST_BUILD_CONFIGURATION
            \ CTEST_BUILD_FLAGS
            \ CTEST_BUILD_TARGET
            \ CTEST_PROJECT_NAME
            \ FLAGS
            \ NUMBER_ERRORS
            \ NUMBER_WARNINGS
            \ QUIET
            \ RETURN_VALUE
            \ TARGET

syn keyword cmakeKWctest_configure contained
            \ APPEND
            \ BUILD
            \ CAPTURE_CMAKE_ERROR
            \ OPTIONS
            \ QUIET
            \ RETURN_VALUE
            \ SOURCE

syn keyword cmakeKWctest_coverage contained
            \ APPEND
            \ BUILD
            \ CAPTURE_CMAKE_ERROR
            \ LABELS
            \ QUIET
            \ RETURN_VALUE

syn keyword cmakeKWctest_memcheck contained
            \ APPEND
            \ BUILD
            \ DEFECT_COUNT
            \ EXCLUDE
            \ EXCLUDE_FIXTURE
            \ EXCLUDE_FIXTURE_CLEANUP
            \ EXCLUDE_FIXTURE_SETUP
            \ EXCLUDE_LABEL
            \ INCLUDE
            \ INCLUDE_LABEL
            \ OFF
            \ ON
            \ PARALLEL_LEVEL
            \ QUIET
            \ RETURN_VALUE
            \ SCHEDULE_RANDOM
            \ START
            \ STOP_TIME
            \ STRIDE
            \ TEST_LOAD

syn keyword cmakeKWctest_run_script contained
            \ NEW_PROCESS
            \ RETURN_VALUE

syn keyword cmakeKWctest_start contained
            \ APPEND
            \ QUIET
            \ TAG
            \ TRACK

syn keyword cmakeKWctest_submit contained
            \ API
            \ CAPTURE_CMAKE_ERROR
            \ CDASH_UPLOAD
            \ CDASH_UPLOAD_TYPE
            \ CTEST_EXTRA_SUBMIT_FILES
            \ CTEST_NOTES_FILES
            \ FILES
            \ HTTPHEADER
            \ PARTS
            \ QUIET
            \ RETRY_COUNT
            \ RETRY_DELAY
            \ RETURN_VALUE

syn keyword cmakeKWctest_test contained
            \ APPEND
            \ BUILD
            \ CAPTURE_CMAKE_ERROR
            \ CPU
            \ EXCLUDE
            \ EXCLUDE_FIXTURE
            \ EXCLUDE_FIXTURE_CLEANUP
            \ EXCLUDE_FIXTURE_SETUP
            \ EXCLUDE_LABEL
            \ INCLUDE
            \ INCLUDE_LABEL
            \ OFF
            \ ON
            \ PARALLEL_LEVEL
            \ QUIET
            \ RETURN_VALUE
            \ SCHEDULE_RANDOM
            \ START
            \ STOP_TIME
            \ STRIDE
            \ TEST_LOAD

syn keyword cmakeKWctest_update contained
            \ CAPTURE_CMAKE_ERROR
            \ QUIET
            \ RETURN_VALUE
            \ SOURCE

syn keyword cmakeKWctest_upload contained
            \ CAPTURE_CMAKE_ERROR
            \ FILES
            \ QUIET

syn keyword cmakeKWdefine_property contained
            \ APPEND
            \ APPEND_STRING
            \ BRIEF_DOCS
            \ CACHED_VARIABLE
            \ DIRECTORY
            \ FULL_DOCS
            \ GLOBAL
            \ INHERITED
            \ PROPERTY
            \ SOURCE
            \ TARGET
            \ TEST
            \ VARIABLE

syn keyword cmakeKWenable_language contained
            \ ASM
            \ CUDA
            \ OPTIONAL

syn keyword cmakeKWexec_program contained
            \ ARGS
            \ OUTPUT_VARIABLE
            \ RETURN_VALUE

syn keyword cmakeKWexecute_process contained
            \ ANSI
            \ AUTO
            \ COMMAND
            \ ENCODING
            \ ERROR_FILE
            \ ERROR_QUIET
            \ ERROR_STRIP_TRAILING_WHITESPACE
            \ ERROR_VARIABLE
            \ INPUT_FILE
            \ NONE
            \ OEM
            \ OUTPUT_FILE
            \ OUTPUT_QUIET
            \ OUTPUT_STRIP_TRAILING_WHITESPACE
            \ OUTPUT_VARIABLE
            \ RESULTS_VARIABLE
            \ RESULT_VARIABLE
            \ RFC
            \ TIMEOUT
            \ UTF
            \ VERBATIM
            \ WORKING_DIRECTORY

syn keyword cmakeKWexport contained
            \ ANDROID_MK
            \ APPEND
            \ CONFIG
            \ EXPORT
            \ EXPORT_LINK_INTERFACE_LIBRARIES
            \ FILE
            \ IMPORTED
            \ IMPORTED_
            \ NAMESPACE
            \ NDK
            \ OLD
            \ PACKAGE
            \ TARGETS

syn keyword cmakeKWexport_library_dependencies contained
            \ APPEND
            \ EXPORT
            \ INCLUDE
            \ LINK_INTERFACE_LIBRARIES
            \ SET

syn keyword cmakeKWfile contained
            \ ALGO
            \ APPEND
            \ ASCII
            \ CMAKE_TLS_CAINFO
            \ CMAKE_TLS_VERIFY
            \ CONDITION
            \ CONFIG
            \ CONFIGURE_DEPENDS
            \ CONTENT
            \ COPY
            \ DESTINATION
            \ DIRECTORY_PERMISSIONS
            \ DOWNLOAD
            \ ENCODING
            \ EXCLUDE
            \ EXPECTED_HASH
            \ FILES_MATCHING
            \ FILE_PERMISSIONS
            \ FOLLOW_SYMLINKS
            \ FUNCTION
            \ GENERATE
            \ GLOB
            \ GLOB_RECURSE
            \ GUARD
            \ HASH
            \ HEX
            \ HTTPHEADER
            \ IGNORED
            \ INACTIVITY_TIMEOUT
            \ INSTALL
            \ LENGTH_MAXIMUM
            \ LENGTH_MINIMUM
            \ LF
            \ LIMIT
            \ LIMIT_COUNT
            \ LIMIT_INPUT
            \ LIMIT_OUTPUT
            \ LIST_DIRECTORIES
            \ LOCK
            \ LOG
            \ MAKE_DIRECTORY
            \ NETRC
            \ NETRC_FILE
            \ NEWLINE_CONSUME
            \ NO_HEX_CONVERSION
            \ NO_SOURCE_PERMISSIONS
            \ OFFSET
            \ OLD
            \ OPTIONAL
            \ OUTPUT
            \ PATTERN
            \ PROCESS
            \ READ
            \ REGEX
            \ RELATIVE_PATH
            \ RELEASE
            \ REMOVE
            \ REMOVE_RECURSE
            \ RENAME
            \ REQUIRED
            \ RESULT_VARIABLE
            \ SHOW_PROGRESS
            \ SSL
            \ STATUS
            \ STRINGS
            \ TIMESTAMP
            \ TLS_CAINFO
            \ TLS_VERIFY
            \ TOUCH
            \ TOUCH_NOCREATE
            \ TO_CMAKE_PATH
            \ TO_NATIVE_PATH
            \ UPLOAD
            \ URL
            \ USERPWD
            \ USE_SOURCE_PERMISSIONS
            \ UTC
            \ UTF
            \ WRITE

syn keyword cmakeKWfind_file contained
            \ CMAKE_FIND_ROOT_PATH_BOTH
            \ DOC
            \ DVAR
            \ HINTS
            \ INCLUDE
            \ NAMES
            \ NO_CMAKE_ENVIRONMENT_PATH
            \ NO_CMAKE_FIND_ROOT_PATH
            \ NO_CMAKE_PATH
            \ NO_CMAKE_SYSTEM_PATH
            \ NO_DEFAULT_PATH
            \ NO_PACKAGE_ROOT_PATH
            \ NO_SYSTEM_ENVIRONMENT_PATH
            \ ONLY_CMAKE_FIND_ROOT_PATH
            \ PATHS
            \ PATH_SUFFIXES
            \ VAR

syn keyword cmakeKWfind_library contained
            \ CMAKE_FIND_ROOT_PATH_BOTH
            \ DOC
            \ DVAR
            \ HINTS
            \ LIB
            \ NAMES
            \ NAMES_PER_DIR
            \ NO_CMAKE_ENVIRONMENT_PATH
            \ NO_CMAKE_FIND_ROOT_PATH
            \ NO_CMAKE_PATH
            \ NO_CMAKE_SYSTEM_PATH
            \ NO_DEFAULT_PATH
            \ NO_PACKAGE_ROOT_PATH
            \ NO_SYSTEM_ENVIRONMENT_PATH
            \ ONLY_CMAKE_FIND_ROOT_PATH
            \ PATHS
            \ PATH_SUFFIXES
            \ VAR

syn keyword cmakeKWfind_package contained
            \ ABI
            \ CMAKE_DISABLE_FIND_PACKAGE_
            \ CMAKE_FIND_ROOT_PATH_BOTH
            \ COMPONENTS
            \ CONFIG
            \ CONFIGS
            \ DEC
            \ DVAR
            \ EXACT
            \ HINTS
            \ MODULE
            \ NAMES
            \ NATURAL
            \ NO_CMAKE_BUILDS_PATH
            \ NO_CMAKE_ENVIRONMENT_PATH
            \ NO_CMAKE_FIND_ROOT_PATH
            \ NO_CMAKE_PACKAGE_REGISTRY
            \ NO_CMAKE_PATH
            \ NO_CMAKE_SYSTEM_PACKAGE_REGISTRY
            \ NO_CMAKE_SYSTEM_PATH
            \ NO_DEFAULT_PATH
            \ NO_MODULE
            \ NO_PACKAGE_ROOT_PATH
            \ NO_POLICY_SCOPE
            \ NO_SYSTEM_ENVIRONMENT_PATH
            \ ONLY_CMAKE_FIND_ROOT_PATH
            \ OPTIONAL_COMPONENTS
            \ PACKAGE_FIND_NAME
            \ PACKAGE_FIND_VERSION
            \ PACKAGE_FIND_VERSION_COUNT
            \ PACKAGE_FIND_VERSION_MAJOR
            \ PACKAGE_FIND_VERSION_MINOR
            \ PACKAGE_FIND_VERSION_PATCH
            \ PACKAGE_FIND_VERSION_TWEAK
            \ PACKAGE_VERSION
            \ PACKAGE_VERSION_COMPATIBLE
            \ PACKAGE_VERSION_EXACT
            \ PACKAGE_VERSION_UNSUITABLE
            \ PATHS
            \ PATH_SUFFIXES
            \ QUIET
            \ REQUIRED
            \ SET
            \ TRUE
            \ _CONFIG
            \ _CONSIDERED_CONFIGS
            \ _CONSIDERED_VERSIONS
            \ _DIR
            \ _FIND_COMPONENTS
            \ _FIND_QUIETLY
            \ _FIND_REQUIRED
            \ _FIND_REQUIRED_
            \ _FIND_VERSION_EXACT
            \ _FOUND

syn keyword cmakeKWfind_path contained
            \ CMAKE_FIND_ROOT_PATH_BOTH
            \ DOC
            \ DVAR
            \ HINTS
            \ INCLUDE
            \ NAMES
            \ NO_CMAKE_ENVIRONMENT_PATH
            \ NO_CMAKE_FIND_ROOT_PATH
            \ NO_CMAKE_PATH
            \ NO_CMAKE_SYSTEM_PATH
            \ NO_DEFAULT_PATH
            \ NO_PACKAGE_ROOT_PATH
            \ NO_SYSTEM_ENVIRONMENT_PATH
            \ ONLY_CMAKE_FIND_ROOT_PATH
            \ PATHS
            \ PATH_SUFFIXES
            \ VAR

syn keyword cmakeKWfind_program contained
            \ CMAKE_FIND_ROOT_PATH_BOTH
            \ DOC
            \ DVAR
            \ HINTS
            \ NAMES
            \ NAMES_PER_DIR
            \ NO_CMAKE_ENVIRONMENT_PATH
            \ NO_CMAKE_FIND_ROOT_PATH
            \ NO_CMAKE_PATH
            \ NO_CMAKE_SYSTEM_PATH
            \ NO_DEFAULT_PATH
            \ NO_PACKAGE_ROOT_PATH
            \ NO_SYSTEM_ENVIRONMENT_PATH
            \ ONLY_CMAKE_FIND_ROOT_PATH
            \ PATHS
            \ PATH_SUFFIXES
            \ VAR

syn keyword cmakeKWfltk_wrap_ui contained
            \ FLTK

syn keyword cmakeKWforeach contained
            \ ARGS
            \ IN
            \ ITEMS
            \ LISTS
            \ RANGE

syn keyword cmakeKWfunction contained
            \ ARGC
            \ ARGN
            \ ARGS
            \ ARGV
            \ PARENT_SCOPE

syn keyword cmakeKWget_cmake_property contained
            \ COMPONENTS
            \ GLOBAL
            \ MACROS
            \ VAR
            \ VARIABLES

syn keyword cmakeKWget_directory_property contained
            \ DEFINITION
            \ DIRECTORY
            \ INHERITED

syn keyword cmakeKWget_filename_component contained
            \ ABSOLUTE
            \ ARG_VAR
            \ BASE_DIR
            \ COMP
            \ DIRECTORY
            \ EXT
            \ NAME
            \ NAME_WE
            \ PATH
            \ PROGRAM
            \ PROGRAM_ARGS
            \ REALPATH
            \ VAR

syn keyword cmakeKWget_property contained
            \ BRIEF_DOCS
            \ DEFINED
            \ DIRECTORY
            \ FULL_DOCS
            \ GLOBAL
            \ INSTALL
            \ PROPERTY
            \ SET
            \ SOURCE
            \ TARGET
            \ TEST
            \ VARIABLE

syn keyword cmakeKWget_source_file_property contained
            \ INHERITED
            \ LOCATION
            \ VAR

syn keyword cmakeKWget_target_property contained
            \ INHERITED
            \ VAR

syn keyword cmakeKWget_test_property contained
            \ INHERITED
            \ VAR

syn keyword cmakeKWif contained
            \ ARGS
            \ CMAKE_MATCH_
            \ CMP
            \ COMMAND
            \ DEFINED
            \ EQUAL
            \ EXISTS
            \ FALSE
            \ GREATER
            \ GREATER_EQUAL
            \ IGNORE
            \ IN_LIST
            \ IS_ABSOLUTE
            \ IS_DIRECTORY
            \ IS_NEWER_THAN
            \ IS_SYMLINK
            \ LESS
            \ LESS_EQUAL
            \ MATCHES
            \ NNNN
            \ NOT
            \ OFF
            \ OR
            \ POLICY
            \ STREQUAL
            \ STRGREATER
            \ STRGREATER_EQUAL
            \ STRLESS
            \ STRLESS_EQUAL
            \ TARGET
            \ TEST
            \ THEN
            \ TRUE
            \ VERSION_EQUAL
            \ VERSION_GREATER
            \ VERSION_GREATER_EQUAL
            \ VERSION_LESS
            \ VERSION_LESS_EQUAL
            \ YES

syn keyword cmakeKWinclude contained
            \ NO_POLICY_SCOPE
            \ OPTIONAL
            \ RESULT_VARIABLE

syn keyword cmakeKWinclude_directories contained
            \ AFTER
            \ BEFORE
            \ INCLUDE_DIRECTORIES
            \ ON
            \ SYSTEM

syn keyword cmakeKWinclude_external_msproject contained
            \ GUID
            \ MAP_IMPORTED_CONFIG_
            \ PLATFORM
            \ TYPE
            \ WIX

syn keyword cmakeKWinclude_guard contained
            \ DIRECTORY
            \ GLOBAL
            \ TRUE
            \ __CURRENT_FILE_VAR__

syn keyword cmakeKWinstall contained
            \ AFTER
            \ APT
            \ ARCHIVE
            \ BEFORE
            \ BUILD_TYPE
            \ BUNDLE
            \ CODE
            \ COMPONENT
            \ CONFIGURATIONS
            \ CVS
            \ DBUILD_TYPE
            \ DCOMPONENT
            \ DESTDIR
            \ DESTINATION
            \ DIRECTORY
            \ DIRECTORY_PERMISSIONS
            \ DLL
            \ EXCLUDE_FROM_ALL
            \ EXPORT
            \ EXPORT_ANDROID_MK
            \ EXPORT_LINK_INTERFACE_LIBRARIES
            \ FILES
            \ FILES_MATCHING
            \ FILE_PERMISSIONS
            \ FRAMEWORK
            \ GROUP_EXECUTE
            \ GROUP_READ
            \ GROUP_WRITE
            \ IMPORTED_
            \ INCLUDES
            \ INSTALL_PREFIX
            \ INTERFACE_INCLUDE_DIRECTORIES
            \ LIBRARY
            \ MACOSX_BUNDLE
            \ MESSAGE_NEVER
            \ NAMELINK_COMPONENT
            \ NAMELINK_ONLY
            \ NAMELINK_SKIP
            \ NAMESPACE
            \ NDK
            \ OBJECTS
            \ OPTIONAL
            \ OWNER_EXECUTE
            \ OWNER_READ
            \ OWNER_WRITE
            \ PATTERN
            \ PERMISSIONS
            \ POST_INSTALL_SCRIPT
            \ PRE_INSTALL_SCRIPT
            \ PRIVATE_HEADER
            \ PROGRAMS
            \ PUBLIC_HEADER
            \ REGEX
            \ RENAME
            \ RESOURCE
            \ RPM
            \ RUNTIME
            \ SCRIPT
            \ SETGID
            \ SETUID
            \ SOVERSION
            \ TARGETS
            \ TRUE
            \ USE_SOURCE_PERMISSIONS
            \ VERSION
            \ WORLD_EXECUTE
            \ WORLD_READ
            \ WORLD_WRITE

syn keyword cmakeKWinstall_files contained
            \ FILES
            \ GLOB

syn keyword cmakeKWinstall_programs contained
            \ FILES
            \ GLOB
            \ PROGRAMS
            \ TARGETS

syn keyword cmakeKWinstall_targets contained
            \ DLL
            \ RUNTIME_DIRECTORY
            \ TARGETS

syn keyword cmakeKWlink_directories contained
            \ AFTER
            \ BEFORE
            \ LINK_DIRECTORIES
            \ ON
            \ ORIGIN
            \ RPATH

syn keyword cmakeKWlist contained
            \ ACTION
            \ APPEND
            \ ASCENDING
            \ CASE
            \ COMPARE
            \ DESCENDING
            \ EXCLUDE
            \ FILE_BASENAME
            \ FILTER
            \ FIND
            \ GENEX_STRIP
            \ GET
            \ INCLUDE
            \ INSENSITIVE
            \ INSERT
            \ INTERNAL
            \ JOIN
            \ LENGTH
            \ ORDER
            \ OUTPUT_VARIABLE
            \ PARENT_SCOPE
            \ PREPEND
            \ REGEX
            \ REMOVE_AT
            \ REMOVE_DUPLICATES
            \ REMOVE_ITEM
            \ REPLACE
            \ REVERSE
            \ SELECTOR
            \ SENSITIVE
            \ SORT
            \ STRING
            \ STRIP
            \ SUBLIST
            \ TOLOWER
            \ TOUPPER
            \ TRANSFORM

syn keyword cmakeKWload_cache contained
            \ EXCLUDE
            \ INCLUDE_INTERNALS
            \ READ_WITH_PREFIX

syn keyword cmakeKWload_command contained
            \ CMAKE_LOADED_COMMAND_
            \ COMMAND_NAME

syn keyword cmakeKWmacro contained
            \ ARGC
            \ ARGN
            \ ARGS
            \ ARGV
            \ DEFINED
            \ GREATER
            \ LISTS
            \ NOT
            \ _BAR
            \ _FOO

syn keyword cmakeKWmake_directory contained
            \ MAKE_DIRECTORY

syn keyword cmakeKWmark_as_advanced contained
            \ CLEAR
            \ FORCE
            \ VAR

syn keyword cmakeKWmath contained
            \ EXPR
            \ HEXADECIMAL
            \ OUTPUT_FORMAT

syn keyword cmakeKWmessage contained
            \ AUTHOR_WARNING
            \ DEPRECATION
            \ FATAL_ERROR
            \ GUI
            \ SEND_ERROR
            \ STATUS
            \ WARNING

syn keyword cmakeKWoption contained
            \ OFF
            \ ON

syn keyword cmakeKWproject contained
            \ ASM
            \ CMAKE_PROJECT_
            \ CUDA
            \ DESCRIPTION
            \ HOMEPAGE_URL
            \ LANGUAGES
            \ NAME
            \ NONE
            \ PROJECT
            \ VERSION
            \ _BINARY_DIR
            \ _DESCRIPTION
            \ _HOMEPAGE_URL
            \ _INCLUDE
            \ _SOURCE_DIR
            \ _VERSION
            \ _VERSION_MAJOR
            \ _VERSION_MINOR
            \ _VERSION_PATCH
            \ _VERSION_TWEAK

syn keyword cmakeKWremove contained
            \ REMOVE_ITEM
            \ VALUE
            \ VAR

syn keyword cmakeKWseparate_arguments contained
            \ MSDN
            \ NATIVE
            \ NATIVE_COMMAND
            \ UNIX_COMMAND
            \ WINDOWS
            \ WINDOWS_COMMAND
            \ _COMMAND

syn keyword cmakeKWset contained
            \ BOOL
            \ FILEPATH
            \ FORCE
            \ INTERNAL
            \ OFF
            \ ON
            \ PARENT_SCOPE
            \ STRING
            \ STRINGS

syn keyword cmakeKWset_directory_properties contained
            \ PROPERTIES

syn keyword cmakeKWset_property contained
            \ APPEND
            \ APPEND_STRING
            \ DIRECTORY
            \ GLOBAL
            \ INHERITED
            \ INSTALL
            \ PROPERTY
            \ SOURCE
            \ TARGET
            \ TEST
            \ WIX

syn keyword cmakeKWset_source_files_properties contained
            \ PROPERTIES

syn keyword cmakeKWset_target_properties contained
            \ PROPERTIES
            \ TARGET

syn keyword cmakeKWset_tests_properties contained
            \ PROPERTIES

syn keyword cmakeKWsource_group contained
            \ FILES
            \ PREFIX
            \ REGULAR_EXPRESSION
            \ TREE

syn keyword cmakeKWstring contained
            \ ALPHABET
            \ APPEND
            \ ASCII
            \ CMAKE_MATCH_
            \ COMPARE
            \ CONCAT
            \ CONFIGURE
            \ EQUAL
            \ ESCAPE_QUOTES
            \ FIND
            \ GENEX_STRIP
            \ GREATER
            \ GREATER_EQUAL
            \ GUID
            \ HASH
            \ JOIN
            \ LENGTH
            \ LESS
            \ LESS_EQUAL
            \ MAKE_C_IDENTIFIER
            \ MATCH
            \ MATCHALL
            \ MATCHES
            \ NAMESPACE
            \ NOTEQUAL
            \ ONLY
            \ PREPEND
            \ RANDOM
            \ RANDOM_SEED
            \ REGEX
            \ REPLACE
            \ REVERSE
            \ RFC
            \ SHA
            \ SOURCE_DATE_EPOCH
            \ STRIP
            \ SUBSTRING
            \ SZ
            \ TIMESTAMP
            \ TOLOWER
            \ TOUPPER
            \ TYPE
            \ US
            \ UTC
            \ UUID

syn keyword cmakeKWsubdirs contained
            \ EXCLUDE_FROM_ALL
            \ PREORDER

syn keyword cmakeKWtarget_compile_definitions contained
            \ ALIAS
            \ COMPILE_DEFINITIONS
            \ FOO
            \ IMPORTED
            \ INTERFACE
            \ INTERFACE_COMPILE_DEFINITIONS
            \ PRIVATE
            \ PUBLIC

syn keyword cmakeKWtarget_compile_features contained
            \ ALIAS
            \ COMPILE_FEATURES
            \ IMPORTED
            \ INTERFACE
            \ INTERFACE_COMPILE_FEATURES
            \ PRIVATE
            \ PUBLIC

syn keyword cmakeKWtarget_compile_options contained
            \ ALIAS
            \ BEFORE
            \ COMPILE_OPTIONS
            \ IMPORTED
            \ INTERFACE
            \ INTERFACE_COMPILE_OPTIONS
            \ PRIVATE
            \ PUBLIC
            \ SHELL
            \ UNIX_COMMAND

syn keyword cmakeKWtarget_include_directories contained
            \ ALIAS
            \ BEFORE
            \ BUILD_INTERFACE
            \ IMPORTED
            \ INCLUDE_DIRECTORIES
            \ INSTALL_INTERFACE
            \ INTERFACE
            \ INTERFACE_INCLUDE_DIRECTORIES
            \ INTERFACE_LINK_LIBRARIES
            \ INTERFACE_SYSTEM_INCLUDE_DIRECTORIES
            \ PRIVATE
            \ PUBLIC
            \ SYSTEM

syn keyword cmakeKWtarget_link_directories contained
            \ ALIAS
            \ BEFORE
            \ IMPORTED
            \ INTERFACE
            \ INTERFACE_LINK_DIRECTORIES
            \ LINK_DIRECTORIES
            \ ORIGIN
            \ PRIVATE
            \ PUBLIC
            \ RPATH

syn keyword cmakeKWtarget_link_libraries contained
            \ ALIAS
            \ DA
            \ DAG
            \ DEBUG_CONFIGURATIONS
            \ DOBJ
            \ IMPORTED
            \ IMPORTED_NO_SONAME
            \ INTERFACE
            \ INTERFACE_LINK_LIBRARIES
            \ LINK_INTERFACE_LIBRARIES
            \ LINK_INTERFACE_LIBRARIES_DEBUG
            \ LINK_INTERFACE_MULTIPLICITY
            \ LINK_OPTIONS
            \ LINK_PRIVATE
            \ LINK_PUBLIC
            \ OBJECT
            \ OLD
            \ OSX
            \ PRIVATE
            \ PUBLIC
            \ SHARED
            \ STATIC

syn keyword cmakeKWtarget_link_options contained
            \ ALIAS
            \ BEFORE
            \ CMAKE_
            \ GCC
            \ GNU
            \ IMPORTED
            \ INTERFACE
            \ INTERFACE_LINK_OPTIONS
            \ LANG
            \ LINKER
            \ LINK_OPTIONS
            \ PRIVATE
            \ PUBLIC
            \ SHELL
            \ UNIX_COMMAND
            \ _LINKER_WRAPPER_FLAG
            \ _LINKER_WRAPPER_FLAG_SEP

syn keyword cmakeKWtarget_sources contained
            \ ALIAS
            \ IMPORTED
            \ INTERFACE
            \ INTERFACE_SOURCES
            \ PRIVATE
            \ PUBLIC
            \ SOURCES

syn keyword cmakeKWtry_compile contained
            \ ALL_BUILD
            \ CMAKE_FLAGS
            \ COMPILE_DEFINITIONS
            \ COPY_FILE
            \ COPY_FILE_ERROR
            \ CUDA_EXTENSIONS
            \ CUDA_STANDARD
            \ CUDA_STANDARD_REQUIRED
            \ CXX_EXTENSIONS
            \ CXX_STANDARD
            \ CXX_STANDARD_REQUIRED
            \ C_EXTENSIONS
            \ C_STANDARD
            \ C_STANDARD_REQUIRED
            \ DEFINED
            \ DLINK_LIBRARIES
            \ DVAR
            \ FALSE
            \ INCLUDE_DIRECTORIES
            \ LANG
            \ LINK_DIRECTORIES
            \ LINK_LIBRARIES
            \ NOT
            \ OUTPUT_VARIABLE
            \ RESULT_VAR
            \ SOURCES
            \ TRUE
            \ TYPE
            \ VALUE
            \ _EXTENSIONS
            \ _STANDARD
            \ _STANDARD_REQUIRED

syn keyword cmakeKWtry_run contained
            \ ARGS
            \ CMAKE_FLAGS
            \ COMPILE_DEFINITIONS
            \ COMPILE_OUTPUT_VARIABLE
            \ COMPILE_RESULT_VAR
            \ DLINK_LIBRARIES
            \ DVAR
            \ FAILED_TO_RUN
            \ FALSE
            \ INCLUDE_DIRECTORIES
            \ LINK_DIRECTORIES
            \ LINK_LIBRARIES
            \ RUN_OUTPUT_VARIABLE
            \ RUN_RESULT_VAR
            \ TRUE
            \ TYPE
            \ VALUE
            \ __TRYRUN_OUTPUT

syn keyword cmakeKWunset contained
            \ LD_LIBRARY_PATH
            \ PARENT_SCOPE
            \ VAR

syn keyword cmakeKWuse_mangled_mesa contained
            \ GL
            \ OUTPUT_DIRECTORY
            \ PATH_TO_MESA

syn keyword cmakeKWvariable_requires contained
            \ RESULT_VARIABLE
            \ TEST_VARIABLE

syn keyword cmakeKWvariable_watch contained
            \ COMMAND

syn keyword cmakeKWwhile contained
            \ ARGS

syn keyword cmakeKWwrite_file contained
            \ APPEND
            \ CONFIGURE_FILE
            \ NOTE
            \ WRITE


syn keyword cmakeGeneratorExpressions contained
            \ AND
            \ ANGLE
            \ BOOL
            \ BUILD_INTERFACE
            \ CMAKE_
            \ CMAKE_CXX_COMPILER_VERSION
            \ COMMA
            \ COMMAND
            \ COMPILE_DEFINITIONS
            \ COMPILE_FEATURES
            \ COMPILE_LANGUAGE
            \ COMPILING_CUDA
            \ COMPILING_CXX
            \ CONFIG
            \ CONFIGURATION
            \ CUDA
            \ CUSTOM_KEYS
            \ CXX_COMPILER_ID
            \ CXX_COMPILER_VERSION
            \ CXX_STANDARD
            \ C_COMPILER_ID
            \ C_COMPILER_VERSION
            \ C_STANDARD
            \ DEBUG_MODE
            \ EXPORT
            \ FOO_EXTRA_THINGS
            \ Fortran_COMPILER_ID
            \ Fortran_COMPILER_VERSION
            \ GENEX_EVAL
            \ GNU
            \ IF
            \ INCLUDE_DIRECTORIES
            \ INSTALL_INTERFACE
            \ INSTALL_PREFIX
            \ INTERFACE_LINK_LIBRARIES
            \ IN_LIST
            \ JOIN
            \ LANG
            \ LINK_LIBRARIES
            \ LINK_ONLY
            \ LOWER_CASE
            \ MAKE_C_IDENTIFIER
            \ MAP_IMPORTED_CONFIG_
            \ MSYS
            \ NOT
            \ OBJECT_LIBRARY
            \ OLD_COMPILER
            \ PDB_NAME
            \ PDB_NAME_
            \ PDB_OUTPUT_DIRECTORY
            \ PDB_OUTPUT_DIRECTORY_
            \ PLATFORM_ID
            \ PRIVATE
            \ PUBLIC
            \ SDK
            \ SEMICOLON
            \ SHELL_PATH
            \ STREQUAL
            \ TARGET_BUNDLE_CONTENT_DIR
            \ TARGET_BUNDLE_DIR
            \ TARGET_EXISTS
            \ TARGET_FILE
            \ TARGET_FILE_DIR
            \ TARGET_FILE_NAME
            \ TARGET_GENEX_EVAL
            \ TARGET_LINKER_FILE
            \ TARGET_LINKER_FILE_DIR
            \ TARGET_LINKER_FILE_NAME
            \ TARGET_NAME
            \ TARGET_NAME_IF_EXISTS
            \ TARGET_OBJECTS
            \ TARGET_PDB_FILE
            \ TARGET_PDB_FILE_DIR
            \ TARGET_PDB_FILE_NAME
            \ TARGET_POLICY
            \ TARGET_PROPERTY
            \ TARGET_SONAME_FILE
            \ TARGET_SONAME_FILE_DIR
            \ TARGET_SONAME_FILE_NAME
            \ UPPER_CASE
            \ VERSION_EQUAL
            \ VERSION_GREATER
            \ VERSION_GREATER_EQUAL
            \ VERSION_LESS
            \ VERSION_LESS_EQUAL

syn case ignore

syn keyword cmakeCommand
            \ add_compile_definitions
            \ add_compile_options
            \ add_custom_command
            \ add_custom_target
            \ add_definitions
            \ add_dependencies
            \ add_executable
            \ add_library
            \ add_link_options
            \ add_subdirectory
            \ add_test
            \ aux_source_directory
            \ break
            \ build_command
            \ cmake_host_system_information
            \ cmake_minimum_required
            \ cmake_parse_arguments
            \ cmake_policy
            \ configure_file
            \ continue
            \ create_test_sourcelist
            \ ctest_build
            \ ctest_configure
            \ ctest_coverage
            \ ctest_empty_binary_directory
            \ ctest_memcheck
            \ ctest_read_custom_files
            \ ctest_run_script
            \ ctest_sleep
            \ ctest_start
            \ ctest_submit
            \ ctest_test
            \ ctest_update
            \ ctest_upload
            \ define_property
            \ enable_language
            \ enable_testing
            \ endfunction
            \ endmacro
            \ execute_process
            \ export
            \ file
            \ find_file
            \ find_library
            \ find_package
            \ find_path
            \ find_program
            \ fltk_wrap_ui
            \ function
            \ get_cmake_property
            \ get_directory_property
            \ get_filename_component
            \ get_property
            \ get_source_file_property
            \ get_target_property
            \ get_test_property
            \ include
            \ include_directories
            \ include_external_msproject
            \ include_guard
            \ include_regular_expression
            \ install
            \ link_directories
            \ list
            \ load_cache
            \ load_command
            \ macro
            \ mark_as_advanced
            \ math
            \ message
            \ option
            \ project
            \ qt_wrap_cpp
            \ qt_wrap_ui
            \ remove_definitions
            \ return
            \ separate_arguments
            \ set
            \ set_directory_properties
            \ set_property
            \ set_source_files_properties
            \ set_target_properties
            \ set_tests_properties
            \ site_name
            \ source_group
            \ string
            \ target_compile_definitions
            \ target_compile_features
            \ target_compile_options
            \ target_include_directories
            \ target_link_directories
            \ target_link_libraries
            \ target_link_options
            \ target_sources
            \ try_compile
            \ try_run
            \ unset
            \ variable_watch
            \ nextgroup=cmakeArguments

syn keyword cmakeCommandConditional
            \ else
            \ elseif
            \ endif
            \ if
            \ nextgroup=cmakeArguments

syn keyword cmakeCommandRepeat
            \ endforeach
            \ endwhile
            \ foreach
            \ while
            \ nextgroup=cmakeArguments

syn keyword cmakeCommandDeprecated
            \ build_name
            \ exec_program
            \ export_library_dependencies
            \ install_files
            \ install_programs
            \ install_targets
            \ link_libraries
            \ make_directory
            \ output_required_files
            \ remove
            \ subdir_depends
            \ subdirs
            \ use_mangled_mesa
            \ utility_source
            \ variable_requires
            \ write_file
            \ nextgroup=cmakeArguments

syn case match

syn keyword cmakeTodo
            \ TODO FIXME XXX
            \ contained

hi def link cmakeBracketArgument String
hi def link cmakeBracketComment Comment
hi def link cmakeCommand Function
hi def link cmakeCommandConditional Conditional
hi def link cmakeCommandDeprecated WarningMsg
hi def link cmakeCommandRepeat Repeat
hi def link cmakeComment Comment
hi def link cmakeEnvironment Special
hi def link cmakeEscaped Special
hi def link cmakeGeneratorExpression Special
hi def link cmakeGeneratorExpressions Constant
hi def link cmakeModule Include
hi def link cmakeProperty Constant
hi def link cmakeRegistry Underlined
hi def link cmakeString String
hi def link cmakeTodo TODO
hi def link cmakeVariableValue Type
hi def link cmakeVariable Identifier

hi def link cmakeKWExternalProject ModeMsg
hi def link cmakeKWadd_compile_definitions ModeMsg
hi def link cmakeKWadd_compile_options ModeMsg
hi def link cmakeKWadd_custom_command ModeMsg
hi def link cmakeKWadd_custom_target ModeMsg
hi def link cmakeKWadd_definitions ModeMsg
hi def link cmakeKWadd_dependencies ModeMsg
hi def link cmakeKWadd_executable ModeMsg
hi def link cmakeKWadd_library ModeMsg
hi def link cmakeKWadd_link_options ModeMsg
hi def link cmakeKWadd_subdirectory ModeMsg
hi def link cmakeKWadd_test ModeMsg
hi def link cmakeKWbuild_command ModeMsg
hi def link cmakeKWbuild_name ModeMsg
hi def link cmakeKWcmake_host_system_information ModeMsg
hi def link cmakeKWcmake_minimum_required ModeMsg
hi def link cmakeKWcmake_parse_arguments ModeMsg
hi def link cmakeKWcmake_policy ModeMsg
hi def link cmakeKWconfigure_file ModeMsg
hi def link cmakeKWcreate_test_sourcelist ModeMsg
hi def link cmakeKWctest_build ModeMsg
hi def link cmakeKWctest_configure ModeMsg
hi def link cmakeKWctest_coverage ModeMsg
hi def link cmakeKWctest_memcheck ModeMsg
hi def link cmakeKWctest_run_script ModeMsg
hi def link cmakeKWctest_start ModeMsg
hi def link cmakeKWctest_submit ModeMsg
hi def link cmakeKWctest_test ModeMsg
hi def link cmakeKWctest_update ModeMsg
hi def link cmakeKWctest_upload ModeMsg
hi def link cmakeKWdefine_property ModeMsg
hi def link cmakeKWenable_language ModeMsg
hi def link cmakeKWexec_program ModeMsg
hi def link cmakeKWexecute_process ModeMsg
hi def link cmakeKWexport ModeMsg
hi def link cmakeKWexport_library_dependencies ModeMsg
hi def link cmakeKWfile ModeMsg
hi def link cmakeKWfind_file ModeMsg
hi def link cmakeKWfind_library ModeMsg
hi def link cmakeKWfind_package ModeMsg
hi def link cmakeKWfind_path ModeMsg
hi def link cmakeKWfind_program ModeMsg
hi def link cmakeKWfltk_wrap_ui ModeMsg
hi def link cmakeKWforeach ModeMsg
hi def link cmakeKWfunction ModeMsg
hi def link cmakeKWget_cmake_property ModeMsg
hi def link cmakeKWget_directory_property ModeMsg
hi def link cmakeKWget_filename_component ModeMsg
hi def link cmakeKWget_property ModeMsg
hi def link cmakeKWget_source_file_property ModeMsg
hi def link cmakeKWget_target_property ModeMsg
hi def link cmakeKWget_test_property ModeMsg
hi def link cmakeKWif ModeMsg
hi def link cmakeKWinclude ModeMsg
hi def link cmakeKWinclude_directories ModeMsg
hi def link cmakeKWinclude_external_msproject ModeMsg
hi def link cmakeKWinclude_guard ModeMsg
hi def link cmakeKWinstall ModeMsg
hi def link cmakeKWinstall_files ModeMsg
hi def link cmakeKWinstall_programs ModeMsg
hi def link cmakeKWinstall_targets ModeMsg
hi def link cmakeKWlink_directories ModeMsg
hi def link cmakeKWlist ModeMsg
hi def link cmakeKWload_cache ModeMsg
hi def link cmakeKWload_command ModeMsg
hi def link cmakeKWmacro ModeMsg
hi def link cmakeKWmake_directory ModeMsg
hi def link cmakeKWmark_as_advanced ModeMsg
hi def link cmakeKWmath ModeMsg
hi def link cmakeKWmessage ModeMsg
hi def link cmakeKWoption ModeMsg
hi def link cmakeKWproject ModeMsg
hi def link cmakeKWremove ModeMsg
hi def link cmakeKWseparate_arguments ModeMsg
hi def link cmakeKWset ModeMsg
hi def link cmakeKWset_directory_properties ModeMsg
hi def link cmakeKWset_property ModeMsg
hi def link cmakeKWset_source_files_properties ModeMsg
hi def link cmakeKWset_target_properties ModeMsg
hi def link cmakeKWset_tests_properties ModeMsg
hi def link cmakeKWsource_group ModeMsg
hi def link cmakeKWstring ModeMsg
hi def link cmakeKWsubdirs ModeMsg
hi def link cmakeKWtarget_compile_definitions ModeMsg
hi def link cmakeKWtarget_compile_features ModeMsg
hi def link cmakeKWtarget_compile_options ModeMsg
hi def link cmakeKWtarget_include_directories ModeMsg
hi def link cmakeKWtarget_link_directories ModeMsg
hi def link cmakeKWtarget_link_libraries ModeMsg
hi def link cmakeKWtarget_link_options ModeMsg
hi def link cmakeKWtarget_sources ModeMsg
hi def link cmakeKWtry_compile ModeMsg
hi def link cmakeKWtry_run ModeMsg
hi def link cmakeKWunset ModeMsg
hi def link cmakeKWuse_mangled_mesa ModeMsg
hi def link cmakeKWvariable_requires ModeMsg
hi def link cmakeKWvariable_watch ModeMsg
hi def link cmakeKWwhile ModeMsg
hi def link cmakeKWwrite_file ModeMsg

" Manually added - difficult to parse out of documentation
syn case ignore

syn keyword cmakeCommandManuallyAdded
            \ configure_package_config_file write_basic_package_version_file
            \ nextgroup=cmakeArguments

syn case match

syn keyword cmakeKWconfigure_package_config_file contained
            \ INSTALL_DESTINATION PATH_VARS NO_SET_AND_CHECK_MACRO NO_CHECK_REQUIRED_COMPONENTS_MACRO INSTALL_PREFIX

syn keyword cmakeKWconfigure_package_config_file_constants contained
            \ AnyNewerVersion SameMajorVersion SameMinorVersion ExactVersion

syn keyword cmakeKWwrite_basic_package_version_file contained
            \ VERSION COMPATIBILITY

hi def link cmakeCommandManuallyAdded Function

hi def link cmakeKWconfigure_package_config_file ModeMsg
hi def link cmakeKWwrite_basic_package_version_file ModeMsg
hi def link cmakeKWconfigure_package_config_file_constants Constant

let b:current_syntax = "cmake"

let &cpo = s:keepcpo
unlet s:keepcpo

" vim: set nowrap:
