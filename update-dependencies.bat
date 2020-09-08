git pull origin master
git commit -m "[BEGIN] Updating dependency cwRuntime"
git subtree pull --prefix src/dependencies/cwRuntime https://github.com/chapmanworld/cwRuntime.git master --squash
git commit -m "[END] Updating dependency cwRuntime"
git push