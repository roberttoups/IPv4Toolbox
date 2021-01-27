---
external help file: IPv4Toolbox-help.xml
Module Name: IPv4Toolbox
online version: http://www.github.com/roberttoups/IPv4Toolbox
schema: 2.0.0
---

# ConvertTo-InverseAddress

## SYNOPSIS
Converts an IPv4 Address or Subnet into Windows PTR Zone compatible domain name.

## SYNTAX

### IPv4Address (Default)
```
ConvertTo-InverseAddress [[-IPv4Address] <String[]>] [<CommonParameters>]
```

### Subnet
```
ConvertTo-InverseAddress [-Subnet] <String> [-Prefix] <Int32> [<CommonParameters>]
```

## DESCRIPTION
Converts an IPv4 Address or Subnet into Windows PTR Zone compatible domain name.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------

```powershell
ConvertTo-InverseAddress -IPv4Address '192.168.1.1'

1.1.168.192.in-addr.arpa
```

### -------------------------- EXAMPLE 2 --------------------------

```powershell
ConvertTo-InverseAddress -Subnet '10.2.2.0' -Prefix 22

0.2.10.in-addr.arpa
1.2.10.in-addr.arpa
2.2.10.in-addr.arpa
3.2.10.in-addr.arpa
```

## PARAMETERS

### -IPv4Address
IPv4 Address to convert to an inverse address

```yaml
Type: System.String[]
Parameter Sets: IPv4Address
Aliases:

Required: False
Position: 1
Default value: 127.0.0.1
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Prefix
The subnet prefix for the subnet to convert to an inverse address

```yaml
Type: System.Int32
Parameter Sets: Subnet
Aliases:

Required: True
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Subnet
The subnet id to convert to an inverse address

```yaml
Type: System.String
Parameter Sets: Subnet
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.String[]
## NOTES

## RELATED LINKS

[http://www.github.com/roberttoups/IPv4Toolbox](http://www.github.com/roberttoups/IPv4Toolbox)

