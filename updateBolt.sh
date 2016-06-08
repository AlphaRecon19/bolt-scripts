#!/bin/zsh

function getBoltVersion() {
  boltV=$(php vendor/bin/nut -V --no-ansi | sed "s/.*version //g")
}

getBoltVersion;

currentV=$boltV

echo 'Bolt is currently at' $boltV;

composer update --no-interaction;

getBoltVersion;

echo $currentV $boltV;

if [ "$currentV" = "$boltV" ];
then
  echo Bolt is at the latest version
else
  echo Bolt has been updated to the latest version, lets commit the composer.lock file
fi