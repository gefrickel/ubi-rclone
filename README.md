# ubi-rclone

### Running rclone with UBI
````
export XDG_CONFIG_HOME=/tmp
export SCREENDIR=/tmp/screen
````
````
mkdir /tmp/screen
chmod -R 777 /tmp/screen
mkdir /tmp/rclone
````
````
cat << EOF > /tmp/rclone/rclone.conf
[dsn]
type = s3
provider = Ceph
access_key_id = <>
secret_access_key = <>
endpoint = <>
EOF
````
````
rclone ls dsn: --no-check-certificate
````
### Running AWSCLI with UBI
````
aws configure --profile minio
````
````
aws --endpoint-url http://minio-velero.apps.cp4d.mop --profile minio s3 ls
````
````
for i in $(ls -la *.zip | awk '{print $9}'); do aws --endpoint-url http://minio-velero.apps.cp4d.mop --profile minio s3 cp $i s3://yaddayadda; done
````

````
oc -n rook-ceph get cm ceph-bucket -o jsonpath='{.data.BUCKET_HOST}'
oc -n rook-ceph get cm ceph-bucket -o jsonpath='{.data.BUCKET_PORT}'
oc -n rook-ceph get cm ceph-bucket -o jsonpath='{.data.BUCKET_NAME}'
oc -n rook-ceph get secret ceph-bucket -o jsonpath='{.data.AWS_ACCESS_KEY_ID}' | base64 --decode
oc -n rook-ceph get secret ceph-bucket -o jsonpath='{.data.AWS_SECRET_ACCESS_KEY}' | base64 --decode
````
````
export AWS_HOST=$(oc -n rook-ceph get cm ceph-bucket -o jsonpath='{.data.BUCKET_HOST}')
export PORT=$(oc -n rook-ceph get cm ceph-bucket -o jsonpath='{.data.BUCKET_PORT}')
export BUCKET_NAME=$(oc -n rook-ceph get cm ceph-bucket -o jsonpath='{.data.BUCKET_NAME}')
export AWS_ACCESS_KEY_ID=$(oc -n rook-ceph get secret ceph-bucket -o jsonpath='{.data.AWS_ACCESS_KEY_ID}' | base64 --decode)
export AWS_SECRET_ACCESS_KEY=$(oc -n rook-ceph get secret ceph-bucket -o jsonpath='{.data.AWS_SECRET_ACCESS_KEY}' | base64 --decode)
````
````
aws configure --profile minio
aws --endpoint-url http://minio-velero.apps.cp4d.mop --profile minio s3 ls
for i in $(ls -la *.zip | awk '{print $9}'); do aws --endpoint-url http://minio-velero.apps.cp4d.mop --profile minio s3 cp $i s3://digitale-schiene; done
````
````
aws configure --profile rook
aws --endpoint-url http://rgw-rook-ceph.apps.discover.cp4d.mop --profile rook s3 ls
for i in $(ls -la *.zip | awk '{print $9}'); do aws --endpoint-url http://rgw-rook-ceph.apps.discover.cp4d.mop --profile rook s3 cp $i s3://ceph-bkt-d7d6ecaf-0865-498e-a832-f2ffcb09e189; done
````


