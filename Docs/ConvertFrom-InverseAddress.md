---
external help file: IPv4Toolbox-help.xml
Module Name: IPv4Toolbox
online version: http://www.github.com/roberttoups/IPv4Toolbox
schema: 2.0.0
---

# ConvertFrom-InverseAddress

## SYNOPSIS
Converts an Inverse Address to either an IPv4 Address or Subnet in CIDR address format.

## SYNTAX

```
ConvertFrom-InverseAddress [-InverseAddress] <String> [<CommonParameters>]
```

## DESCRIPTION
Converts an Inverse Address to either an IPv4 Address or Subnet in CIDR address format.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------

```powershell
ConvertFrom-InverseAddress -InverseAddress '12.0.12.10.in-addr.arpa'

10.12.0.12
```

### -------------------------- EXAMPLE 2 --------------------------

```powershell
ConvertFrom-InverseAddress -InverseAddress '0.12.10.in-addr.arpa'

10.12.0.0/24
```

## PARAMETERS

### -InverseAddress
The Inverse Address to convert to IPv4 Address or CIDR format.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

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

## RELATED LINKS

[http://www.github.com/roberttoups/IPv4Toolbox](http://www.github.com/roberttoups/IPv4Toolbox)

