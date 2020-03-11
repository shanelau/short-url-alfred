#!/bin/bash
query=$1

TOKEN=$suoAPI

urlencode() {
  local length="${#1}"
  for (( i = 0; i < length; i++ )); do
    local c="${1:i:1}"
    case $c in
      [a-zA-Z0-9.~_-]) printf "$c" ;;
    *) printf "$c" | xxd -p -c1 | while read x;do printf "%%%s" "$x";done
  esac
done
}
reqUrl=$(urlencode $query)
url='http://suo.im/api.htm?format=json&url='$reqUrl'&key='$TOKEN'&expireDate=2120-03-31'

curl -i -H "Accept: application/json" -H "Content-Type: application/json" -X GET $url | awk -F "," '{print $2}' | awk -F \" '{printf $4}'
