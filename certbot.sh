#!/bin/bash

sudo certbot --manual --preferred-challenges dns certonly --manual-auth-hook /home/fernando/certificados/gcp.sh --email fernando@gmail.com --agree-tos --eff-email -d *.dominio.com.br

## Manual
sudo certbot --manual --preferred-challenges dns certonly --email fernando@gmail.com --agree-tos --eff-email -d *.dominio.com.br
