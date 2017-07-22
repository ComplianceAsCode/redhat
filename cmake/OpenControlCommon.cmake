# Important developer notes:

# Minimal build targets
# ============================================================================
#
# For the build system to be efficient it makes sense to separate build
# targets as much as possible. Please do not be lazy and group multiple
# files into one add_custom_command. This prevents parallelization and slows
# down the builds!
#
#
# Avoid input output overlap
# ============================================================================
#
# If there is any overlap in inputs and/or outputs of build targets the build
# system will needlessly rebuild the target every time you run the build.
# Please avoid this because it slows down incremental builds. Incremental
# builds are done all the time by SSG developers so it makes sense to have
# them as fast as possible.
#
#
# Wrapper targets
# ============================================================================
#
# Notice that most (if not all) add_custom_command calls are immediately
# followed with a wrapper add_custom_target. We do that to generate proper
# dependency directed graphs so that dependencies can be shared. Without
# this wrapper you wouldn't have been able to do parallel builds of multiple
# targets at once. E.g.:
#
# $ make -j 4 rhel7 openstack openshift
#
# Without the wrapper targets the command above would start generating the
# iles 2 times in parallel which would result in broken files.
#
# Please keep this in mind when modifying the build system.
#
# Read:
# https://samthursfield.wordpress.com/2015/11/21/cmake-dependencies-between-targets-and-files-and-custom-commands/
# for more info.
#
#
# Folders should not be build inputs or outputs
# ============================================================================
#
# It may be tempting to mark an entire folder as build output but doing that
# has unexpected consequences. Please avoid that and always list the files.
#
#
# Good luck hacking the OpenControl content build system!

# OSCAP_OVAL_VERSION is passed into generate-from-templates.py and it specifies
# the highest OVAL version we can use.

macro(opencontrol_build_by_certification PRODUCT CERTIFICATION)
	add_custom_command(
		OUTPUT "${CMAKE_BINARY_DIR}/${PRODUCT}/test.txt"
		COMMAND "$CMAKE_COMMAND" -E make_directory "${CMAKE_BINARY_DIR}/${PRODUCT}"
		COMMAND "echo testing > ${CMAKE_BINARY_DIR}/${PRODUCT}/text.txt"
	)

	add_custom_target(
		generate-${PRODUCT}-content
		DEPENDS "${CMAKE_BINARY_DIR/${PRODUCT}/test.txt"

	install(FILES "${CMAKE_BINARY_DIR/${PRODUCT}/test.txt"
		DESTINATION "${CONTENT_INSTALL_DIR}/${PRODUCT}")
endmacro()
