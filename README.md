# ![IPv4Toolbox](icons/Color-small.png) IPv4Toolbox PowerShell Module

![Pester](https://github.com/roberttoups/IPv4Toolbox/workflows/Pester/badge.svg) ![License](https://img.shields.io/github/license/roberttoups/IPv4Toolbox) ![PowerShell Gallery](https://img.shields.io/powershellgallery/v/IPv4Toolbox) ![platform](https://img.shields.io/powershellgallery/p/IPv4Toolbox)

## Description

Module to simplify the calculations associated to IPv4 addressing.

## How to deploy from the PowerShell Gallery

### [PowerShell Gallery Package Information](https://www.powershellgallery.com/packages/IPv4Toolbox)

### Install

```powershell
Install-Module -Name 'IPv4Toolbox' -Scope 'CurrentUser'
```

### Update

```powershell
Update-Module -Name 'IPv4Toolbox' -Scope 'CurrentUser'
```

### PowerShell Desired State Configuration

The PackageManagement module should be at least version 1.1.7.0 for the following property information to be correct.

```powershell
PackageManagementSource PSGallery {
    Ensure             = 'Present'
    Name               = 'PSGallery'
    ProviderName       = 'PowerShellGet'
    SourceLocation     = 'https://www.powershellgallery.com/api/v2'
    InstallationPolicy = 'Trusted'
}

PackageManagement IPv4Toolbox {
    Ensure             = 'Present'
    Name               = 'IPv4Toolbox'
    Source             = 'PSGallery'
    DependsOn          = '[PackageManagementSource]PSGallery'
}
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

### [Test-PrivateIPv4Address](Docs/Test-PrivateIPv4Address.md)

Determines if an IPv4 Address is in a private address space.

## License

IPv4Toolbox is provided under the [Apache license](LICENSE.md).

Authored by Robert M. Toups, Jr.
