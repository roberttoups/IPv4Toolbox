---
external help file: IPv4Toolbox-help.xml
Module Name: IPv4Toolbox
online version: http://www.github.com/roberttoups/IPv4Toolbox
schema: 2.0.0
---

# Invoke-IPv4ListSort

## SYNOPSIS
Sorts an array of IPv4 Addresses.

## SYNTAX

```
Invoke-IPv4ListSort [[-IPv4AddressList] <String[]>] [-Descending] [<CommonParameters>]
```

## DESCRIPTION
Sorts an array of IPv4 Addresses.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------

```powershell
Invoke-IPv4ListSort -IPv4AddressList @('192.168.0.1','10.12.2.2','1.1.1.1','8.8.8.8')

1.1.1.1
8.8.8.8
10.12.2.2
192.168.0.1
```

### -------------------------- EXAMPLE 2 --------------------------

```powershell
Invoke-IPv4ListSort -IPv4AddressList @('192.168.0.1','10.12.2.2','1.1.1.1','8.8.8.8') -Descending

192.168.0.1
10.12.2.2
8.8.8.8
1.1.1.1
```

### -------------------------- EXAMPLE 3 --------------------------

```powershell
Invoke-IPv4ListSort -IPv4AddressList @('192.168.1.0/28','10.12.13.14/32','8.8.8.8','4.2.2.1','192.168.23.2/29','1.1.1.1')

1.1.1.1
4.2.2.1
8.8.8.8
10.12.13.14
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
192.168.23.1
192.168.23.2
192.168.23.3
192.168.23.4
192.168.23.5
192.168.23.6
```

## PARAMETERS

### -Descending
This switch will sort the IPv4 Addresses in reverse order

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -IPv4AddressList
The list of IPv4 Addresses

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
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

