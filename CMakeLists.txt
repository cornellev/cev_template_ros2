cmake_minimum_required(VERSION 3.15)
project(cev_template_ros2 LANGUAGES CXX)

# Set the C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Find dependencies
find_package(ament_cmake REQUIRED)
find_package(rclcpp REQUIRED)

# Add subdirectory for the library
add_subdirectory(cev_template_lib EXCLUDE_FROM_ALL)

# Source files in the main src folder
set(SOURCES
  src/template.cpp
)

# Declare the executable
add_executable(ros_template ${SOURCES})
target_link_libraries(ros_template CEV::Template)

# Link libraries
ament_target_dependencies(ros_template
  rclcpp
)

# Install targets
install(TARGETS ros_template
  DESTINATION lib/${PROJECT_NAME})

# Install additional resources
install(DIRECTORY launch config
  DESTINATION share/${PROJECT_NAME})

# Ament package configuration
ament_package()