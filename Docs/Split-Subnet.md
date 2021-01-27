---
external help file: IPv4Toolbox-help.xml
Module Name: IPv4Toolbox
online version: http://www.github.com/roberttoups/IPv4Toolbox
schema: 2.0.0
---

# Split-Subnet

## SYNOPSIS
Breaks up a larger CIDR into small CIDRs.

## SYNTAX

```
Split-Subnet [-Subnet] <String> [-Prefix] <Int32> [-TargetPrefix] <Int32> [<CommonParameters>]
```

## DESCRIPTION
Breaks up a larger CIDR into small CIDRs.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------

```powershell
Split-Subnet -Subnet 10.2.2.0 -Prefix 24 -TargetPrefix 25

SubnetId            : 10.2.2.0
BroadcastAddress    : 10.2.2.127
SubnetMask          : 255.255.255.128
Prefix              : 25
Subnet              : 10.2.2.0/25
FirstIPv4Address    : 10.2.2.1
LastIPv4Address     : 10.2.2.126
TotalHosts          : 126
AWSFirstIPv4Address : 10.2.2.4
AWSTotalHosts       : 123

SubnetId            : 10.2.2.128
BroadcastAddress    : 10.2.2.255
SubnetMask          : 255.255.255.128
Prefix              : 25
Subnet              : 10.2.2.128/25
FirstIPv4Address    : 10.2.2.129
LastIPv4Address     : 10.2.2.254
TotalHosts          : 126
AWSFirstIPv4Address : 10.2.2.132
AWSTotalHosts       : 123
```

## PARAMETERS

### -Prefix
The network prefix of the source CIDR

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Subnet
The Subnet Id to split

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: IPAddress, IPv4Address

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TargetPrefix
The network prefix to split the subnet into

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[http://www.github.com/roberttoups/IPv4Toolbox](http://www.github.com/roberttoups/IPv4Toolbox)

