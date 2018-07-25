_Tested on [macOS](/macos/) 10.13._

# Print with cups(1) on macOS

Add a printer:

<pre>
# <b>lpadmin -E \
-p Printer \
-v ipp://192.168.1.10/ipp/print \
-P Vendor-Model.ppd</b>
#
</pre>

_-E_ enables accepting job<br>
_-p_ an arbitrary printer name<br>
_-v_ the device URI<br>
_-P_ a path to the PPD file<br>

Check available printers:

<pre>
$ <b>lpstat -a</b>
Printer accepting requests since Sat Mar 31 23:59:32 2018
$
</pre>

Print a document:

<pre>
$ <b>lp -d Printer document.pdf</b>
$
</pre>

Delete the printer:

<pre>
# <b>lpadmin -x Printer</b>
#
</pre>
