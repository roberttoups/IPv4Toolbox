---
external help file: IPv4Toolbox-help.xml
Module Name: IPv4Toolbox
online version: http://www.github.com/roberttoups/IPv4Toolbox
schema: 2.0.0
---

# Find-IPv4Address

## SYNOPSIS
Returns all valid IPv4 Address in a string.

## SYNTAX

```
Find-IPv4Address [[-Text] <String[]>] [<CommonParameters>]
```

## DESCRIPTION
Find-IPv4Address will search a block of text for IPv4 Addresses and returns only the IPv4 Addresses found.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------

```powershell
Find-IPv4Address -Text 'Mary had little lamb 192.168.1.1 who fleece was white as snow, 127.0.0.1.'

192.168.1.1
127.0.0.1
```

### -------------------------- EXAMPLE 2 --------------------------

```powershell
cat /var/log/fail2ban.log | Find-IPv4Address | Sort-Object -Property @{Expression = { $_ -as [System.Version] } } -Unique

2.90.110.124
14.184.248.97
14.186.84.158
27.147.226.173
37.144.205.31
39.59.34.40
41.228.238.217
...
```

## PARAMETERS

### -Text
The block of text to discover IPv4 Addresses

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.String[]
## NOTES
The body of text provided to the Text parameter can be multi-line.
The function will only return valid IPv4 Addresses from 0.0.0.0 to 255.255.255.255.

## RELATED LINKS

[http://www.github.com/roberttoups/IPv4Toolbox](http://www.github.com/roberttoups/IPv4Toolbox)

