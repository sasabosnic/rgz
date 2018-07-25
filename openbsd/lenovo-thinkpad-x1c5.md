# Prepare ThinkPad X1&nbsp;Carbon&nbsp;Gen&nbsp;5 for OpenBSD

Turn ThinkPad on and press **F1** to enter _Setup_.

Select _Security > I/O Ports_, set **Bluetooth** and **Fingerprint
Reader** to **Disabled**. These devices are not supported by OpenBSD.
Disable other devices you don't use.

Select _Security > Secure Boot_, set **Secure Boot** to **Disabled**.

Select _Startup > Boot_, set **Boot Priority Order** to:<br> **USB
HDD**, then **NVMe0 ...**.

Select _Startup_, set _UEFI/Legacy Boot_ to **UEFI Only**.

Press **F10** to save changes and reboot.

[Install OpenBSD](install.html).
