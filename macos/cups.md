# Printing from the command line on macOS

Add a printer:

    # lpadmin \
    -p Printer                      # Arbitrary printer name \
    -v ipp://192.168.1.10/ipp/print # device URI \
    -P Vendor-Model.ppd             # path to the PPD file \
    -E                              # enable accepting jobs

Check available printers:

    $ lpstat -a
    Printer accepting requests since Sat Mar 31 23:59:32 2018
    $

Print a document:

    $ lp -d Printer document.pdf

Delete the printer:

    # lpadmin -x Printer
