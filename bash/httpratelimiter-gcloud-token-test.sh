curl -m 12 -X POST $HTTPRATELIMITER_ENDPOINT -H "Authorization: Bearer $(gcloud auth print-identity-token --impersonate-service-account=$AUTHORIZED_SERVICE_EMAIL)" -H "X-API-Key: $($API_KEY)
