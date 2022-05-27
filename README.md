# Network Traffic Control
Controlling and monitoring a local network and its hosts

## Architecture

![image](https://user-images.githubusercontent.com/21130697/170607881-bcdf0a8b-095a-4f1a-b00b-5593b6aaacdb.png)


## Capturing local traffic

`IF` is the wireless interface.

```sh
IF=wlo1 && tcpdump -i $F1 -w analysis.pcap
```

## Applying Traffic Control configurations


Change the IPs (10.42.1.xxx) to the ones that match you devices

```sh
/bin/bash shape.sh
```

## Allocating static IPs to the hosts

With static IPs, it is easier to later analyse the impact per device/IP.

Use the `dhclient.conf` file by appending its contents to your file. Change the MAC addresses to match your devices, and also tweak the IPs to match the correct private network.
