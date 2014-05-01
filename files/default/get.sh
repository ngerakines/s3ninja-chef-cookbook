#!/bin/sh

host=$1
bucket=$2
file=$3
resource="/${bucket}/${file}"
dateValue=`date -R`
stringToSign="GET\n\n\n${dateValue}\n${resource}"
s3Key=AKIAIOSFODNN7EXAMPLE
s3Secret="wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"
signature=`echo -en ${stringToSign} | openssl sha1 -hmac ${s3Secret} -binary | base64`
curl -H "Host: ${bucket}.s3.amazonaws.com" -H "Date: ${dateValue}" -H "Authorization: AWS ${s3Key}:${signature}" http://$1/s3/$2/${file}
