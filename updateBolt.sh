#!/bin/zsh

function getBoltVersion() {
  # Check that bolt has been installed via composer
  if [ ! -f vendor/bin/nut ]; then
    echo "Nut couldn't be found. Is bolt even installed here?"
    exit;
  fi

  boltV=$(php vendor/bin/nut -V --no-ansi | sed "s/.*version //g")
}

function runComposerUpdate () {
  composer update --prefer-dist -o
}

function commitTheChanges() {
  git add composer.lock extensions/composer.json
  git commit -m "[Composer] Bolt :arrow_up: v$boltV"
  git push

  # Check if we can push to prod
  # http://stackoverflow.com/a/23353971
  if git remote | grep prod > /dev/null; then
    git push prod
  fi
}

getBoltVersion;

currentV=$boltV

echo 'Bolt is currently at' $boltV;

runComposerUpdate;

getBoltVersion;

echo $currentV $boltV;

if [ "$currentV" = "$boltV" ];
then
  echo Bolt is at the latest version
else
  echo Bolt has been updated to the latest version, lets commit the composer.lock file
  commitTheChanges;
fi
