# FindImGui.cmake
#
# Finds ImGui library
#
# This will define the following variables
# IMGUI_FOUND
# IMGUI_INCLUDE_DIRS
# IMGUI_SOURCES
# IMGUI_DEMO_SOURCES
# IMGUI_VERSION

list(APPEND IMGUI_SEARCH_PATH
  ${IMGUI_DIR}
)

find_path(IMGUI_INCLUDE_DIR
  NAMES imgui.h
  PATHS ${IMGUI_SEARCH_PATH}
  NO_DEFAULT_PATH
)

if(NOT IMGUI_INCLUDE_DIR)
  message(FATAL_ERROR "IMGUI imgui.cpp not found. Set IMGUI_DIR to imgui's top-level path (containing \"imgui.cpp\" and \"imgui.h\" files).\n")
endif()

set(IMGUI_PUBLIC_HEADERS
  ${IMGUI_INCLUDE_DIR}/imconfig.h
  ${IMGUI_INCLUDE_DIR}/imgui.h
  ${IMGUI_INCLUDE_DIR}/imgui_internal.h
  ${IMGUI_INCLUDE_DIR}/imstb_rectpack.h
  ${IMGUI_INCLUDE_DIR}/imstb_textedit.h
  ${IMGUI_INCLUDE_DIR}/imstb_truetype.h
  ${IMGUI_INCLUDE_DIR}/misc/cpp/imgui_stdlib.h
  ${IMGUI_INCLUDE_DIR}/backends/imgui_impl_win32.h
  ${IMGUI_INCLUDE_DIR}/backends/imgui_impl_dx12.h
)

if(IMGUI_DEMO)
  set(IMGUI_DEMO_SOURCES
    ${IMGUI_INCLUDE_DIR}/imgui_demo.cpp
  )
endif()

set(IMGUI_SOURCES
  ${IMGUI_INCLUDE_DIR}/imgui.cpp
  ${IMGUI_INCLUDE_DIR}/imgui_draw.cpp
  ${IMGUI_INCLUDE_DIR}/imgui_tables.cpp
  ${IMGUI_INCLUDE_DIR}/imgui_widgets.cpp
  ${IMGUI_INCLUDE_DIR}/misc/cpp/imgui_stdlib.cpp
  ${IMGUI_INCLUDE_DIR}/backends/imgui_impl_win32.cpp
  ${IMGUI_INCLUDE_DIR}/backends/imgui_impl_dx12.cpp
  ${IMGUI_DEMO_SOURCES}
)



# Extract version from header
file(
  STRINGS
  ${IMGUI_INCLUDE_DIR}/imgui.h
  IMGUI_VERSION
  REGEX "#define IMGUI_VERSION "
)

if(NOT IMGUI_VERSION)
  message(SEND_ERROR "Can't find version number in ${IMGUI_INCLUDE_DIR}/imgui.h.")
endif()
# Transform '#define IMGUI_VERSION "X.Y"' into 'X.Y'
string(REGEX REPLACE ".*\"(.*)\".*" "\\1" IMGUI_VERSION "${IMGUI_VERSION}")

# Check required version
if(${IMGUI_VERSION} VERSION_LESS ${ImGui_FIND_VERSION})
  set(IMGUI_FOUND FALSE)
  message(FATAL_ERROR "ImGui at with at least v${ImGui_FIND_VERSION} was requested, but only v${IMGUI_VERSION} was found")
else()
  set(IMGUI_FOUND TRUE)
  message(STATUS "Found ImGui v${IMGUI_VERSION} in ${IMGUI_INCLUDE_DIR}")
endif()

add_library(ImGui
  ${IMGUI_SOURCES}
  ${IMGUI_PUBLIC_HEADERS}
)
target_include_directories(ImGui PUBLIC ${IMGUI_INCLUDE_DIR})
