#!/bin/bash

echo "Disk Usage Command"
df -h

echo "Memory Usage Command"
free -h

echo "Nginx Status Command"
systemctl status nginx 

echo "Port Check 5001"
lsof -i :5001
