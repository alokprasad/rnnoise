cmake_minimum_required(VERSION 2.4.0)
#create build directory and do cmake .. && make to build .so and and demo app
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Find source files
set(SOURCES 
	src/denoise.c 
    src/rnn.c
    src/rnn_data.c 
    src/pitch.c 
    src/kiss_fft.c 
    src/celt_lpc.c
    )

if (TARGET_PLATFORM STREQUAL "android")
    list(APPEND SOURCES src/rnnoise_interface_wrap.cpp)
endif()


set(INCLUDES
    ${CMAKE_CURRENT_SOURCE_DIR}/src
    ${CMAKE_CURRENT_SOURCE_DIR}/include
)

if (TARGET_PLATFORM STREQUAL "linux") 
    list(APPEND INCLUDES /usr/lib/jvm/java-1.8.0-openjdk-amd64/include/)
    list(APPEND INCLUDES /usr/lib/jvm/java-8-openjdk-amd64/include/linux/)
endif()

#set_property(SOURCE src/denoise.c  
#               APPEND_STRING PROPERTY COMPILE_FLAGS "-O3")

#set_property(SOURCE src/rnn.c
#               APPEND_STRING PROPERTY COMPILE_FLAGS "-O3")

#set_property(SOURCE src/kiss_fft.c
#               APPEND_STRING PROPERTY COMPILE_FLAGS "-O3")


#set_property(SOURCE src/rnn_data.c
#               APPEND_STRING PROPERTY COMPILE_FLAGS "-O3")

#set_property(SOURCE src/pitch.c
#               APPEND_STRING PROPERTY COMPILE_FLAGS "-O3")

#set_property(SOURCE src/celt_lpc.c
#               APPEND_STRING PROPERTY COMPILE_FLAGS "-O3")

set_source_files_properties(${SOURCES} 
	PROPERTIES COMPILE_FLAGS "-O3")

#set(NOINSTALL_INCLUDE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/src)
#set(INCLUDE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/include)

# Create shared library( build/librnnoise.so)
add_library(rnnoise SHARED ${SOURCES})

# Include header files
target_include_directories(rnnoise PRIVATE 
    ${INCLUDES}
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
