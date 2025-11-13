# ██████╗   ██╗  ██╗███████╗ ██████╗██╗  ██╗███╗   ███╗ █████╗ ████████╗███████╗
#██╔════╝██╗██║  ██║██╔════╝██╔════╝██║ ██╔╝████╗ ████║██╔══██╗╚══██╔══╝██╔════╝
#██║     ╚═╝███████║█████╗  ██║     █████╔╝ ██╔████╔██║███████║   ██║   █████╗  
#██║     ██╗██╔══██║██╔══╝  ██║     ██╔═██╗ ██║╚██╔╝██║██╔══██║   ██║   ██╔══╝  
#╚██████╗╚═╝██║  ██║███████╗╚██████╗██║  ██╗██║ ╚═╝ ██║██║  ██║   ██║   ███████╗
 #╚═════╝   ╚═╝  ╚═╝╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝   ╚═╝   ╚══════╝

#Get the status of your hard drive's freespace

$threshold = 20GB #set your threshhold
$c_drive = Get-PSDrive -PSProvider FileSystem -Name C #Get C: Data from the file system

#email details
$From = "your-gmail-address@gmail.com"
$To = "the-destination-user@domain.com"
$Subject = "Email subject goes here"
$Body = "Drive $($c_drive.Name) is running low on space."

# The password is an app-specific password if you have 2-factor-auth enabled
$Password = "Enter the app specific password here" | ConvertTo-SecureString -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $From, $Password



if ($c_drive.Free -le $threshold){ #If freespace on C: is less than the threshhold. Send an email alert to the destination email from your gmail address. 
    Send-MailMessage -From $From -To $To -Subject $Subject -Body $Body -SmtpServer "smtp.gmail.com" -port 587 -UseSsl -Credential $Credential   
}