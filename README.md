# Common build primitives for CMake modules

These build primitives provide targets to statically analyze and test
a CMake module using `cmake-unit`, `style-linter-cmake` and
`cmake-linter-cmake`.

## Dependencies

Note that in order to avoid a circular dependency, this module has no other
dependencies. You will need to install the following modules with
conan to satisfy dependencies:
 - cmake-linter-cmake
 - style-linter-cmake
