#!/bin/bash

OCI=/root/bin/oci
$OCI dns record domain patch --zone-name-or-id domain.com.br --domain _acme-challenge.domain.com.br \
  --items '[
    {
      "domain":"_acme-challenge.domain.com.br",
      "rtype":"TXT",
      "rdata":"\"'$CERTBOT_VALIDATION'\"",
      "operation":"REMOVE"
    }
  ]'
