# AWS S3 Docker action

This actions using the [AWS-CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-welcome.html) to sync a directory from your repository to a S3 bucket.

## Inputs

| Key | Description | Required | Type |
| --- | ----------- | -------- | ---- |
| `AWS_ACCESS_KEY_ID` | The  AWS Access Key | **TRUE** | **SECRET** |
| `AWS_SECRET_ACCESS_KEY` | The AWS secret access key | **TRUE** | **SECRET** |
| `AWS_REGION` | The region of the bucket | **TRUE** | |
| `BUCKET_NAME` | The bucket to sync | **TRUE** | **SECRET** |
| `SOURCE` | Your local file path that you wish to upload to S3 | **TRUE** | |
| `TARGET` | The destination of the source after sync in S3 | **TRUE** | |
| `WITH_DELETE` | If you want to use the [*--delete* flag](https://docs.aws.amazon.com/cli/latest/reference/s3/sync.html#synopsis) | | | 
| `WITH_CLOUDFRONT_INVALIDATION` | If you want to use cloudfront invalidation | | |
| `AWS_CLOUDFRONT_DISTRIBUTION_ID` | The cloudfront distributions id (use only if you need invalidation) | | **SECRET** |  

## Example usage

Create the file `workflow.yml` in `.github/workflows` folder. 

```
name: S3 Sync
on ['push']

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@master

      - name: Sync to S3
        uses: raulanatol/aws-s3-docker-action@master
        env:
          AWS_ACCESS_KEY_ID:
          AWS_SECRET_ACCESS_KEY:
          AWS_REGION: 
          BUCKET_NAME: 
          SOURCE: 
          TARGET: 
          WITH_DELETE: 
          WITH_CLOUD_FRONT_INVALIDATION: 
          AWS_CLOUDFRONT_DISTRIBUTION_ID: 
```
