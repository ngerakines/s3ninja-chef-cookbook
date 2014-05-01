#!/bin/sh

host=$1
bucket=$2
file=$3
payload=$4
contentType=$5
resource="/${bucket}/${file}"
dateValue=`date -R`
stringToSign="PUT\n\n${contentType}\n${dateValue}\n${resource}"
s3Key=AKIAIOSFODNN7EXAMPLE
s3Secret="wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"
signature=`echo -en ${stringToSign} | openssl sha1 -hmac ${s3Secret} -binary | base64`
curl -X PUT --data-ascii "$payload" -H "Host: ${bucket}.s3.amazonaws.com" -H "Date: ${dateValue}" -H "Content-Type: ${contentType}" -H "Authorization: AWS ${s3Key}:${signature}" http://$1/s3/$2/${file}
