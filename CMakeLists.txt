cmake_minimum_required(VERSION 3.12)

project(imgui-dx12-latency-test
  LANGUAGES CXX
)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

include(FetchContent)

set(IMGUI_VERSION 1.89.3)
FetchContent_Declare(
  imgui
  URL "https://github.com/ocornut/imgui/archive/v${IMGUI_VERSION}.zip"
)

option(IMGUI_DEMO "Build imgui_demo.cpp" ON)

FetchContent_MakeAvailable(imgui)
set(IMGUI_DIR "${FETCHCONTENT_BASE_DIR}/imgui-src" CACHE PATH "imgui top-level directory")

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake")
find_package(ImGui ${IMGUI_VERSION} REQUIRED)

add_executable(${PROJECT_NAME}
  main.cpp
)

target_link_libraries(${PROJECT_NAME} ImGui D3D12.lib DXGI.lib)

