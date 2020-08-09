sp_configure 'show advanced options', 1;
GO
RECONFIGURE;
GO
sp_configure 'Database Mail XPs', 1;
GO
RECONFIGURE
GO


EXECUTE msdb.dbo.sysmail_add_account_sp
@account_name = 'ExampleMailProfile',
@description = 'Example mail',
@email_address = 'email@example.com',
@display_name = 'Example - SQL',
@username='email@example.com',
@password='PASSWORD',
@mailserver_name = 'smtp.office365.com',
    @port = 587,
    @enable_ssl = 1



EXECUTE msdb.dbo.sysmail_add_profile_sp
@profile_name = 'ExampleMailProfile',
@description = 'Example profile'



EXECUTE msdb.dbo.sysmail_add_profileaccount_sp
@profile_name = 'ExampleMailProfile',
@account_name = 'ExampleMailProfile',
@sequence_number = 1



EXECUTE msdb.dbo.sysmail_add_principalprofile_sp 
@profile_name = 'ExampleMailProfile', 
@principal_name = 'public', 
@is_default = 1 ;



--Teste de email
exec msdb.dbo.sp_send_dbmail 
@profile_name = 'ExampleMailProfile', 
@recipients = 'email_2@example.com', 
@subject = 'Mail Test', 
@body = 'Mail Sent Successfully', 
@body_format = 'text'


