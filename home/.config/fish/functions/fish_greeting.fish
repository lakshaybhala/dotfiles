function fish_greeting
    command -v neofetch >/dev/null 2>&1
    if [ $status = 0 ]
        neofetch
    else
        echo
		echo -e (uname -sr | awk '{print " \\\\e[1mOS: \\\\e[0;32m"$0"\\\\e[0m"}')
		echo -e (guname -n | awk '{print " \\\\e[1mHostname: \\\\e[0;32m"$0"\\\\e[0m"}')
    end
end
