# How to set up step-ca

# step ca details for bootstrap
tenant="https://notfulcio.nfsmithca.ca.smallstep.com"
fingerprint="1a909073a65434c55ec0a53c6043aed4197c6760890fed63d1c3f265154d30b0"

# Bootstrap client
step ca bootstrap --ca-url $tenant --fingerprint $fingerprint 

# Set up github actions provisioner
step ca provisioner add GithubActions \
    --type oidc \
    --client-id "smallstep" \ # Use tenant URL for audience in github actions
    --client-secret "" \  # Don't set a client-secret as we won't "login"
    --configuration-endpoint https://token.actions.githubusercontent.com/.well-known/openid-configuration

# Harden the provisioner a bit
step ca provisioner update GithubActions \
    --ssh=false \ # Turn off SSH Certificate Authority
    --disable-renewal=true \ # No renewing certificates
    --x509-max-dur=10m \ # Short lived certs
    --x509-default-dur=10m \
    --x509-min-dur=1m

# What do Fulcio certificates for Github actions look like? (this cert from cgr.dev/chainguard/busybox:latest)
rekor-cli get --log-index 10589003 --format json | \
    jq .Body.HashedRekordObj.signature.publicKey.content -r | \
    base64 -d | \
    openssl x509 -noout -text

# Set template
step ca provisioner update GithubActions --x509-template ./template.tpl

