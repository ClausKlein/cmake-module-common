# /Common.cmake
#
# Common targets for cmake module projects.
#
# See /LICENCE.md for Copyright information

include (CMakeParseArguments)
include ("cmake/cmake-linter-cmake/CMakeLinter")
include ("cmake/style-linter-cmake/StyleGuideLint")
include ("cmake/cmake-unit/CMakeUnit")
include ("cmake/cmake-unit/CMakeUnitRunner")

function (cmake_module_add_common_targets)

    set (CMAKE_MODULE_SINGLEVAR_ARGS NAMESPACE)
    set (CMAKE_MODULE_MULTIVAR_ARGS CMAKE_FILES DOCUMENTATION_FILES)

    cmake_parse_arguments (CMAKE_MODULE
                           ""
                           "${CMAKE_MODULE_SINGLEVAR_ARGS}"
                           "${CMAKE_MODULE_MULTIVAR_ARGS}"
                           ${ARGN})

    cmake_unit_init (NAMESPACE ${CMAKE_MODULE_NAMESPACE}
                     COVERAGE_FILES ${CMAKE_MODULE_CMAKE_FILES})

    if (NOT "${_CMAKE_UNIT_PHASE}" # NOLINT:access/private_var
        STREQUAL "PRECONFIGURE")

        return ()

    endif ()

    cmake_lint_sources (cmakelint
                        CMAKELINT_BLACKLIST "whitespace/extra"
                                            "package/consistency"
                                            "whitespace/indent"
                        NAMESPACE ${CMAKE_MODULE_NAMESPACE}
                        SOURCES ${CMAKE_MODULE_CMAKE_FILES})

    style_guide_lint_sources (styleguidelint SOURCES ${CMAKE_FILES})
    style_guide_lint_spellcheck_sources (documentation-spelling
                                         SOURCES ${MARKDOWN_FILES})
    style_guide_lint_markdownlint_sources (markdownlint
                                           SOURCES ${MARKDOWN_FILES})
    style_guide_lint_create_global_spelling_check (spelling)

    add_custom_target (analysis ALL DEPENDS cmakelint
                                            styleguidelint
                                            documentation-spelling
                                            markdownlint
                                            spelling)

endfunction ()
