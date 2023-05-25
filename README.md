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
|    LXC Template     |    Support   |
| ------------------- | ------------ |
| alpine-3.14-default | Untested     |
| alpine-3.15-default | Untested     |
| alpine-3.16-default | Working      |
| alpine-3.17-default | Broken       |


### Oneliner:

```
wget https://raw.githubusercontent.com/Glitch3dPenguin/DashyOneLinerForUbuntu/main/Alpine%20Scripts/install-dashy-alpine3.16.sh && chmod +x install-dashy-alpine3.16.sh && ./install-dashy-alpine3.16.sh
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
wget https://raw.githubusercontent.com/Glitch3dPenguin/DashyOneLinerForUbuntu/main/Ubuntu%20Scripts/install-dashy-ubuntu18.04-22.04.sh && chmod +x install-dashy-ubuntu18.04-22.04.sh && ./install-dashy-ubuntu18.04-22.04.sh
```