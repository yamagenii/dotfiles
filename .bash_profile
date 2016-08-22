export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/bin:$PATH
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_40.jdk/Contents/Home
export LLVM_CONFIG=/usr/local/Cellar/llvm37/3.7.1/bin/llvm-config-3.7
PATH=/uer/libexec/java_home =1.8/bin:/usr/local/bin:/usr/local/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin

eval "$(rbenv init -)"

ias ctags="`brew --prefix`/bin/ctags"

echo "Elcapitan ルートレスぅぅぅぅぅぅぅぅぅぅぅぅ"

proxy_name=http://www-proxy.waseda.jp:8080
switch_trigger_shalab=Queen-Wireless

function set_proxy() {
	export http_proxy=$proxy_name
	export HTTP_PROXY=$proxy_name
	export ftp_proxy=$proxy_name
	export FTP_PROXY=$proxy_name
	export all_proxy=$proxy_name
	export ALL_PROXY=$proxy_name
	export https_proxy=$proxy_name
	export HTTPS_PROXY=$proxy_name
}
function unset_proxy() {
	unset http_proxy
	unset HTTP_PROXY
 	unset ftp_proxy
        unset FTP_PROXY
	unset all_proxy
	unset ALL_PROXY
	unset https_proxy
	unset HTTPS_PROXY
}
if [ "`networksetup -getairportnetwork  en0  | awk '{print $4}'`" = "$switch_trigger_shalab" ];
then
	echo "Switch to proxy for university network"
	set_proxy
else
	echo "Switch to non_proxy"
	unset_proxy
fi
