# tor_cockpit
This script automatically installs and configures remote access via tor for Ubuntu.
# How to install
    sudo su
    apt-get update
    apt-get install git
    git clone https://github.com/brwderp/tor_cockpit.git
    cd tor_cockpit
    chmod +x tor_cockpit.sh
    ./tor_cockpit.sh
# Starting (after reboot, you need to enter each time)
    sudo systemctl start cockpit.socket
    sudo su - (username)
    tor
# To get url:
    sudo cat /home/(username)/hidden_service/hostname # In the browser add :9090 to the end of the URL.
