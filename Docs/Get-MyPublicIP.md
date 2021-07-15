---
external help file: IPv4Toolbox-help.xml
Module Name: IPv4Toolbox
online version: http://www.github.com/roberttoups/IPv4Toolbox
schema: 2.0.0
---

# Get-MyPublicIP

## SYNOPSIS
Returns the Public IPv4 Address of the client returned by a web API.

## SYNTAX

```
Get-MyPublicIP [[-Uri] <String>] [<CommonParameters>]
```

## DESCRIPTION
Returns the Public IPv4 Address of the client returned by a web API.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------

```powershell
Get-MyPublicIP

8.8.8.8
```

### -------------------------- EXAMPLE 2 --------------------------

```powershell
Get-MyPublicIP -Uri 'http://icanhazip.com'

8.8.8.8
```

## PARAMETERS

### -Uri
This is the URI used to query the Public IPv4 Address.
Valid URIs are http://icanhazip.com, http://ident.me, http://ifconfig.me/ip, & http://ipinfo.io/ip.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: Https://ipinfo.io/ip
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.String
## NOTES
This function depends on the traffic reaching the web based API not flowing through a proxy for most accurate results.

## RELATED LINKS

[http://www.github.com/roberttoups/IPv4Toolbox](http://www.github.com/roberttoups/IPv4Toolbox)

