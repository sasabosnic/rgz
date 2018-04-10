# Printing with CUPS

Install CUPS and connect to a remote printer via IPP:

    # pkg_add cups
    # lpadmin -p printer -E -v ipp://192.168.1.10/ipp/print -m everywhere

Check available printers:

    $ lpstat -a
    printer accepting requests since Sat Mar 31 23:59:32 2018

Print:

    $ lp -d "printer" document.pdf
