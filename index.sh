
#!/usr/bin/env sh

_() {
  echo "What day do you want to travel back(YYYY-MM-DD): "
  read -r DATE
  echo "GitHub Username: "
  read -r USERNAME
  echo "GitHub Access token: "
  read -r ACCESS_TOKEN

  [ -z "$USERNAME" ] && exit 1
  [ -z "$ACCESS_TOKEN" ] && exit 1
  [ ! -d $DATE ] && mkdir $DATE

  cd "${DATE}" || exit
  git init
  echo "**${DATE}** - Generated by https://github.com/kricsleo/time-traveler-script" \
    >README.md
  git add .
  GIT_AUTHOR_DATE="${DATE}T18:00:00" \
  GIT_COMMITTER_DATE="${DATE}T18:00:00" \
  git commit -m "${DATE}"
  git remote add origin "https://${ACCESS_TOKEN}@github.com/${USERNAME}/${DATE}.git"
  git branch -M main
  git push -u origin main -f
  cd ..
  rm -rf "${DATE}"

  echo
  echo "Cool, check your profile now: https://github.com/${USERNAME}"
} && _

unset -f _
