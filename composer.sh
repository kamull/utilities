
expected=$(wget -q -O - https://composer.github.io/installer.sig)
wget -q -O "composer-setup.php" https://getcomposer.org/installer
actual=$(php -r "echo hash_file('SHA384', 'composer-setup.php');")

if [ "$expected" != "$actual" ]
then
    >&2 echo 'ERROR: Invalid installer signature'
    rm -f composer-setup.php
    exit 1
fi

php composer-setup.php --quiet --install-dir=/bin --filename=composer

result=$?
rm -f composer-setup.php
exit $result