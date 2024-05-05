!#/bin/bash

brew install wireguard-tools

# generate keys
wg genkey | tee server_private.key | wg pubkey >server_public.key
wg genkey | tee client_private.key | wg pubkey >client_public.key

# fill keys in config files
perl -pi -e "s|<server_private_key>|$(cat server_private.key)|" server_config.conf
perl -pi -e "s|<server_public_key>|$(cat server_public.key)|" client_config.conf
perl -pi -e "s|<client_private_key>|$(cat client_private.key)|" client_config.conf
perl -pi -e "s|<client_public_key>|$(cat client_public.key)|" server_config.conf

# fill server ip address in client config with my host ip address
perl -pi -e "s|<server_external_ip>|$(ipconfig getifaddr en0)|" client_config.conf
