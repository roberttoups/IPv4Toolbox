---
external help file: IPv4Toolbox-help.xml
Module Name: IPv4Toolbox
online version: http://www.github.com/roberttoups/IPv4Toolbox
schema: 2.0.0
---

# Test-PrivateIPv4Address

## SYNOPSIS
Determines if an IPv4 Address is in a private address space.

## SYNTAX

```
Test-PrivateIPv4Address [-IPv4Address] <String> [<CommonParameters>]
```

## DESCRIPTION
Determines if an IPv4 Address is in a private address space.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------

```powershell
Test-PrivateIPv4Address -IPv4Address 192.168.1.1

True
```

### -------------------------- EXAMPLE 2 --------------------------

```powershell
Test-PrivateIPv4Address -IPv4Address 8.8.8.8

False
```

## PARAMETERS

### -IPv4Address
The IPv4 Address

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

### System.Boolean
## NOTES
The function supports RFC 1918 & RFC 6598 address space.

## RELATED LINKS

[http://www.github.com/roberttoups/IPv4Toolbox](http://www.github.com/roberttoups/IPv4Toolbox)

