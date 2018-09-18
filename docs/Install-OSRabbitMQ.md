---
external help file: OutSystems.SetupTools-help.xml
Module Name: Outsystems.SetupTools
online version:
schema: 2.0.0
---

# Install-OSRabbitMQ

## SYNOPSIS
Installs and configures RabbitMQ for OutSystems.

## SYNTAX

### __AllParameterSets (Default)
```
Install-OSRabbitMQ [-VirtualHosts <String[]>] [<CommonParameters>]
```

### AddAdminUser
```
Install-OSRabbitMQ [-VirtualHosts <String[]>] [-RemoveGuestUser] -AdminUser <PSCredential> [<CommonParameters>]
```

## DESCRIPTION
This will install and configure RabbitMQ for Outsystems.
It will use the default guest user to perform the RabbitMQ configuration.
It will skip the configuration and installation if RabbitMQ is already installed.

## EXAMPLES

### EXAMPLE 1
```
Install-OSRabbitMQ
```

### EXAMPLE 2
```
Install-OSRabbitMQ -VirtualHosts '/OutSystems'
```

### EXAMPLE 3
```
Install-OSRabbitMQ -VirtualHosts @('/OutSystems', '/AnotherHost')
```

### EXAMPLE 4
```
$user = Get-Credential
```

Install-OSRabbitMQ -VirtualHosts @('/OutSystems', '/AnotherHost') -AdminUser $user -RemoveGuestUser

### EXAMPLE 5
```
$user = New-Object System.Management.Automation.PSCredential ('superuser', $(ConvertTo-SecureString 'superpass' -AsPlainText -Force))
```

Install-OSRabbitMQ -VirtualHosts @('/OutSystems', '/AnotherHost') -AdminUser $user -RemoveGuestUser

## PARAMETERS

### -VirtualHosts
List of virtual hosts to add to RabbitMQ.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RemoveGuestUser
Removes the default guest user.

```yaml
Type: SwitchParameter
Parameter Sets: AddAdminUser
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -AdminUser
Add the specified user as admin of RabbitMQ.

```yaml
Type: PSCredential
Parameter Sets: AddAdminUser
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Outsystems.SetupTools.InstallResult

## NOTES
After uninstalling RabbitMQ you need to reboot the machine.
Some registry keys are only deleted after rebooting.
So in case you want to reinstall RabbitMQ, you need to uninstall, reboot and then you can rerun this cmdlet
RabbitMQ configuration is only done when installed.
Rerunning this CmdLet will not reconfigure RabbitMQ

## RELATED LINKS