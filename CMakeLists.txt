# /CMakeLists.txt
#
# Main entry point for CMakeModuleCommon tests.
#
# See /LICENCE.md for Copyright information

include ("${CMAKE_CURRENT_LIST_DIR}/conanbuildinfo.cmake")
set (CMAKE_MODULE_PATH
     "${CMAKE_CURRENT_LIST_DIR}"
     ${CONAN_CMAKE_MODULE_PATH}  # NOLINT:correctness/quotes
     ${CMAKE_MODULE_PATH})  # NOLINT:correctness/quotes

cmake_minimum_required (VERSION 2.8)

include (Common)

set (_CUR_LIST_DIR "${CMAKE_CURRENT_LIST_DIR}")
set (CMAKE_FILES
     "${_CUR_LIST_DIR}/Common.cmake"
     "${_CUR_LIST_DIR}/CMakeLists.txt")
set (MARKDOWN_FILES
     "${CMAKE_CURRENT_LIST_DIR}/LICENSE.md"
     "${CMAKE_CURRENT_LIST_DIR}/README.md")

cmake_module_add_common_targets (NAMESPACE cmake_module
                                 CMAKE_FILES ${CMAKE_FILES}
                                 DOCUMENTATION_FILES ${MARKDOWN_FILES})
