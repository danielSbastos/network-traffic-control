# Network Traffic Control
Controlling and monitoring a local network and its hosts.

Group members: [@danielSbastos](https://github.com/danielSbastos), [@rossanaoliveirasouza](https://github.com/rossanaoliveirasouza), [@isabelaaaguilar](https://github.com/isabelaaaguilar) and [@Kronomant](https://github.com/Kronomant).


## Architecture

![image](https://user-images.githubusercontent.com/21130697/170607881-bcdf0a8b-095a-4f1a-b00b-5593b6aaacdb.png)

The intermediary computer is set to be "new" router where all the hosts will connect. With this, the local network traffic can be analyzed.

To monitor the local traffic, `tcpdump` was simply run on the given wireless interface (steps below).

To control the local traffic, Linux Traffic Control (`tc`) was applied to the interface (steps below).

## Configuration

Steps needed prior to the actual monitoring and controlling steps.

### Creating a hotspot

Simply follow the [tutorial](https://help.ubuntu.com/stable/ubuntu-help/net-wireless-adhoc.html.en) to create a hotspot. To find the IP of the new private network, run a `ifconfig` to find out. In our case, it was `10.42.1.d`, for the sake of simplycity, let's suppose for the rest of this README that the IP was set to `a.b.c.d`.

### Allocating static IPs to the hosts

With static IPs, it is easier to later analyse the impact per device/IP.

Use the `dhclient.conf` file by appending its contents to your file. Change the MAC addresses to match your devices, and also tweak the IPs to match the correct private network. So, if the network IP is `a.b.c.d`, that you want to allocate the final decimal as `10` and that the MAC address is `00:00:00:00:00:00`:

```sh
host deviceBla {
	hardware ethernet 00:00:00:00:00:00;
	fixed-address a.b.c.10;
}
```

Now simply reload the dhcp server or restart the computer. 

### Autostart hotspot at boot

Run 
```sh
sudo -H gedit /etc/NetworkManager/system-connections/Hotspot
```

and change `autoconnect` (or add the entry) to `true`: `autoconnect=true`


## Monitoring | Capturing local traffic

By running `tcpdump` on the wireless interface, a `pcap` file is generated which can be further used for analysis.

`IF` is the wireless interface.

```sh
IF=wlo1 && tcpdump -i $IF -w analysis.pcap
```

## Control | Applying Traffic Control configurations


Change the IPs (10.42.1.xxx) to the ones that match you devices

```sh
/bin/bash shape.sh
```

