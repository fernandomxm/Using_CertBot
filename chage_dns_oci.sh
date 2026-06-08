#!/bin/bash

OCI=/root/bin/oci
echo $CERTBOT_VALIDATION
$OCI dns record domain patch --zone-name-or-id domain.com.br --domain _acme-challenge.domain.com.br \
  --items '[
    {
      "domain":"_acme-challenge.domain.com.br",
      "rtype":"TXT",
      "ttl":300,
      "rdata":"\"'$CERTBOT_VALIDATION'\"",
      "operation":"ADD"
    }
  ]'

$OCI dns record domain get --zone-name-or-id domain.com.br --domain _acme-challenge.domain.com.br
dig TXT _acme-challenge.domain.com.br +short
sleep 180
