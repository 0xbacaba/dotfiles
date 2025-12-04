#!/bin/bash

SCANNED=`hyprshot -m region --raw | zbarimg --raw -q -`
if [ -z "$SCANNED" ]; then
  exit 0
fi

if ! wl-copy "$SCANNED"; then
  action=`notify-send -i dialog-warning "Not copied to clipboard: $?" -A open "$SCANNED"`
else
  action=`notify-send -i view-barcode-qr -A open "Copied to clipboard" "$SCANNED"`
fi

if [ ! -z "$action" ]; then
  xdg-open "$SCANNED"
fi
