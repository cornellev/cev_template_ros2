cmake_minimum_required(VERSION 3.10)
project(cev_template_ros2 LANGUAGES CXX)

# Set the C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Find dependencies
find_package(ament_cmake REQUIRED)
find_package(rclcpp REQUIRED)

# CEV
find_package(cev_msgs REQUIRED)

# Add subdirectory for the library
add_subdirectory(cev_template_lib)

# Source files in the main src folder
set(SOURCES
    src/template.cpp
)

# Declare the executable
add_executable(template ${SOURCES})
target_link_libraries(template cev_template_lib)

# Link libraries
ament_target_dependencies(template
    rclcpp
    cev_msgs
)

# Install targets
install(TARGETS template
    DESTINATION lib/${PROJECT_NAME})

# Install additional resources
install(DIRECTORY launch config
    DESTINATION share/${PROJECT_NAME})

# Ament package configuration
ament_package()