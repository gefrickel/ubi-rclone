# ubi-rclone

### Running rclone with UBI
````
export XDG_CONFIG_HOME=/tmp
````
````
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
