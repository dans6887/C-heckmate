
###################################################################################
#  ██████╗   ██╗  ██╗███████╗ ██████╗██╗  ██╗███╗   ███╗ █████╗ ████████╗███████╗ #
# ██╔════╝██╗██║  ██║██╔════╝██╔════╝██║ ██╔╝████╗ ████║██╔══██╗╚══██╔══╝██╔════╝ #
# ██║     ╚═╝███████║█████╗  ██║     █████╔╝ ██╔████╔██║███████║   ██║   █████╗   #
# ██║     ██╗██╔══██║██╔══╝  ██║     ██╔═██╗ ██║╚██╔╝██║██╔══██║   ██║   ██╔══╝   #
# ╚██████╗╚═╝██║  ██║███████╗╚██████╗██║  ██╗██║ ╚═╝ ██║██║  ██║   ██║   ███████╗ #
#  ╚═════╝   ╚═╝  ╚═╝╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝   ╚═╝   ╚══════╝ #
###################################################################################

#Get the status of your hard drive's freespace and email the status using the gmail SMTP server. 
#C:heckmate logo does not display in web-based email apps like gmail or Outlook 365 web version. 
#C:heckmate logo does display in non-webbased email applications such as Outlook and Thunderbird.

$threshold = 100GB #set threshold here. Can be set to MB, GB, TB
$c_drive = Get-PSDrive -PSProvider FileSystem -Name C #get the hard drive info
$hostname = get-computerinfo -Property csdnshostname #get the hostname of the machine
$c_free_space = [Math]::Round(((Get-Volume -DriveLetter C).SizeRemaining /1TB),2)#calculate remaining space on drive C: and round it to 2 decimal places

#email details
$From = "desired Sender Address"  #"your-gmail-address@gmail.com"
$To = "desired Recipient address here"  #"the-destination-user@domain.com"
$Subject = "C:heckmate - Disc Space Alert" #"Email subject goes here"
$Body = @"

<html>
    <head>
        <meta charset="utf-8">
        <title>C:heckmate Drive Checker</title>
        <meta name="Daniel Scott" content="Disk Space Alert">
        <link rel="stylesheet" href="css/masterstyle.css" type="text/css" />
    </head>
    <body>

        <div class="content">
            <!--<img src="cid:checkmatelogo.png" />-->
            <div class="sub-content1">
                <img class="logo" src="data:image/png;base64,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" alt="c:heckmate logo" />
            
            </div>
            <div class="sub-content2">
                <br>
                <br>
                <h2 class="">System Status Alert</h2>
                <hr/>
                <br>
                <b>Drive Status</b>
                <p>Drive $($c_drive.Name): on $($hostname.CsDNSHostName) is running low on space.</p>
                <p>Freespace on drive $($c_drive.Name): is down to: $($c_free_space) TB </p> 
            </div>

        </div>
    </body>
</html>

"@

# The password is an app-specific password if you have 2-factor-auth enabled
$Password = "Enter app Specific Password Here" | ConvertTo-SecureString -AsPlainText -Force #you will need an app specific password 
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $From, $Password

#if the threshold is triggered, build and send the mail message.
if ($c_drive.Free -lt $threshold){ 

   
        Send-MailMessage -From $From -To $To -Subject $Subject -BodyAsHtml $Body -SmtpServer "smtp.gmail.com" -port 587 -UseSsl -Credential $Credential
    
    
}

