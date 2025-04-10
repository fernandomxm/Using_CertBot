#!/bin/bash

sudo certbot --manual --preferred-challenges dns certonly --manual-auth-hook /home/fernando/certificados/gcp.sh -d *.dominio.com.br
