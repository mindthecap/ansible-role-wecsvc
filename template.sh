#!/bin/bash
cp ./files/palantir/wef-subscriptions/* ./files
sed -i 's/<Query Id="."/<Query Id="{{ query_count }}"/g' ./files/*.xml
sed -i -n '/<QueryList/,/<\/QueryList/ {//! p}' ./files/*.xml
sed -i 's/<Query Id="32"/<Query Id="{{ query_count }}"/g' ./files/*.xml
