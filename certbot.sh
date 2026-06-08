#!/bin/bash

sudo certbot --manual --preferred-challenges dns certonly --manual-auth-hook /root/chnage_dns_oci.sh --manual-cleanup-hook /root/remove_dns_oci.sh --email fernando@gmail.com --agree-tos --eff-email -d *.dominio.com.br

## Manual
sudo certbot --manual --preferred-challenges dns certonly --email fernando@gmail.com --agree-tos --eff-email -d *.dominio.com.br
