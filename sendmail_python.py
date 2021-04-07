#!/usr/bin/python
from email.message import EmailMessage
from subprocess import Popen

mail_array = ['test1@mail.com', 'test2@mail.com', 'test3@mail.com']

def send_mail(mail_array):
        for mail in mail_array:
                file_name = "test.xls"

                msg = EmailMessage()

                msg["From"] = "test@mail.com"
                msg["To"] = mail
                msg["Subject"] = "This is test"
                msg.set_content(f"""
                                THIS IS TEST BODY
                """)

                with open(f'test.xlsx', 'rb' ) as f:
                        file_data = f.read()
                        file_name = 'test.xlsx'

                msg.add_attachment(file_data, maintype="application", subtype="xlsx", filename = file_name )

                p = Popen(["/usr/sbin/sendmail", "-t"], stdin=PIPE)

                p.communicate(msg.as_string().encode())
send_mail(mail_array)
