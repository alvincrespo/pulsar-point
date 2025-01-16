#!/bin/bash

# Check if script is run with sudo
if [ "$EUID" -ne 0 ]; then
  echo "Please run with sudo"
  exit 1
fi

# Add domain to /etc/hosts if not already present
if ! grep -q "myreactapp" /etc/hosts; then
  echo "127.0.0.1 myreactapp" >> /etc/hosts
  echo "Added myreactapp to /etc/hosts"
else
  echo "myreactapp already in /etc/hosts"
fi

# Flush DNS cache
dscacheutil -flushcache
killall -HUP mDNSResponder
echo "Flushed DNS cache"

echo "Setup complete! You can now access your app at http://myreactapp"
