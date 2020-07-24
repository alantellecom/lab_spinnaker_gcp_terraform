#!/bin/bash

email="allanasodreferreira@gmail.com"
project_gcp="robotic-tide-284315"

export SA_JSON=$(cat spinnaker-sa.json)

cat > spinnaker-config.yaml <<EOF
gcs:
  enabled: true
  bucket: spinnaker_config_bucket
  project: $project_gcp
  jsonKey: '$SA_JSON'

dockerRegistries:
- name: gcr
  address: https://gcr.io
  username: _json_key
  password: '$SA_JSON'
  email: $email

# Disable minio as the default storage backend
minio:
  enabled: false

# Configure Spinnaker to enable GCP services
halyard:
  additionalScripts:
    create: true
    data:
      enable_gcs_artifacts.sh: |-
        \$HAL_COMMAND config artifact gcs account add gcs-$project_gcp  \
          --json-path /opt/gcs/key.json
        \$HAL_COMMAND config artifact gcs enable
      enable_pubsub_triggers.sh: |-
        \$HAL_COMMAND config pubsub google enable
        \$HAL_COMMAND config pubsub google subscription add gcr-triggers \
          --subscription-name gcr-triggers \
          --json-path /opt/gcs/key.json \
          --project $project_gcp \
          --message-format GCR
EOF


./helm install -n default cd stable/spinnaker -f spinnaker-config.yaml \
          --version 1.23.0 --timeout 10m0s --wait

