# Tinc for Docker

本容器用于构建 Tinc Server 端

### 环境变量

以下为该容器预置环境变量及默认值值，请按需使用。

* `NETNAME` - VPN 网络名，默认值：`p2pvpn`
* `HOSTNAME` - 本机设备名，默认值：`vultr`
* `SUBNET` - VPN 子网地址，默认值：`10.10.0.1/32`
* `IP` - IP 地址，默认值：`10.10.0.1`
* `PUBLIC_IP` - 主机公网 IP 地址或域名

## 使用方法

### 第一步 生成主机配置文件

生成配置文件的重点在于指定环境变量，请根据你实际配置需要设置相应的环境变量和值，如不设置则配置文件使用环境变量的默认值创建。

```
sudo docker run --rm \
    -v ~/tinc/:/etc/tinc \
    -e NETNAME=p2pvpn \
    -e HOSTNAME=server \
    -e SUBNET=192.168.100.1/32 \
    -e IP=192.168.100.1 \
    -e PUBLIC_IP=your_domain.com \
    getnas/tinc:latest /bin/sh /init.sh
```

执行完毕后，容器会自动退出并销毁。生成的配置文件在命令中映射的本地路径 `~/tinc`。

### 第二步 创建 Tinc 服务容器

创建 Tinc 服务容器，并将第一步生成的配置文件目录映射到容器中。

```
sudo docker run -d --privileged \
    -p 655:655/tcp \
    -p 655:655/udp \
    -v ~/tinc/:/etc/tinc \
    --restart=always \
    --name tinc getnas/tinc
```