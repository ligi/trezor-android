#!/bin/bash
CURDIR=$(pwd)

cd $CURDIR/../trezor-firmware/common/protob

for i in messages messages-common messages-ethereum ; do
    protoc --java_out=$CURDIR/trezor-lib/src/main/java -I/usr/include -I. $i.proto
done

# add version
PROTOC_VER=$(protoc --version)
PROTOB_REV=$(git rev-parse HEAD)
sed -i "3i// $PROTOC_VER\n// trezor-common $PROTOB_REV" $CURDIR/trezor-lib/src/main/java/com/satoshilabs/trezor/lib/protobuf/*.java
