# Dashy Ubuntu Installer Script

- Install dashy without being a Ubuntu expert
- Does all the heavy lifting on its own
- Builds Dashy for you

### Requirements:
- Proxmox LXC Container (Script Does NOT support Proxmox VM yet)
- 4096mb of memory allocated (deflate to 1024mb after script)
- 2 virtual cores (deflate to 1 after script) 

# Install On Alpine

### Tested Alpine LXC Templates:
|                   LXC Template              |    Support   |
| ------------------------------------------- | ------------ |
| ubuntu-18.04-standard_18.04.1-1_amd64       | Working      |
| ubuntu-22.04-standard_22.04-1_amd64 (Focal) | Working      |
| ubuntu-22.04-standard_22.04-1_amd64 (Jammy) | Working      |
| ubuntu-22.10-standard_22.10-1_amd64         | Broken       |

### Oneliner:

```
wget https://raw.githubusercontent.com/Glitch3dPenguin/DashyOneLinerForUbuntu/main/Alpine%20Scripts/install-dashy-alpine3.16.sh && chmod +x install-dashy.sh && sudo bash install-dashy.sh
```


# Install on Ubuntu

### Tested Ubuntu LXC Templates:

|                   LXC Template              |    Support   |
| ------------------------------------------- | ------------ |
| ubuntu-18.04-standard_18.04.1-1_amd64       | Working      |
| ubuntu-22.04-standard_22.04-1_amd64 (Focal) | Working      |
| ubuntu-22.04-standard_22.04-1_amd64 (Jammy) | Working      |
| ubuntu-22.10-standard_22.10-1_amd64         | Broken       |

### Oneliner:

```
wget https://raw.githubusercontent.com/Glitch3dPenguin/DashyOneLinerForUbuntu/main/Ubuntu%20Scripts/install-dashy-ubuntu18.04-22.04.sh && chmod +x install-dashy.sh && sudo bash install-dashy.sh
```

### How to use:
- **Step 1:**
Download the script to your home folder:

```
wget https://raw.githubusercontent.com/Glitch3dPenguin/DashyOneLinerForUbuntu/main/install-dashy.sh`
```

- **Step 2:**
Allow the script to be executed:

```
chmod +x install-dashy.sh`
```

- **Step 3:**
Run the installer script:

```
sudo bash install-dashy.sh
```

- **Step 4:**
Take note of the ip and port to access your new Dashy interface and restart your machine:

```
reboot
```
