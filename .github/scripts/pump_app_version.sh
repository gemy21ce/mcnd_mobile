parse_yaml() {
  local prefix=$2
  # shellcheck disable=SC2155
  local s='[[:space:]]*' w='[a-zA-Z0-9_]*' fs=$(echo @ | tr @ '\034')
  sed -ne "s|^\($s\)\($w\)$s:$s\"\(.*\)\"$s\$|\1$fs\2$fs\3|p" \
    -e "s|^\($s\)\($w\)$s:$s\(.*\)$s\$|\1$fs\2$fs\3|p" $1 |
    awk -F$fs '{
      indent = length($1)/2;
      vname[indent] = $2;
      for (i in vname) {if (i > indent) {delete vname[i]}}
      if (length($3) > 0) {
         vn=""; for (i=0; i<indent; i++) {vn=(vn)(vname[i])("_")}
         printf("%s%s%s=\"%s\"\n", "'$prefix'",vn, $2, $3);
      }
   }'
}

#set -e

eval "$(parse_yaml pubspec.yaml "config_")"
# shellcheck disable=SC2154
versionNumber=$(echo "$config_version" | cut -d'+' -f 2)
versionDots=$(echo "$config_version" | cut -d'+' -f 1)
nextV=$((versionNumber + 1))
new_version=$(echo "$versionDots" | cut -d'.' -f 1).$(echo "$versionDots" | cut -d'.' -f 2).$nextV+$nextV

sed -i '' "s/$config_version/$new_version/g" pubspec.yaml

git add pubspec.yaml

git commit -m "[skip actions] Released Version: $new_version" || true
git tag -a v"$new_version" -m "V $new_version"
git push origin master
git push origin --tags
