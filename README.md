# Using_CertBot
Using_CertBot

https://pypi.org/project/certbot/#description

pip install certbot

########## AUTOMATIZANDO RENOVAÇÃO OCI ###################

#############     SCRIPTS LINUX     #####################

/root/change_dns_oci.sh (chmod 700)

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

/root/remove_dns_oci.sh (chmod 700)

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

/root/atualiza_cert.sh (chmod 700)

#!/bin/bash
sudo certbot --manual --preferred-challenges dns certonly --manual-auth-hook /root/chage_dns_oci.sh --manual-cleanup-hook /root/remove_dns_oci.sh --email fernando@email.com --agree-tos --eff-email -d *.domain.com.br

systemctl reload nginx

Resultado(Geração do certificado nesse caminho):
Certificate is saved at: /etc/letsencrypt/live/domain.com.br/fullchain.pem
Key is saved at:         /etc/letsencrypt/live/domain.com.br/privkey.pem

Configurar Crontab(Linux) para rodar script atualiza_cert.sh mensalmente

crontab -e
0 8 1 * * root /root/atualiza_cert.sh

#######################     SCRIPTS WINDOWS     ###################################

C:\Certbot\change_dns_oci.bat

@echo off
echo %CERTBOT_VALIDATION%

oci dns record domain patch --zone-name-or-id domain.com.br --domain _acme-challenge.domain.com.br --items "[{\"domain\":\"_acme-challenge.domain.com.br\",\"rtype\":\"TXT\",\"ttl\":300,\"rdata\":\"\\\"%CERTBOT_VALIDATION%\\\"\",\"operation\":\"ADD\"}]"

oci dns record domain get --zone-name-or-id domain.com.br --domain _acme-challenge.domain.com.br

timeout /t 180 /nobreak

C:\Certbot\remove_dns_oci.bat

@echo off

oci dns record domain patch --zone-name-or-id domain.com.br --domain _acme-challenge.domain.com.br --items "[{\"domain\":\"_acme-challenge.domain.com.br\",\"rtype\":\"TXT\",\"rdata\":\"\\\"%CERTBOT_VALIDATION%\\\"\",\"operation\":\"REMOVE\"}]"

C:\Certbot\atualiza_cert.bat

@echo off

certbot certonly --manual --preferred-challenges dns --manual-auth-hook "C:\Certbot\change_dns_oci.bat" --manual-cleanup-hook "C:\Certbot\remove_dns_oci.bat" --email fernando@email.com --agree-tos --eff-email -d *.domain.com.br

Resultado(Geração do certificado nesse caminho):
Certificate is saved at: C:\Certbot\live\domain.com.br\fullchain.pem
Key is saved at:         C:\Certbot\live\domain.com.br\privkey.pem

Configurar Crontab(Linux) para rodar script atualiza_cert.sh mensalmente

schtasks /create /tn "Certbot-Renovacao-Mensal" /tr "C:\Certbot\atualiza_cert.bat" /sc monthly /d 1 /st 08:00 /ru "SYSTEM" /rl highest
