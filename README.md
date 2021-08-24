# ![IPv4Toolbox](icons/Color-small.png) IPv4Toolbox PowerShell Module

![Pester](https://github.com/roberttoups/IPv4Toolbox/workflows/Pester/badge.svg) ![License](https://img.shields.io/github/license/roberttoups/IPv4Toolbox) ![PowerShell Gallery](https://img.shields.io/powershellgallery/v/IPv4Toolbox) ![platform](https://img.shields.io/powershellgallery/p/IPv4Toolbox)

## Description

Module to simplify the manipulation, discovery, and testing of IPv4 Addresses.

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

## PowerShell Desired State Configuration Deployment

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

## Deployment for Air-Gapped Systems

1. Download the desired version of the module from the [Release Page](https://github.com/roberttoups/IPv4Toolbox/releases).
2. Copy the module to the desired location using the appropriate security controls.
3. Add the module to the PowerShell module.

### PowerShell Module Location

Depending on access to the module, your target module will be different. Below are methods for determining the location to copy the module.

```powershell
# Current User Profile on PowerShell 7
$env:PSModulePath.Split(':')[0]
# All Users Profile on PowerShell 7
$env:PSModulePath.Split(':')[1]

# Current User Profile on Windows PowerShell 3+
$env:PSModulePath.Split(';')[0]
# All Users Profile on Windows PowerShell 3+
$env:PSModulePath.Split(';')[1]

```

## What's New

### 0.7.0

- **BREAKING CHANGE:** The alias `-IPAddress` for `-IPv4Address` has been removed. It was inconsistently used in the module and interrupted autocomplete functionality. It was used on the following functions:
  - [Get-SubnetInformation](Docs/Get-SubnetInformation.md)
  - [Invoke-IPv4GeoLookup](Docs/Invoke-IPv4GeoLookup.md)
  - [Test-PrivateIPv4Address](Docs/Test-PrivateIPv4Address.md)
- Updated function parameter help to be more...helpful.
- Added [Test-IPv4AddressWithinSubnet](Docs/Test-IPv4AddressWithinSubnet.md) function
- Updated error handling for [Get-MyPublicIP](Docs/Get-MyPublicIP.md) so it will output `$null` on failure instead of throwing an error. Using the `-Verbose` switch will output the error message.

## Functions

### [ConvertFrom-InverseAddress](Docs/ConvertFrom-InverseAddress.md)

Converts an Inverse Address to either an IPv4 Address or Subnet in CIDR address format.

![ConvertFrom-InverseAddress](Examples/Graphics/ConvertFrom-InverseAddress.gif)

### [ConvertTo-InverseAddress](Docs/ConvertTo-InverseAddress.md)

Converts an IPv4 Address or Subnet into a Windows PTR Zone compatible domain name.

![ConvertTo-InverseAddress](Examples/Graphics/ConvertTo-InverseAddress.gif)

### [Find-IPv4Address](Docs/Find-IPv4Address.md)

Returns all valid IPv4 Addresses in a string.

![Find-IPv4Address](Examples/Graphics/Find-IPv4Address.gif)

### [Get-MyPublicIP](Docs/Get-MyPublicIP.md)

Returns the Public IPv4 Address of the client returned by a web API.

![Get-MyPublicIP](Examples/Graphics/Get-MyPublicIP.gif)

### [Get-SubnetInformation](Docs/Get-SubnetInformation.md)

Returns the information regarding a subnet that an IPv4 Address exists.

![Get-SubnetInformation](Examples/Graphics/Get-SubnetInformation.gif)

### [Invoke-IPv4GeoLookup](Docs/Invoke-IPv4GeoLookup.md)

Returns GeoIP Information for an IPv4 Address from [ip-api](https://ip-api.com).

![Invoke-IPv4GeoLookup](Examples/Graphics/Invoke-IPv4GeoLookup.gif)

### [Invoke-IPv4ListSort](Docs/Invoke-IPv4ListSort.md)

Sorts an array of IPv4 Addresses including CIDR address ranges.

![Invoke-IPv4ListSort](Examples/Graphics/Invoke-IPv4ListSort.gif)

### [Out-SubnetRange](Docs/Out-SubnetRange.md)

Outputs a list of IPv4 Addresses from a CIDR address range.

![Out-SubnetRange](Examples/Graphics/Out-SubnetRange.gif)

### [Split-Subnet](Docs/Split-Subnet.md)

Breaks up a larger CIDR into small CIDRs.

![Split-Subnet](Examples/Graphics/Split-Subnet.gif)

### [Test-IPv4Address](Docs/Test-IPv4Address.md)

Tests a string to determine if it is a valid IPv4 Address (0.0.0.0 to 255.255.255.255).

![Test-IPv4Address](Examples/Graphics/Test-IPv4Address.gif)

### [Test-IPv4AddressWithinRange](Docs/Test-IPv4AddressWithinRange.md)

Evaluates if an IPv4 Address is equal or within an IPv4 Address range.

![Test-IPv4AddressWithinRange](Examples/Graphics/Test-IPv4AddressWithinRange.gif)

### [Test-IPv4AddressWithinSubnet](Test-IPv4AddressWithinSubnet.md)

Evaluates if an IPv4 Address is within an IPv4 Subnet range.

### [Test-PrivateIPv4Address](Docs/Test-PrivateIPv4Address.md)

Determines if an IPv4 Address is in a private address space as defined by [RFC 1918](https://datatracker.ietf.org/doc/html/rfc1918) & [RFC 6598](https://datatracker.ietf.org/doc/html/rfc6598).

![Test-PrivateIPv4Address](Examples/Graphics/Test-PrivateIPv4Address.gif)

## License

IPv4Toolbox is provided under the [Apache license](LICENSE).

Authored by Robert M. Toups, Jr.
