_Tested on [macOS](/macos/) 10.13 with [VirtualBox](/virtualbox/) 5.2_

# Create OpenBSD VM in VirtualBox


Download [ISO
image](https://cdn.openbsd.org/pub/OpenBSD/6.3/amd64/install63.iso)
of the OpenBSD installer.

Start VirtualBox.

![macOS VirtualBox](/macos/virtualbox/welcome.png)

Select from the menu _Machine > New..._

In _Name and operating system_:

> _Name_: **foo**<br>
> _Type_: **BSD**<br>
> _Version_: **OpenBSD (64-bit)**<br>

Click _Continue_.

![Name and operating system](/virtualbox/01.png)

In _Memory size_ select at least **2048 MB**.

![Memory size](/virtualbox/02.png)

In _Hard disk_ select **Create a virtual hard disk now**.

![Hard disk](/virtualbox/03.png)

In _Hard disk file type_ select **VDI**.

![Hard disk file type](/virtualbox/04.png)

In _Storage on physical hard disk_ select **Dynamically allocated**.

![Storage on physical hard disk](/virtualbox/05.png)

In _File location and size_ keep default file location (`~/VirtualBox
VMs/foo/foo.vdi`) and size (16 GB). _OpenBSD fits into 1GB, but
you'll need some space for your programs and data._

Click _Create_.

![File locaton and size](/virtualbox/06.png)

Select from the menu _Machine > Settings..._

Select _Storage_, then select _Storage Devices >Controller: IDE > Empty_.

![](/virtualbox/09.png)

In corresponding _Attributes_ click on CD icon near _Optical Drive:
IDE Secondary Master_ and select _Choose Virtual Optical Disk
File..._.

Pick the previously downloaded OpenBSD installer ISO image.

![](/virtualbox/10.png)

Click _OK_.

![](/virtualbox/11.png)

Select from the menu _Machine > Start > Normal Start_.
_OpenBSD installer boots in a new window..._

![](/virtualbox/13.png)

[Install OpenBSD](/openbsd/install.html)
