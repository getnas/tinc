# Tinc for Docker

### 创建容器

```
sudo docker run -d --privileged \
    -p 655:655/tcp \
    -p 655:655/udp \
    -e NETNAME=p2pvpn \
    -e HOSTNAME=docker \
    -e SUBNET=10.10.0.1/32 \
    -e IP=10.10.0.1 \
    -v ~/tinc/:/etc/tinc \
    --restart=always \
    alpine
```

### 环境变量

* NETNAME - VPN 网络名
* HOSTNAME - 本机设备名
* SUBNET - VPN 子网地址
* IP - IP 地址