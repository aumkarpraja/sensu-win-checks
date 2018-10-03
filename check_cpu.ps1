param($w="80",$c="90")

$cpu_usage = (Get-WmiObject win32_processor | Measure-Object -property LoadPercentage -Average | Select -ExpandProperty Average)

# Edge cases (if for some reason disk percent is beyond what it should be)
if ($cpu_usage -lt 0 -or $cpu_usage -gt 100) {
	Write-Host "UNKNOWN: $cpu_usage%"
}

if ($cpu_usage -ge $w -and $cpu_usage -lt $c){
	Write-Host "WARN: $cpu_usage%"
	Exit 1
}
elseif ($cpu_usage -ge $c) {
	Write-Host "CRIT: $cpu_usage%"
	Exit 2
}
else {
	Write-Host "OK: $cpu_usage%"
	Exit 0
}