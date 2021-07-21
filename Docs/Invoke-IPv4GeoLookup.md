---
external help file: IPv4Toolbox-help.xml
Module Name: IPv4Toolbox
online version: http://www.github.com/roberttoups/IPv4Toolbox
schema: 2.0.0
---

# Invoke-IPv4GeoLookup

## SYNOPSIS
Returns GeoIP Information from ip-api.com.

## SYNTAX

```
Invoke-IPv4GeoLookup [-IPv4Address] <String> [<CommonParameters>]
```

## DESCRIPTION
Returns GeoIP Information from ip-api.com.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------

```powershell
Invoke-IPv4GeoLookup -IPv4Address 1.1.1.1

status       : success
country      : Australia
countryCode  : AU
region       : QLD
regionName   : Queensland
city         : South Brisbane
zip          : 4101
lat          : -27.4766
lon          : 153.0166
timezone     : Australia/Brisbane
isp          : Cloudflare, Inc
org          : APNIC and Cloudflare DNS Resolver project
as           : AS13335 Cloudflare, Inc.
query        : 1.1.1.1
mapReference : https://www.google.com/maps?q=-27.4766,153.0166
```

## PARAMETERS

### -IPv4Address
The non-RFC 1918 IPv4 Address to obtain the GeoIP information.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: IPAddress

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Do not use this function multiple times a second or you will be rate limited.

## RELATED LINKS

[http://www.github.com/roberttoups/IPv4Toolbox](http://www.github.com/roberttoups/IPv4Toolbox)

