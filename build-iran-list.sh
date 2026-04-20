#!/bin/sh

last=$(date -u)
url="https://stat.ripe.net/data/country-resource-list/data.json?resource=IR&v4_format=prefix"
filterv4='.data.resources.ipv4[]'
output=$(curl -s "$url")

echo "#Last update: $last"
echo "/ip firewall address-list remove [/ip firewall address-list find list=IRAN]"
echo "/ip firewall address-list"

echo "$output" | jq -r "$filterv4" | while read -r prefix; do
  echo ":do { add address=$prefix list=IRAN } on-error={}"
done
