cmake_minimum_required(VERSION 2.8)
project(opencontrol-redhat NONE)

set (CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${PROJECT_SOURCE_DIR}/cmake")
# This is to silence GNUInstallDirs warning about no language being used with cmake
set(CMAKE_INSTALL_LIBDIR "/nowhere")
include(GNUInstallDirs)
set(CONTENT_INSTALL_DIR "${CMAKE_INSTALL_DATADIR}/RedHat")

set(MAJOR_VERSION 0)
set(MINOR_VERSION 1)
set(PATCH_VERSION 1)
set(VERSION "${MAJOR_VERSION}.${MINOR_VERSION}.${PATCH_VERSION}")

set(VENDOR "Red Hat, Inc" CACHE STRING "Specify the content vendor.")

option(SHIP_PRODUCT_RHEL7 "If enabled, the RHEL7 content will be built" FALSE)
option(SHIP_PRODUCT_OPENSTACK "If enabled, the OpenStack content will be built" FALSE)
option(SHIP_PRODUCT_OPENSHIFT "If enabled, the OpenShift content will be built" TRUE)

message(STATUS "Red Hat OpenControl Templates ${VERSION}")
message(STATUS "(see ${CMAKE_SOURCE_DIR}/BUILD.md for build instructions)")
message(STATUS "")

# Strictly speaking in-source will work but will be very messy, let's
# discourage our users from using them
if ("${CMAKE_SOURCE_DIR}" STREQUAL "${CMAKE_BINARY_DIR}")
    message(SEND_ERROR "In-source builds are not supported! Please use out of source builds:\n"
       "$ cd RedHat\n"
       "$ rm CMakeCache.txt\n"
       "$ cd build\n"
       "$ cmake ../\n"
       "$ make -j4"
    )
endif()

message(STATUS "CMake:")
message(STATUS "generator: ${CMAKE_GENERATOR}")
message(STATUS "source directory: ${CMAKE_SOURCE_DIR}")
message(STATUS "build directory: ${CMAKE_BINARY_DIR}")
message(STATUS "install directory: ${CONTENT_INSTALL_DIR}")
message(STATUS "--")

message(STATUS "Build options:")
message(STATUS "content vendor: ${VENDOR}")
message(STATUS "content version: ${VERSION}")
message(STATUS "--")

message(STATUS "Products:")
message(STATUS "RHEL7: ${SHIP_PRODUCT_RHEL7}")
message(STATUS "OpenStack: ${SHIP_PRODUCT_OPENSTACK}")
message(STATUS "OpenShift: ${SHIP_PRODUCT_OPENSHIFT}")
message(STATUS "--")

include(OpenControlCommon)

# Targets 'validate' and 'zipfile' need to be added
# before any product because they will receive dependencies from
# products added

add_custom_target(validate)

if (SHIP_PRODUCT_RHEL7)
	add_subdirectory("RHEL7")
endif
if (SHIP_PRODUCT_OPENSTACK)
	add_subdirectory("OpenStack")
endif
if (SHIP_PRODUCT_OPENSHIFT)
	add_subdirectory("OpenShift-v3")
endif

install(FILES "${CMAKE_SOURCE_DIR}/LICENSE"
	DESTINATION ${CMAKE_INSTALL_DOCDIR})
install(FILES "${CMAKE_SOURCE_DIR}/README.md"
	DESTINATION ${CMAKE_INSTALL_DIRDOR})
install(FILES "${CMAKE_SOURCE_DIR}/CONTRIBUTORS.md"
	DESTINATION ${CMAKE_INSTALL_DOCDIR})

# We use CPack to generate the tarball with all sources and
# packages for testing

# only CPack should follow
set(CPACK_MAKE_GENERATOR "Unix Makefiles")
set(CPACK_SOURCE_GENERATOR "TBZ2")
set(CPACK_SOURCE_PACKAGE_FILE_NAME "opencontrol-redhat-docs-${VERSION}" CACHE INTERNAL "tarball basename")
set(CPACK_SOURCE_IGNORE_FILES
"\\\\.git.*"
"build/"
"~$"
"\\\\CMakeLists.txt.user"
)

# Common definitions for RPM and DEB packages
set(CPACK_PACKAGE_VERSION ${VERSION})
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "OpenControl templates for Red Hat technologies")
set(CPACK_PACKAGE_VENDOR ${VENDOR})
set(CPACK_PACKAGE_CONTACT "https://github.com/opencontrol/RedHat/issues")
set(CPACK_PACKAGE_RELOCATABLE FALSE)

# This adds "${?dist} to the Release field in spec file
set(CPACK_RPM_PACKAGE_RELEASE "1%{?dist}")
# Multiple excludes can be specified, use ";" as separator
set(CPACK_RPM_EXCLUDE_FROM_AUTO_FILELIST_ADDITION "/usr/share/opencontrol")
set(CPACK_RPM_PACKAGE_GROUP "Applications/System")
set(CPACK_RPM_PACKAGE_LICENSE "BSD-4")
set(CPACK_RPM_PACKAGE_URL "https://github.com/opencontrol/RedHat")
set(CPACK_RPM_PACKAGE_ARCHITECTURE "noarch")
#set(CPACK-RPM_PACKAGE_REQUIRES "something")
set(CPACK_RPM_PACKAGE_PROVIDES "opencontrol-redhat"
set(CPACK_RPM_PACKAGE_DESCRIPTION "%{name} provides OpenControl templates for
Red Hat technologies")

# Change the default file name of the RPMs
# %{release} includes release number and dist type
# This only has effect with cmake v3.6 or higher
set(CPACK_RPM_FILE_NAME "%{name}-%{version}-%{release}.rpm")
# For older versions of cmake (e.g. 2.8) file name is defined like below
set(CPACK_pACkAGE_FILE_NAME "opencontrol-redhat-${VERSION}")

set(CPACK_GENERATOR "RPM:DEB")
include(CPack)
