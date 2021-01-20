![Pester](https://github.com/roberttoups/IPv4Toolbox/workflows/Pester/badge.svg) ![License](https://img.shields.io/github/license/roberttoups/IPv4Toolbox) ![Windows](https://img.shields.io/badge/OS-Windows-success) ![Linux](https://img.shields.io/badge/OS-Linux-success) ![macOS](https://img.shields.io/badge/OS-macOS-success)

# ![IPv4Toolbox](icons/Color-small.png) IPv4Toolbox PowerShell Module

## Description

Module to simplify the calculations associated to IPv4 addressing.

## How to Install from the PowerShell Gallery

```powershell
Install-Module -Name 'IPv4Toolbox' -Scope 'CurrentUser'
```

## Functions

### [ConvertTo-InverseAddress](Docs/ConvertTo-InverseAddress.md)

Converts an IPv4 Address or Subnet into Windows PTR Zone compatible domain name.

### [Get-SubnetInformation](Docs/Get-SubnetInformation.md)

Returns the information regarding a subnet that an IPv4 Address exists.

### [Invoke-IPv4GeoLookup](Docs/Invoke-IPv4GeoLookup.md)

Returns GeoIP Information from ip-api.com.

### [Invoke-IPv4ListSort](Docs/Invoke-IPv4ListSort.md)

Sorts an array of IPv4 Addresses include CIDR address ranges.

### [Out-SubnetRange](Docs/Out-SubnetRange.md)

Outputs a list of IPv4 Addresses from a CIDR address range.

### [Split-Subnet](Docs/Split-Subnet.md)

Breaks up a larger CIDR into small CIDRs.

### [Test-IPv4AddressWithinRange](Docs/Test-IPv4AddressWithinRange.md)

Evaluates if an IPv4 Address is equal or within an IPv4 Address range.

## License

IPv4Toolbox is provided under the [Apache license](LICENSE.md).

Authored by Robert M. Toups, Jr.
