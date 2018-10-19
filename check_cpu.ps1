param($w="80",$c="90")

$cpu_usage = (Get-WmiObject win32_processor | Measure-Object -property LoadPercentage -Average | Select -ExpandProperty Average)
$time_var = "$(([DateTimeOffset](Get-Date)).ToUnixTimeMilliseconds())000000"
# Edge cases (if for some reason disk percent is beyond what it should be)
if ($cpu_usage -lt 0 -or $cpu_usage -gt 100) {
	Write-Host "cpu,status=UNKNOWN,cpu_usage=$cpu_usage $time_var"
}

if ($cpu_usage -ge $w -and $cpu_usage -lt $c){
	Write-Host -NoNewline "cpu,status=warn,cpu_usage=$cpu_usage $time_var"
	Exit 1
}
elseif ($cpu_usage -ge $c) {
	Write-Host -NoNewline "cpu,status=crit,cpu_usage=$cpu_usage $time_var"
	Exit 2
}
else {
	Write-Host -NoNewline "cpu,status=ok,cpu_usage=$cpu_usage $time_var"
	Exit 0
}