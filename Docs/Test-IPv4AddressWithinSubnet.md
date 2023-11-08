---
external help file: IPv4Toolbox-help.xml
Module Name: IPv4Toolbox
online version: http://www.github.com/roberttoups/IPv4Toolbox
schema: 2.0.0
---

# Test-IPv4AddressWithinSubnet

## SYNOPSIS
Evaluates if an IPv4 Address is within an IPv4 Subnet range.

## SYNTAX

### Prefix
```
Test-IPv4AddressWithinSubnet [-TestIPv4Address] <String> [-IPv4Address] <String> [-Prefix] <Int32>
 [<CommonParameters>]
```

### CIDR
```
Test-IPv4AddressWithinSubnet [-TestIPv4Address] <String> -CIDR <String> [<CommonParameters>]
```

## DESCRIPTION
Evaluates if an IPv4 Address is within an IPv4 Subnet range.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------

```powershell
Test-IPv4AddressWithinSubnet -TestIPv4Address '192.168.1.1' -IPv4Address '192.168.1.0' -Prefix 24
True
```

### -------------------------- EXAMPLE 2 --------------------------

```powershell
Test-IPv4AddressWithinSubnet -TestIPv4Address '10.1.1.1' -IPv4Address '192.168.0.0' -Prefix 16
False
```

### -------------------------- EXAMPLE 3 --------------------------

```powershell
Test-IPv4AddressWithinSubnet -TestIPv4Address '10.1.1.1' -CIDR 192.168.0.0/16
False
```

## PARAMETERS

### -CIDR
The CIDR address representing the Subnet.

```yaml
Type: System.String
Parameter Sets: CIDR
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IPv4Address
The IPv4 Address of the Subnet ID or a IPv4 Address within the range of the Subnet.

```yaml
Type: System.String
Parameter Sets: Prefix
Aliases: Subnet

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Prefix
The prefix length of the Subnet.

```yaml
Type: System.Int32
Parameter Sets: Prefix
Aliases:

Required: True
Position: 3
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -TestIPv4Address
The IPv4 Address to test for within the subnet range.

```yaml
Type: System.String
Parameter Sets: (All)
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

### System.Boolean
## NOTES

## RELATED LINKS

[http://www.github.com/roberttoups/IPv4Toolbox](http://www.github.com/roberttoups/IPv4Toolbox)
