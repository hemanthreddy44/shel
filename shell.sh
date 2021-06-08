#!/bin/bash

cat <<EOF >> myscript.txt
#!/bin/bash
apt update -y
apt install apache2 -y
cd /var/www/html
echo "<html><h1>Welcome to Saaspect</h1></html>" > index.html
EOF

sleep 10

aws ec2 run-instances --image-id ami-0c1a7f89451184c8b --count 1 --instance-type t2.micro --key-name tkp --security-group-ids sg-0e1b1d6f7e9c8aba4  --user-data file://myscript.txt  --tag-specifications 'ResourceType=instance,Tags=[{Key=company:,Value=Saaspect}]'

echo "we have deployed our web server ec2 instance"
aws s3api create-bucket --bucket my-bucket0000saaspect --region us-east-1

echo "we have created a new bucket with cli"
