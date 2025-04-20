#include "rclcpp/rclcpp.hpp"
#include "lib.h"

class TemplateNode : public rclcpp::Node {
public:
    TemplateNode(): Node("template_node") {
        // Initialize the node
        RCLCPP_INFO(this->get_logger(), "Template node initialized");
        RCLCPP_INFO(this->get_logger(), "3 + 5 = %d", cpp_template::add(3, 5));
    }
};

int main(int argc, char* argv[]) {
    rclcpp::init(argc, argv);
    rclcpp::spin(std::make_shared<TemplateNode>());
    rclcpp::shutdown();

    return 0;
}