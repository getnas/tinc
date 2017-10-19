#!/bin/sh
# ${NETNAME} - VPN 网络名
# ${HOSTNAME} - 本机设备名
# ${SUBNET} - VPN 子网地址
# ${IP} - IP 地址

mkdir -p /etc/tinc/${NETNAME}/hosts

# 创建配置文件
touch /etc/tinc/${NETNAME}/tinc.conf
echo "Name = ${HOSTNAME}" >> /etc/tinc/${NETNAME}/tinc.conf
echo "Device = /dev/net/tun" >> /etc/tinc/${NETNAME}/tinc.conf

# 创建主机文件
touch /etc/tinc/${NETNAME}/hosts/${HOSTNAME}
echo "Subnet = ${SUBNET}" >> /etc/tinc/${NETNAME}/hosts/${HOSTNAME}

# 创建 tinc-up
touch /etc/tinc/${NETNAME}/tinc-up
echo "#!/bin/sh" >> /etc/tinc/${NETNAME}/tinc-up
echo "ifconfig \$INTERFACE ${IP} netmask 255.255.255.0 " >> /etc/tinc/${NETNAME}/tinc-up

# 创建 tinc-down
touch /etc/tinc/${NETNAME}/tinc-down
echo "#!/bin/sh" >> /etc/tinc/${NETNAME}/tinc-down
echo "ifconfig \$INTERFACE down"  >> /etc/tinc/${NETNAME}/tinc-down

# 赋予脚本执行权
chmod +x /etc/tinc/${NETNAME}/tinc-up
chmod +x /etc/tinc/${NETNAME}/tinc-down

# 生成密钥
echo | /usr/sbin/tincd -n ${NETNAME} -K4096

# 运行程序
/usr/sbin/tincd -n ${NETNAME}