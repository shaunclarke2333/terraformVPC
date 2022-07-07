#!/bin/bash
sudo apt update -y
sudo apt-get install apache2 -y
sudo service apache2 start
cd /var/www/html
echo "<html><body><h1>Welcome to Shaun's webserver</h1></body></html>" > index.html
