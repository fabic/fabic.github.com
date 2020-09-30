---
layout: note
title: "Wifi: Authenticate from command line"
tagline: ""
published: false
category : notes
tags : [note, network, wifi, cli, authnz]
---

* __TODO:__ see [fabic/bin/woof-up.sh](https://github.com/fabic/bash-it/blob/master/fabic/bin/woof-up.sh)

```bash
$ cat <<EOF >> /etc/wpa_supplicant/wpa_supplicant.conf
ctrl_interface=/run/wpa_supplicant
ctrl_interface_group=wheel
update_config=1

ap_scan=1
fast_reauth=1

$(wpa_passphrase Livebox-9e74 my-secret-passphrase)

$(wpa_passphrase livebux das-secret-passphrase-clear-text)

network={
    ssid="Livebox-9e74_EXT"
    psk="my-secret-passphrase"
}

# Public wifi with no passphrase.
network={
    ssid="MYSSID"
    key_mgmt=NONE
}

EOF
```

