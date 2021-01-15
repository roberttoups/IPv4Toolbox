---
external help file: IPv4Toolbox-help.xml
Module Name: IPv4Toolbox
online version: http://www.github.com/roberttoups/IPv4Toolbox
schema: 2.0.0
---

# Get-SubnetInformation

## SYNOPSIS
Returns the information regarding a subnet that an IPv4 Address exists

## SYNTAX

### Prefix (Default)
```
Get-SubnetInformation -IPv4Address <String> [-Prefix <Int32>] [<CommonParameters>]
```

### SubnetMask
```
Get-SubnetInformation -IPv4Address <String> -SubnetMask <String> [<CommonParameters>]
```

## DESCRIPTION
Returns the information regarding a subnet that an IPv4 Address exists and returns information regarding Subnet ID, Broadcast Address, Subnet Mask, Network Prefix, First IP Address, Last IP Address, Total Hosts, and Total Class C addresses.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-SubnetInformation -IPv4Address 192.168.1.120 -Mask 255.255.254.0

SubnetId              : 192.168.0.0
BroadcastAddress      : 192.168.1.255
SubnetMask            : 255.255.254.0
Prefix                : 23
FirstIPv4Address      : 192.168.0.1
LastIPv4Address       : 192.168.1.254
TotalHosts            : 510
TotalClassCSubnets    : 2    
```

### EXAMPLE 2
```powershell
Get-SubnetInformation -Ipv4Address 192.168.1.120 -Prefix 16

SubnetId              : 192.168.0.0
BroadcastAddress      : 192.168.255.255
SubnetMask            : 255.255.0.0
Prefix                : 16
FirstIPv4Address      : 192.168.0.1
LastIPv4Address       : 192.168.255.254
TotalHosts            : 65534
TotalClassCSubnets    : 256    
```

## PARAMETERS

### -IPv4Address
The IPv4 Address

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: IPAddress

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Prefix
The network prefix

```yaml
Type: System.Int32
Parameter Sets: Prefix
Aliases:

Required: False
Position: Named
Default value: 24
Accept pipeline input: False
Accept wildcard characters: False
```

### -SubnetMask
{{ Fill SubnetMask Description }}

```yaml
Type: System.String
Parameter Sets: SubnetMask
Aliases: Mask

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Management.Automation.PSObject
## NOTES

## RELATED LINKS

[http://www.github.com/roberttoups/IPv4Toolbox](http://www.github.com/roberttoups/IPv4Toolbox)

