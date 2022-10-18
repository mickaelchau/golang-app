#!/bin/sh
while sleep 3; do curl -H "Authorization: Bearer $(gcloud auth print-identity-token)" https://golang-app-r4yqmr3v3q-oa.a.run.app; done