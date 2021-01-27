---
external help file: IPv4Toolbox-help.xml
Module Name: IPv4Toolbox
online version: http://www.github.com/roberttoups/IPv4Toolbox
schema: 2.0.0
---

# Get-SubnetInformation

## SYNOPSIS
Returns the information regarding a subnet that an IPv4 Address exists

## SYNTAX

### Prefix (Default)
```
Get-SubnetInformation -IPv4Address <String> [-Prefix <Int32>] [-NoPrivateAddressSpace] [<CommonParameters>]
```

### SubnetMask
```
Get-SubnetInformation -IPv4Address <String> -SubnetMask <String> [<CommonParameters>]
```

## DESCRIPTION
Returns the information regarding a subnet that an IPv4 Address exists and returns information regarding Subnet ID, Broadcast Address, Subnet Mask, Network Prefix, First IP Address, Last IP Address, Total Hosts, and AWS related information.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------

```powershell
Get-SubnetInformation -IPv4Address 192.168.1.120 -SubnetMask 255.255.254.0

SubnetId            : 192.168.0.0
BroadcastAddress    : 192.168.1.255
SubnetMask          : 255.255.254.0
Prefix              : 23
Subnet              : 192.168.0.0/23
FirstIPv4Address    : 192.168.0.1
LastIPv4Address     : 192.168.1.254
TotalHosts          : 510
AWSFirstIPv4Address : 192.168.0.4
AWSTotalHosts       : 507
PrivateAddressSpace : True
```

### -------------------------- EXAMPLE 2 --------------------------

```powershell
Get-SubnetInformation -IPv4Address 8.8.0.0 -Prefix 21

SubnetId            : 8.8.0.0
BroadcastAddress    : 8.8.7.255
SubnetMask          : 255.255.248.0
Prefix              : 21
Subnet              : 8.8.0.0/21
FirstIPv4Address    : 8.8.0.1
LastIPv4Address     : 8.8.7.254
TotalHosts          : 2046
AWSFirstIPv4Address :
AWSTotalHosts       :
PrivateAddressSpace : False
```

### -------------------------- EXAMPLE 3 --------------------------

```powershell
Get-SubnetInformation -IPv4Address 10.0.0.0 -Prefix 12

SubnetId            : 10.0.0.0
BroadcastAddress    : 10.15.255.255
SubnetMask          : 255.240.0.0
Prefix              : 12
Subnet              : 10.0.0.0/12
FirstIPv4Address    : 10.0.0.1
LastIPv4Address     : 10.15.255.254
TotalHosts          : 1048574
AWSFirstIPv4Address :
AWSTotalHosts       :
PrivateAddressSpace : True
```

### -------------------------- EXAMPLE 4 --------------------------

```powershell
Get-SubnetInformation -IPv4Address 10.0.0.0 -Prefix 28 -NoPrivateAddressSpace

SubnetId            : 10.0.0.0
BroadcastAddress    : 10.0.0.15
SubnetMask          : 255.255.255.240
Prefix              : 28
Subnet              : 10.0.0.0/28
FirstIPv4Address    : 10.0.0.1
LastIPv4Address     : 10.0.0.14
TotalHosts          : 14
AWSFirstIPv4Address :
AWSTotalHosts       :
PrivateAddressSpace :
```

## PARAMETERS

### -IPv4Address
The IPv4 Address

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: IPAddress

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -NoPrivateAddressSpace
This switch omits the reporting of Private Address Space for the subnet and any associated AWS information

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: Prefix
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Prefix
The network prefix

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

### -SubnetMask
The subnet mask of the network

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

### System.Management.Automation.PSObject
## NOTES
This function will only return results for AWS if the subnet has a prefix greater or equal to 16 and less than or
equal 28 and resides in the Private Address Space.

## RELATED LINKS

[http://www.github.com/roberttoups/IPv4Toolbox](http://www.github.com/roberttoups/IPv4Toolbox)

