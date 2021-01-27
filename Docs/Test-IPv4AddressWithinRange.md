---
external help file: IPv4Toolbox-help.xml
Module Name: IPv4Toolbox
online version: http://www.github.com/roberttoups/IPv4Toolbox
schema: 2.0.0
---

# Test-IPv4AddressWithinRange

## SYNOPSIS
Evaluates if an IPv4 Address is equal or within an IPv4 Address range.

## SYNTAX

```
Test-IPv4AddressWithinRange [-FirstIPv4Address] <String> [-LastIPv4Address] <String>
 [-TestIPv4Address] <String> [<CommonParameters>]
```

## DESCRIPTION
Evaluates if an IPv4 Address is equal or within an IPv4 Address range.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------

```powershell
Test-IPv4AddressWithinRange -FirstIPv4Address '192.168.1.1' -LastIPv4Address '192.168.5.21' -TestIPv4Address '192.168.6.1'

False
```

### -------------------------- EXAMPLE 2 --------------------------

```powershell
Test-IPv4AddressWithinRange -FirstIPv4Address '192.168.1.1' -LastIPv4Address '192.168.1.50' -TestIPv4Address '192.168.1.20'

True
```

## PARAMETERS

### -FirstIPv4Address
The first IPv4 Address

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: StartingIpAddress

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LastIPv4Address
The last IPv4 Address

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: EndingIpAddress

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TestIPv4Address
The IPv4 Address to test

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: TestingIpAddress

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Boolean
## NOTES

## RELATED LINKS

[http://www.github.com/roberttoups/IPv4Toolbox](http://www.github.com/roberttoups/IPv4Toolbox)

