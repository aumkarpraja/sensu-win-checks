# windows-resource-checks
## Usage
These checks are intended for use with Sensu Core 2.0, it follows the specifications for exit codes as well listed here.

https://docs.sensu.io/sensu-core/2.0/reference/checks/#check-scheduling

Each check has warning and critical flags that are configurable with the -w and -c flags passed into the Powershell script with defaults preset if you choose not to pass in those flags. The checks currently push out info to the Powershell console with a status and a percentage. 
