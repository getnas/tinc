import os

print("""Tinc 客户端配置生成器 v1.0 Beta - GetNAS.com
##########################################
# 注意！本程序出于开发状态，请谨慎使用！ #
##########################################
开始前，请先安装 Tinc 和 net-tools。
接下来，程序会交互式的向你提出问题，请按需提供相应的值。
————————————""")

# TODO: 修正所有变量的默认值

print("网络名（默认：p2pvpn）：")
netname = input() or "p2pvpn"

print("主机名：")
hostname = input() or "client"

print("子网（默认：10.10.0.1/32）:")
subnet = input() or "10.10.0.1/32"

print("IP 地址：")
ip = input() or "10.10.0.6"

print("要连接的服务器：")
connect_to = input() or "vultr"

print("""程序将采用以下信息为你配置 Tinc 客户端
网络名：%s
主机名：%s
子网：%s
IP 地址：%s
要连接的服务器：%s
--------""" % (netname, hostname, subnet, ip, connect_to))

# TODO: 确认交互

print("创建配置目录 %s..." % netname)
os.system("mkdir -p /etc/tinc/%s/hosts" % netname)

print("创建配置文件 tinc.conf...")
os.system("touch /etc/tinc/%s/tinc.conf" % netname)
os.system("echo 'Name = %s' > /etc/tinc/%s/tinc.conf" % (hostname, netname))
os.system("echo 'Device = /dev/net/tun' >> /etc/tinc/%s/tinc.conf" % netname)
os.system("echo 'ConnectTo = %s' >> /etc/tinc/%s/tinc.conf" % (connect_to, netname))

print("创建主机文件 %s..." % hostname)
os.system("touch /etc/tinc/%s/hosts/%s" % (netname, hostname))
os.system("echo 'Subnet = %s' > /etc/tinc/%s/hosts/%s" % (subnet, netname, hostname))

# TODO: 解决 ifconfig 被新版本系统弃用的问题

print("创建网络配置文件...")
os.system("touch /etc/tinc/%s/tinc-up" % netname)
os.system("echo '#!/bin/sh' > /etc/tinc/%s/tinc-up" % netname)
os.system("echo 'ifconfig $INTERFACE %s netmask 255.255.255.0' >> /etc/tinc/%s/tinc-up" % (ip, netname))
os.system("touch /etc/tinc/%s/tinc-down" % netname)
os.system("echo '#!/bin/sh' > /etc/tinc/%s/tinc-down" % netname)
os.system("echo 'ifconfig $INTERFACE down' >> /etc/tinc/%s/tinc-down" % netname)

print("赋予网络脚本可执行权限...")
os.system("chmod -v +x /etc/tinc/%s/tinc-{up,down}" % netname)

print("生成密钥...")
os.system("echo | /usr/sbin/tincd -n %s -K4096" % netname)

print("创建完成，配置文件位于：/etc/tinc/%s" % netname)
