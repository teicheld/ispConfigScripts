function screamAndDie() {
	echo $1
	exit
}
function getWordpress() {
	[ ! -d /tmp/wordpress/ ] && curl https://wordpress.org/latest.zip > /tmp/wordpress.zip && unzip /tmp/wordpress.zip -d /tmp && rm -r /tmp/wordpress.zip || echo "taking lokal version of wordress in /tmp/wordpress..."
}
function getId() {
	user=$(ls -l | awk NR==2 | cut -d ' ' -f4)
	group=$(ls -l | awk NR==2 | cut -d ' ' -f5)
}
function getWebDir() {
	[ -d "/var/www/$1/web" ] && webDir="/var/www/$1/web" || screamAndDie "no dir at /var/www/$1/web/"
}
[ -z $1 ] && screamAndDie "provide the domainName"
getWordpress
getWebDir $1
read -p "cd $webDir?"
cd $webDir
getId
read -p "cp -rv /tmp/wordpress/* $webDir/?"
cp -rv /tmp/wordpress/* $webDir/
read -p "chown -R $user:$group .?"
chown -R $user:$group .
ls -l

