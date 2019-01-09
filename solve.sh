#!/bin/bash

# Approach on solving https://www.profihost-karriere.de/hilf-tamara/

# Download and extract archive
wget -q https://www.profihost-karriere.de/wp-content/uploads/2018/12/hilf-tamara.zip
unzip -q hilf-tamara.zip

# Iterate over each file and check MD5 sum
for f in ./hilf-tamara/*; do
        _MD5=`md5sum $f`
        _MD5arr=($_MD5)
        if [ "${_MD5arr[0]}" = "994a97b3e1e85878aee2702b48549a37" ]; then
                echo "Found: 994a97b3e1e85878aee2702b48549a37 - $f"
                _KEY=$f
        elif [ "${_MD5arr[0]}" = "68f264d9a908f93e8ffea4fb8e77e799" ]; then
                echo "Found: 68f264d9a908f93e8ffea4fb8e77e799 - $f"
                _BIN=$f
        fi
done

# Decrypt file
_RESULT=`openssl rsautl -decrypt -inkey $_KEY -in $_BIN`

echo $_RESULT

# Cleanup
rm -rf hilf-tamara*