---
external help file: IPv4Toolbox-help.xml
Module Name: IPv4Toolbox
online version:
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

### EXAMPLE 1
```
Invoke-IPv4ListSort -IPv4AddressList @('192.168.0.1','10.12.2.2','1.1.1.1','8.8.8.8')
```

1.1.1.1
8.8.8.8
10.12.2.2
192.168.0.1

### EXAMPLE 2
```
Invoke-IPv4ListSort -IPv4AddressList @('192.168.0.1','10.12.2.2','1.1.1.1','8.8.8.8') -Descending
```

192.168.0.1
10.12.2.2
8.8.8.8
1.1.1.1

## PARAMETERS

### -IPv4AddressList
The list of IPv4 Addresses

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Descending
This switch will sort the IPv4 Addresses in reverse order

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
