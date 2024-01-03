#!/bin/bash

# Function to check OS and set package name accordingly

check_os() {
    os=$(uname -s)
    case $os in
        Linux*)
            if [ -f /etc/os-release ]
            then
                source /etc/os-release
                if [[ $ID == "ubuntu" || $ID == "debian" ]]; then
                    package_name="httpd"
                    echo "OS in the machine is $ID and package to install is $package_name"
                elif [[ $ID == "centos" || $ID == "rhel" ]]; then
                    package_name="apache2"
                    echo "OS in the machine is $ID and package to install is $package_name"
                else
                    echo "Unsupported Linux distribution!"
                    exit 1
                fi
            else
                echo "Unable to determine the operating system!"
                exit 1
            fi
            ;;
        *)
            echo "Unsupported operating system!"
            exit 1
            ;;
    esac
}

# Function to install httpd (apache2) or nginx based on user choice

install_server() {
   
    echo "Select which web server to install:"
    echo "1. httpd / apache2"
    echo "2. nginx"

    read -rp "Enter your choice: " choice
 	check_os
    case $choice in
        1)
            if command -v "$package_name" &>/dev/null
            then
                echo "$package_name is already installed."
            else
                if [[ $package_name == "httpd" ]]
                 then
                    if [[ $ID == "ubuntu" || $ID == "debian" ]]
                     then
                        sudo apt update && sudo apt install -y apache2
                    elif [[ $ID == "centos" || $ID == "rhel" ]]
                     then
                        sudo yum install -y httpd
                    else
                        echo "Unsupported Linux distribution!"
                        exit 1
                    fi
                else
                    echo "Unsupported package!"
                    exit 1
                fi
                echo "$package_name installed successfully!"
            fi
            ;;
        2)
            if command -v nginx &>/dev/null
             then
                echo "nginx is already installed."
            else
                if [[ $ID == "ubuntu" || $ID == "debian" ]]
                 then
                    sudo apt update && sudo apt install -y nginx
                elif [[ $ID == "centos" || $ID == "rhel" ]]
                 then
                    sudo yum install -y nginx
                else
                    echo "Unsupported Linux distribution!"
                    exit 1
                fi
                echo "nginx installed successfully!"
            fi
            ;;
        *)
            echo "Invalid choice. Please select 1 or 2."
            ;;
    esac
}

# Execute the installation process
install_server

