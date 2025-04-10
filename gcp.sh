#!/bin/bash

# gcloud auth application-default login
echo $CERTBOT_VALIDATION
gcloud config set project dns
gcloud dns record-sets list --zone=dominiocombr
gcloud dns record-sets describe _acme-challenge.dominio.com.br --type=TXT --zone=dominiocombr
gcloud dns record-sets update _acme-challenge.dominio.com.br --rrdatas=$CERTBOT_VALIDATION --ttl=5 --type=TXT --zone=dominiocombr
gcloud dns record-sets describe _acme-challenge.dominio.com.br --type=TXT --zone=dominiocombr

# Sleep to make sure the change has time to propagate over to DNS
sleep 25
