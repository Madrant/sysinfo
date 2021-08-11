# Check minimum required CMake version
cmake_minimum_required(VERSION 3.0)

# Set project name (package name, source archive name)
project(
    "peterbay-sysinfo"
    VERSION         1.0.0
    DESCRIPTION     "Python based script for obtaining system information from Linux"
    HOMEPAGE_URL    "https://github.com/peterbay/sysinfo"
)

# Check cmake directories
message("Source dir: ${CMAKE_SOURCE_DIR}") # cmake
message("Binary dir: ${CMAKE_BINARY_DIR}") # cmake/build

if("${CMAKE_SOURCE_DIR}" STREQUAL "${CMAKE_BINARY_DIR}")
    message(FATAL_ERROR "cmake in-source build are not allowed - please call cmake from 'build' directory")
endif()

# Set installation directory
set(INSTALL_PARENT "/usr/local/${PROJECT_NAME}")
set(PROJECT_TOP "${CMAKE_SOURCE_DIR}/..")

message("Project: ${PROJECT_NAME} version: '${PROJECT_VERSION}'")

# Install section:
install(
    FILES ${PROJECT_TOP}/sysinfo
    PERMISSIONS OWNER_EXECUTE OWNER_WRITE OWNER_READ GROUP_EXECUTE GROUP_READ WORLD_EXECUTE WORLD_READ
    DESTINATION ${INSTALL_PARENT}
)

install(
    FILES ${PROJECT_TOP}/sysinfo.py
    PERMISSIONS OWNER_WRITE OWNER_READ GROUP_READ WORLD_READ
    DESTINATION ${INSTALL_PARENT}
)

install(
    FILES ${PROJECT_TOP}/LICENSE
    PERMISSIONS OWNER_WRITE OWNER_READ GROUP_READ WORLD_READ
    DESTINATION ${INSTALL_PARENT}
)

install(
    FILES ${PROJECT_TOP}/README.md
    PERMISSIONS OWNER_WRITE OWNER_READ GROUP_READ WORLD_READ
    DESTINATION ${INSTALL_PARENT}
)

install(
    DIRECTORY ${PROJECT_TOP}/modules
    DESTINATION ${INSTALL_PARENT}
    FILE_PERMISSIONS OWNER_WRITE OWNER_READ GROUP_READ WORLD_READ
    FILES_MATCHING PATTERN "*.py"
)

set(CPACK_DEBIAN_PACKAGE_CONTROL_EXTRA
    "${CMAKE_SOURCE_DIR}/postinst"
    "${CMAKE_SOURCE_DIR}/postrm"
)

# Packaging (make package, make package_source)
set(CPACK_GENERATOR "DEB")

set(CPACK_DEBIAN_PACKAGE_MAINTAINER "Petr Vavrin (peterbay)") #required

set(CPACK_PACKAGE_VERSION ${PROJECT_VERSION})
set(CPACK_PACKAGE_VERSION_MAJOR ${PROJECT_VERSION_MAJOR})
set(CPACK_PACKAGE_VERSION_MINOR ${PROJECT_VERSION_MINOR})
set(CPACK_PACKAGE_VERSION_PATCH ${PROJECT_VERSION_PATCH})

set(CPACK_DEBIAN_FILE_NAME "${PROJECT_NAME}-${PROJECT_VERSION}.deb")

include(CPack)
