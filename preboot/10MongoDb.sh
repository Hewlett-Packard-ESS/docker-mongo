#!/bin/bash
set +e
function sysconfig {
    {
		echo $2 > $1
	} 2> /dev/null
	if [ $? -eq 1 ]; then
		warn "Failed to set $1 to $2, are you running with --privileged?"
	fi
}

sysconfig "/sys/kernel/mm/transparent_hugepage/enabled" "never"
sysconfig "/sys/kernel/mm/transparent_hugepage/defrag" "never"
