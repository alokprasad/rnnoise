cmake_minimum_required(VERSION 2.4.0)
#create build directory and do cmake .. && make to build .so and and demo app

# Find source files
set(SOURCES
    src/denoise.c
    src/rnn.c
    src/rnn_data.c
    src/pitch.c
    src/kiss_fft.c
    src/celt_lpc.c
    )


set(NOINSTALL_INCLUDE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/src)
set(INCLUDE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/include)

# Create shared library( build/librnnoise.so)
add_library(rnnoise SHARED ${SOURCES})

# Include header files
target_include_directories(rnnoise PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/src
    ${CMAKE_CURRENT_SOURCE_DIR}/include
    )

#create demo file build/rnnoise_demo
add_executable(rnnoise_demo
    examples/rnnoise_demo.c
)


target_include_directories(rnnoise_demo PRIVATE
  ${CMAKE_CURRENT_SOURCE_DIR}/include
 )

target_link_libraries(rnnoise_demo
    rnnoise m
)
