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
        'i-0a68fd1ee65e3e636',
    ],
    DocumentName='AWS-RunShellScript',
    Parameters={
        'commands': [
            f'python3 /home/ec2-user/test.py "{message}"',
            'shutdown -h now'
        ]
    }
)
