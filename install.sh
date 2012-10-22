echo $1
exit
git clone --depth 0 git://github.com/nickbarth/SinatraApp.git NEW_APP
cd $_
rm -rf .git
git init
