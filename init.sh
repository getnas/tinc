#!/bin/sh
# ${NETNAME} - VPN 网络名
# ${HOSTNAME} - 本机设备名
# ${SUBNET} - VPN 子网地址
# ${IP} - IP 地址
# ${PUBLIC_IP} - 主机公网 IP 地址

if [ ! -d /etc/tinc/${NETNAME} ]; then
    mkdir -p /etc/tinc/${NETNAME}/hosts

    # 创建配置文件
    touch /etc/tinc/${NETNAME}/tinc.conf
    echo "Name = ${HOSTNAME}" > /etc/tinc/${NETNAME}/tinc.conf
    echo "Device = /dev/net/tun" >> /etc/tinc/${NETNAME}/tinc.conf

    # 创建主机文件
    touch /etc/tinc/${NETNAME}/hosts/${HOSTNAME}
    echo "Address = ${PUBLIC_IP}" > /etc/tinc/${NETNAME}/hosts/${HOSTNAME}
    echo "Subnet = ${SUBNET}" >> /etc/tinc/${NETNAME}/hosts/${HOSTNAME}

    # 创建 tinc-up
    touch /etc/tinc/${NETNAME}/tinc-up
    echo "#!/bin/sh" > /etc/tinc/${NETNAME}/tinc-up
    echo "ifconfig \$INTERFACE ${IP} netmask 255.255.255.0" >> /etc/tinc/${NETNAME}/tinc-up

    # 创建 tinc-down
    touch /etc/tinc/${NETNAME}/tinc-down
    echo "#!/bin/sh" > /etc/tinc/${NETNAME}/tinc-down
    echo "ifconfig \$INTERFACE down"  >> /etc/tinc/${NETNAME}/tinc-down

    # 赋予脚本执行权
    chmod -v +x /etc/tinc/${NETNAME}/tinc-{up,down}

    # 生成密钥
    echo | /usr/sbin/tincd -n ${NETNAME} -K4096
else
    # 运行程序
    /usr/sbin/tincd -n ${NETNAME} --logfile=tinc.log -U root -D
fi