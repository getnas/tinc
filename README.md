# Tinc for Docker

本容器用于构建 Tinc Server 端

### 创建容器

```
sudo docker run -d --privileged \
    -p 655:655/tcp \
    -p 655:655/udp \
    -v ~/tinc/:/etc/tinc \
    --restart=always \
    --name tinc getnas/tinc
```

> 注意：重新创建容器时请先清空主机的 `~/tinc` 目录，否则可能导致无法正常连通。

### 环境变量

以下为该容器默认的环境变量和值，请根据需要自行使用。

* `NETNAME` - VPN 网络名，默认值：`p2pvpn`
* `HOSTNAME` - 本机设备名，默认值：`vultr`
* `SUBNET` - VPN 子网地址，默认值：`10.10.0.1/32`
* `IP` - IP 地址，默认值：`10.10.0.1`
* `PUBLIC_IP` - 主机公网 IP 地址或域名

举个例子，比如，你想设置网络名为 `myvpn`，主机名为 `getnas`，则可以使用以下命令创建容器：

```
sudo docker run -d --privileged \
    -p 655:655/tcp \
    -p 655:655/udp \
    -e NETNAME=myvpn \
    -e HOSTNAME=getnas \
    -v ~/tinc/:/etc/tinc \
    --restart=always \
    --name tinc getnas/tinc
```