'''
c5 -> type instance
iop2 -> EBS

lsblk
sudo -su
mkdir /sharedfs
mkfs -t xfs /dev/nvme1n1(run it only once)
mount /dev/nvme1n1  /sharedfs
'''

import boto3
import sys 
import os
import time

client = boto3.client('ssm')
message = sys.argv[1]


os.system("aws ec2 start-instances \
            --instance-ids i-0a68fd1ee65e3e636 \
            --region us-east-1")

time.sleep(120)


client.send_command(
    InstanceIds=[
        'i-08b14c8e3a1802d39',
        'i-0c92a012ed53e2e51'

    ],
    DocumentName='AWS-RunShellScript',
    Parameters={
        'commands': [
            f'python3 /home/ec2-user/test.py "TEST OK!!!"',
            'shutdown -h now'
        ]
    }
)
