---
layout: note
title: "Wifi: Authenticate from command line"
tagline: ""
published: false
category : notes
tags : [note, network, wifi, cli, authnz]
---

cat <<EOF
ctrl_interface=/run/wpa_supplicant
ctrl_interface_group=wheel
update_config=1

ap_scan=1
fast_reauth=1

$(wpa_passphrase Livebox-9e74 537CE5465654C375E1CA55AC72)

network={
    ssid="Livebox-9e74_EXT"
    psk="537CE5465654C375E1CA55AC72"
}

# Public wifi with no passphrase.
network={
    ssid="MYSSID"
    key_mgmt=NONE
}

EOF
