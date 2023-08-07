# ubi-rclone
Running rclone with UBI

export XDG_CONFIG_HOME=/tmp

mkdir /tmp/rclone

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

rclone ls dsn: --no-check-certificate

