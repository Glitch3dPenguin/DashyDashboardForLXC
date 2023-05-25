# [Dashy Dashboard](https://github.com/Lissy93/dashy) LXC Installer Scripts

- Install Dashy automatically
- Removes the need to use Docker
- Builds directly from source
- Uses the same resources as Docker (Alpine)

### Container Requirements:
- LXC Container (Script Does NOT support Proxmox VMs yet)
- 4096mb of memory needed for build -> deflate to 512mb after script
- 2 virtual cores needed for build -> deflate to 1 after script

# Install On Alpine (recommended)

### Tested Alpine LXC Templates:
|    LXC Template     | Support |
| ------------------- | ------- |
| alpine-3.14-default | ❌     |
| alpine-3.15-default | ✅     |
| alpine-3.16-default | ✅     |
| alpine-3.17-default | ❌     |


### Oneliner:

```
wget https://raw.githubusercontent.com/Glitch3dPenguin/DashyOneLinerForUbuntu/main/Alpine%20Scripts/install-dashy-alpine3.16.sh && chmod +x install-dashy-alpine3.16.sh && ./install-dashy-alpine3.16.sh
```

The Alpine installer is highly recommended due to the incredibly low resource usage. After install you can expect to see this container use less than 75-100MB of memory. This is the same you would expect to use if you ran Dashy in docker. 

# Install on Ubuntu

### Tested Ubuntu LXC Templates:

|                   LXC Template              | Support |
| ------------------------------------------- | ------- |
| ubuntu-18.04-standard_18.04.1-1_amd64       | ✅     |
| ubuntu-22.04-standard_22.04-1_amd64 (Focal) | ✅     |
| ubuntu-22.04-standard_22.04-1_amd64 (Jammy) | ✅     |
| ubuntu-22.10-standard_22.10-1_amd64         | ❌     |

### Oneliner:

```
wget https://raw.githubusercontent.com/Glitch3dPenguin/DashyOneLinerForUbuntu/main/Ubuntu%20Scripts/install-dashy-ubuntu18.04-22.04.sh && chmod +x install-dashy-ubuntu18.04-22.04.sh && ./install-dashy-ubuntu18.04-22.04.sh
```

Ubuntu LXC containers are supported with the Ubuntu version of the script, HOWEVER you can expect to see much higher system usage due to Ubuntu overhead. (300MB+)