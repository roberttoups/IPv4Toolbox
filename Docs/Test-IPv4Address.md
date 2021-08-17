---
external help file: IPv4Toolbox-help.xml
Module Name: IPv4Toolbox
online version:
schema: 2.0.0
---

# Test-IPv4Address

## SYNOPSIS
Tests a string to determine if it is a valid IPv4 Address.

## SYNTAX

```
Test-IPv4Address [-IPv4Address] <String> [<CommonParameters>]
```

## DESCRIPTION
Tests a string to determine if it is a valid IPv4 Address (0.0.0.0 to 255.255.255.255).

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------

```powershell
Test-IPv4Address -IPv4Address 192.168.0.1

True
```

### -------------------------- EXAMPLE 2 --------------------------

```powershell
Test-IPv4Address -IPv4Address 192.apple.0.1

False
```

### -------------------------- EXAMPLE 3 --------------------------

```powershell
Test-IPv4Address -IPv4Address 192.256.0.1

False
```

## PARAMETERS

### -IPv4Address
The string to test if it is a valid IPv4 Address.

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

### System.Boolean
## NOTES
http://www.github.com/roberttoups/IPv4Toolbox

## RELATED LINKS
