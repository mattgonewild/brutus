#!/bin/bash

if [ "$#" -ne 1 ]; then
    exit 1
fi

if [ ! -f "$1/proto/message.proto" ]; then
    exit 1
fi

mkdir -p ~/.local/include/brutus/proto
ln -sf "$1/proto/message.proto" ~/.local/include/brutus/proto/message.proto

for dir in $(find "$1" -type d); do
    if ls $dir/*.proto > /dev/null 2>&1; then
        cd $dir > /dev/null 2>&1
        if [ -f "$dir/message.proto" ]; then
            protoc --go_out=./go --go_opt=paths=source_relative --dart_out=grpc:./dart/lib/src *.proto
            git add ./go/*.go ./dart/lib/src/*.dart ./dart/lib/src/google/protobuf/*.dart
            awk -F. -v OFS=. '/^version: /{$NF++;print;next}1' ./dart/pubspec.yaml > temp && mv temp ./dart/pubspec.yaml
            git add ./dart/pubspec.yaml
        else
            protoc --go_out=. --go_opt=paths=source_relative --go-grpc_out=. --go-grpc_opt=paths=source_relative *.proto
            git add ./*.go
        fi
        cd - > /dev/null 2>&1
    fi
done

git commit -m 'feat(brutus): update proto files

done via brutus-protoc-helper.sh'

git push -u origin master

go get -u ./...
find . -name go.mod -execdir go mod tidy \;

cd ./dash > /dev/null 2>&1
dart pub upgrade
cd - > /dev/null 2>&1

find . -name 'pubspec.yaml' -o -name 'pubspec.lock' -o -name 'go.mod' -o -name 'go.sum' | xargs git add -u
git commit -m 'chore(brutus): update dependencies

done via brutus-protoc-helper.sh'

git push -u origin master
