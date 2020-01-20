# shadowsocks-conf

shadowsocks configurations

## ssh

```
ssh-keygen -t ed25519
```

## Firewall (ufw)

```bash
sudo apt install ufw
```

```bash
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
```

```bash
sudo ufw enable
```

```bash
sudo ufw allow proto tcp from any to any port 443
sudo ufw allow out proto tcp from any to any port 443
sudo ufw allow proto udp from any to any port 443
sudo ufw allow out proto udp from any to any port 443
```

```bash
sudo ufw status verbose
```

## fail2ban

```bash
sudo apt install fail2ban
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
```

```
maxretry = 3

[sshd]
enabled = true
```

## shadowsocks

```bash
sudo apt install shadowsocks-libev
```

```bash
sudo vim /etc/shadowsocks-libev/config.json
```

```
{
    "server":"0.0.0.0",
    "server_port":443,
    "local_port":1080,
    "password":"PASSWORD",
    "timeout":60,
    "method":"chacha20-ietf-poly1305"
}
```

## Optimize the shadowsocks server on Linux

```bash
sudo vim /etc/security/limits.conf
```

```
* soft nofile 51200
* hard nofile 51200
```

```bash
sudo ulimit -n 51200
```

```bash
sudo vim /etc/sysctl.conf
```

```
# max open files
fs.file-max = 51200

# max read buffer
net.core.rmem_max = 67108864
# max write buffer
net.core.wmem_max = 67108864
# max processor input queue
net.core.netdev_max_backlog = 250000
# max backlog
net.core.somaxconn = 4096

# resist SYN flood attacks
net.ipv4.tcp_syncookies = 1
# reuse timewait sockets when safe
net.ipv4.tcp_tw_reuse = 1
# turn off fast timewait sockets recycling
net.ipv4.tcp_tw_recycle = 0
# short FIN timeout
net.ipv4.tcp_fin_timeout = 30
# short keepalive time
net.ipv4.tcp_keepalive_time = 1200
# outbound port range
net.ipv4.ip_local_port_range = 10000 65000
# max SYN backlog
net.ipv4.tcp_max_syn_backlog = 8192
# max timewait sockets held by system simultaneously
net.ipv4.tcp_max_tw_buckets = 5000
# turn on TCP Fast Open on both client and server side
net.ipv4.tcp_fastopen = 3
net.ipv4.tcp_mem = 25600 51200 102400
# TCP receive buffer
net.ipv4.tcp_rmem = 4096 87380 67108864
# TCP write buffer
net.ipv4.tcp_wmem = 4096 65536 67108864
# turn on path MTU discovery
net.ipv4.tcp_mtu_probing = 1

# for high-latency network
net.ipv4.tcp_congestion_control = hybla
# for low-latency network, use cubic instead
# net.ipv4.tcp_congestion_control = cubic
```

```bash
sudo sysctl -p
```

# Client

```
sudo ip route add SERVER_IP via GATEWAY_IP
sudo echo nameserver 8.8.8.8 > /etc/resolv.conf

ss-local -s SERVER_IP -p 443 -l 1080 -k PASSWORD -m chacha20-ietf-poly1305 -v
chromium --incognito --proxy-server="socks5://127.0.0.1:1080"
```

