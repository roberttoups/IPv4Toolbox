---
external help file: IPv4Toolbox-help.xml
Module Name: IPv4Toolbox
online version: http://www.github.com/roberttoups/IPv4Toolbox
schema: 2.0.0
---

# Out-SubnetRange

## SYNOPSIS
Outputs a list of IPv4 Addresses from a CIDR address range.

## SYNTAX

### Prefix (Default)
```
Out-SubnetRange [-Subnet] <String> [-Prefix <Int32>] [<CommonParameters>]
```

### SubnetMask
```
Out-SubnetRange [-Subnet] <String> -SubnetMask <String> [<CommonParameters>]
```

## DESCRIPTION
Outputs a list of IPv4 Addresses from a CIDR address range.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------

```powershell
Out-SubnetRange -Subnet 192.168.1.0 -Prefix 28

192.168.1.1
192.168.1.2
192.168.1.3
192.168.1.4
192.168.1.5
192.168.1.6
192.168.1.7
192.168.1.8
192.168.1.9
192.168.1.10
192.168.1.11
192.168.1.12
192.168.1.13
192.168.1.14
```

## PARAMETERS

### -Prefix
The Prefix of the IPv4 Address range

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

### -Subnet
The subnet id of the IPv4 Address range

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: IPv4Address

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -SubnetMask
The Subnet Mask of the IPv4 Address range

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

## NOTES
This function will output usable IP space.

## RELATED LINKS

[http://www.github.com/roberttoups/IPv4Toolbox](http://www.github.com/roberttoups/IPv4Toolbox)

