param($w="15",$c="5")

$disk_used = Get-PSDrive C | Select-Object @{ E={$_.Used/1GB}; L='Used' } | select -ExpandProperty 'Used'
$disk_free = Get-PSDrive C | Select-Object @{ E={$_.Free/1GB}; L='Free' } | select -ExpandProperty 'Free'
$disk_total = [math]::Round($disk_used + $disk_free)

$disk_percent = [math]::Round(($disk_used / $disk_total) * 100)

# Edge cases (if for some reason disk percent is beyond what it should be)
if ($disk_percent -lt 0 -or $disk_percent -gt 100) {
	Write-Host "status=unknown,disk_usage=$disk_percent"
}

if ($disk_percent -le $w -and $disk_percent -gt $c){
	Write-Host "status=warn,disk_usage=$disk_percent"
	Exit 1
}
elseif ($disk_percent -le $c) {
	Write-Host "status=crit,disk_usage=$disk_percent"
	Exit 2
}
else {
	Write-Host "status=ok,diskusage=$disk_percent"
	Exit 0
}