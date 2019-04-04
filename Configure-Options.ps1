<#
    Configure-Options
    Class structure for customer specific options
#>

class OptEnvironment {
    hidden [string]$ConfigFile = "OptionsEnvironment.json"
    [string]$HyperVServerName;
    [String]$HyperVServerUserName;
    [SecureString]$HyperVServerPassword;
    [string]$VMStoragePath;
    [string]$InternetVSwitch;
    [string]$RRASExternalIP;
    [byte]$RRASExternalPrefixLength;
    [string]$RRASExternalGatewayIP;
    OptEnvironment(){
        if (test-path -Path $this.ConfigFile -ErrorAction SilentlyContinue) {
            $temp = Get-Content -Path ".\$($this.ConfigFile)" | ConvertFrom-Json
            $this.load(
                $temp.HyperVServerName,
                $temp.HyperVServerUserName,
                $temp.HyperVServerPassword,
                $temp.VMStoragePath,
                $temp.InternetVSwitch,
                $temp.RRASExternalIP,
                $temp.RRASExternalPrefixLength,
                $temp.RRASExternalGatewayIP
            )
        }
    }
    [Void]Load($HyperVServerName,$HyperVServerUserName,[SecureString]$HyperVServerPassword,$VMStoragePath,$InternetVSwitch,$RRASExternalIP,$RRASExternalPrefixLength,$RRASExternalGatewayIP){
        $this.HyperVServerName=$HyperVServerName;
        $this.HyperVServerUserName = $HyperVServerUserName;
        $this.HyperVServerPassword = $HyperVServerPassword;
        $this.VMStoragePath=$VMStoragePath;
        $this.InternetVSwitch=$InternetVSwitch;
        $this.RRASExternalIP=$RRASExternalIP;
        $this.RRASExternalPrefixLength=$RRASExternalPrefixLength;
        $this.RRASExternalGatewayIP=$RRASExternalGatewayIP;
    }
    [Void]Save(){
        $this | ConvertTo-Json -Depth 100| Set-Content -Path ".\$($this.ConfigFile)" -Force
    }
}

$EnvironmentOptions=[OptEnvironment]::new()
$EnvironmentOptions.save()
$EnvironmentOptions=[OptEnvironment]::new()
$EnvironmentOptions

