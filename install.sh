#!/bin/bash

# Check if Nginx is installed
if [ -x "$(command -v nginx)" ]; then
    echo "✔️ Nginx is already installed."
else
    echo "❌ Nginx is not installed. Installing..."
    
    # Update package lists
    apt update
    
    # Install Nginx
    apt install nginx -y
    
    # Verify installation
    if [ -x "$(command -v nginx)" ]; then
        echo "✔️ Nginx installed successfully."
    else
        echo "❌ Failed to install Nginx."
        exit 1
    fi
fi

# Check if Git is installed
if [ -x "$(command -v git)" ]; then
    echo "✔️ Git is already installed."
else
    echo "❌ Git is not installed. Installing..."
    
    # Install Git
    apt install git -y
    
    # Verify installation
    if [ -x "$(command -v git)" ]; then
        echo "✔️ Git installed successfully."
    else
        echo "❌ Failed to install Git."
        exit 1
    fi
fi

# Check if UFW is installed
if [ -x "$(command -v ufw)" ]; then
    echo "✔️ UFW is already installed."
else
    echo "❌ UFW is not installed. Installing..."
    
    # Install UFW
    apt install ufw -y
    
    # Verify installation
    if [ -x "$(command -v ufw)" ]; then
        echo "✔️ UFW installed successfully."
    else
        echo "❌ Failed to install UFW."
        exit 1
    fi
fi


# Check if Node.js is installed
if [ -x "$(command -v node)" ]; then
    echo "✔️ Node.js is already installed."
else
    echo "❌ Node.js is not installed. Installing..."
    
    # Install Node.js
    apt install nodejs -y
    
    # Verify installation
    if [ -x "$(command -v node)" ]; then
        echo "✔️ Node.js installed successfully."
    else
        echo "❌ Failed to install Node.js."
        exit 1
    fi
fi

# Check if npm is installed
if [ -x "$(command -v npm)" ]; then
    echo "✔️ npm is already installed."
else
    echo "❌ npm is not installed. Installing..."
    
    # Install npm
    apt install npm -y
    
    # Verify installation
    if [ -x "$(command -v npm)" ]; then
        echo "✔️ npm installed successfully."
    else
        echo "❌ Failed to install npm."
        exit 1
    fi
fi


# checking for yarn 

if [ -x "$(command -v yarn)" ]; then
     echo "✔️ yarn is already installed."
else
     # Install yarn
    npm i -g yarn

     # Verify installation
     if [ -x "$(command -v yarn)" ]; then
         echo "✔️ yarn installed successfully."
    else
        echo "❌ Failed to install yarn."
        exit 1
    fi
fi


# Allow ports 22, 80, and 443 through UFW
ufw allow 22
ufw allow 80
ufw allow 443

echo "Ports 22, 80, and 443 allowed through UFW."

echo "Installing node packages...."

if [ -x "$(command -v yarn)" ]; then
    yarn install
    if [ $? -ne 0 ]; then
        echo "❌ Failed to install packages with Yarn."
        exit 1
    else
        echo "✔️ Packages installed successfully with Yarn."
    fi
else
    npm install
    if [ $? -ne 0 ]; then
        echo "❌ Failed to install packages with npm."
        exit 1
    else
        echo "✔️ Packages installed successfully with npm."
    fi
fi


echo "Building project...."
npm run build
if [ $? -ne 0 ]; then
    echo "❌ Failed to build project."
    exit 1
else
    echo "✔️ Project built successfully."
fi

echo "Starting project...."
npm run start
if [ $? -ne 0 ]; then
    echo "❌ Failed to start project."
    exit 1
else
    echo "✔️ Project started successfully."
fi