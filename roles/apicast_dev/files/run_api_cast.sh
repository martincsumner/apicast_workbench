#!/bin/bash


cd /opt/apicast/apicast-3.0.0

RHSSO_ENDPOINT=https://0966ea1f.ngrok.io/auth/realms/fourmarks \
APICAST_MANAGEMENT_API=debug \
THREESCALE_PORTAL_ENDPOINT=https://8bb82bcc08163918b205da1257ec3bdbf36b7af4a94a4b8bd890b88464644afb@redhatmsumner-admin.3scale.net \
bin/apicast -vvv 


#RHSSO_ENDPOINT=http://localhost:8080/auth/realms/fourmarks APICAST_MANAGEMENT_API=debug THREESCALE_PORTAL_ENDPOINT=https://8bb82bcc08163918b205da1257ec3bdbf36b7af4a94a4b8bd890b88464644afb@redhatmsumner-admin.3scale.net bin/apicast -d -vvv