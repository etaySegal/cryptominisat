# - Try to find libm4ri
find_package(PkgConfig)
pkg_check_modules(PC_M4RI QUIET libm4ri)
set(M4RI_DEFINITIONS ${PC_M4RI_CFLAGS_OTHER})

MACRO(DBG_MSG _MSG)
    MESSAGE(STATUS "${CMAKE_CURRENT_LIST_FILE}(${CMAKE_CURRENT_LIST_LINE}):\n${_MSG}")
ENDMACRO(DBG_MSG)

SET (M4RI_POSSIBLE_ROOT_DIRS
  "${M4RI_ROOT_DIR}"
  "$ENV{M4RI_ROOT_DIR}"
  "$ENV{M4RI_DIR}" 
  "$ENV{M4RI_HOME}"
  /usr/local
  /usr
  )

FIND_PATH(M4RI_ROOT_DIR
  NAMES
  include/m4ri.h     # windows
  include/m4ri/m4ri.h # linux /opt/net
  PATHS ${M4RI_POSSIBLE_ROOT_DIRS}
)
DBG_MSG("M4RI_ROOT_DIR=${M4RI_ROOT_DIR}")

SET(M4RI_INCDIR_SUFFIXES
  include
  include/m4ri
  m4ri/include
  m4ri
)
DBG_MSG("M4RI_INCDIR_SUFFIXES=${M4RI_INCDIR_SUFFIXES}")

FIND_PATH(M4RI_INCLUDE_DIRS
  NAMES m4ri.h
  PATHS ${M4RI_ROOT_DIR}
  PATH_SUFFIXES ${M4RI_INCDIR_SUFFIXES}
  NO_CMAKE_SYSTEM_PATH
)
DBG_MSG("M4RI_INCLUDE_DIRS=${M4RI_INCLUDE_DIRS}")

SET(M4RI_LIBDIR_SUFFIXES
  lib
  lib/m4ri
  m4ri/lib
)
DBG_MSG("M4RI_LIBDIR_SUFFIXES=${M4RI_LIBDIR_SUFFIXES}")


find_library(M4RI_LIBRARIES
    NAMES m4ri libm4ri
    PATHS ${M4RI_ROOT_DIR}
    PATH_SUFFIXES ${M4RI_LIBDIR_SUFFIXES}
)
DBG_MSG("M4RI_LIBRARIES=${M4RI_LIBRARIES}")

include(FindPackageHandleStandardArgs)
# handle the QUIETLY and REQUIRED arguments and set M4RI_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(m4ri  DEFAULT_MSG
                                  M4RI_LIBRARIES M4RI_INCLUDE_DIRS)

mark_as_advanced(M4RI_INCLUDE_DIRS M4RI_LIBRARIES )
