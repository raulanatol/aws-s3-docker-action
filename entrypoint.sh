#!/bin/sh

set -e

if [ -z "$AWS_ACCESS_KEY_ID" ]; then
  echo "AWS_ACCESS_KEY_ID is not set"
  exit 1
fi

if [ -z "$AWS_SECRET_ACCESS_KEY" ]; then
  echo "AWS_SECRET_ACCESS_KEY is not set"
  exit 1
fi

if [ -z "$AWS_BUCKET_NAME" ]; then
  echo "AWS_BUCKET_NAME is not set"
  exit 1
fi

echo "Starting..."

mkdir -p ~/.aws
echo -e "[default]\naws_access_key_id=${AWS_ACCESS_KEY_ID}\naws_secret_access_key=${AWS_SECRET_ACCESS_KEY}" >~/.aws/credentials
echo -e "[default]\nregion=${AWS_REGION}\noutput=json" >~/.aws/config

FLAGS=""
if [ -z "${WITH_DELETE}" ]; then
  FLAGS="${FLAGS} --delete"
fi

aws s3 sync ${SOURCE} s3://${AWS_BUCKET_NAME}/${TARGET} ${FLAGS}

if [ -n "${WITH_CLOUD_FRONT_INVALIDATION}" ]; then
  if [ -z "${AWS_CLOUDFRONT_DISTRIBUTION_ID}" ]; then
    echo "Impossible to request an invalidation we need the AWS_CLOUDFRONT_DISTRIBUTION_ID value"
    exit 1
  else
    aws cloudfront create-invalidation --distribution-id ${AWS_CLOUDFRONT_DISTRIBUTION_ID} --paths "${AWS_CLOUDFRONT_INVALIDATION_PATH}"
  fi
fi

rm -rf ~/.aws
