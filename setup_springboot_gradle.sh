#!/bin/sh

if [ -z "$1" ]; then
    echo "no project name!"
    echo "usage: ./setup_sprinbgoot.sh [ProjectName] [packageName]"
    exit 1
fi

project_name=$1
package="com.example"
if [ -n "$2" ]; then
    package=$2
fi

gp init
echo '  - command: export TZ="Asia/Tokyo"' >> .gitpod.yml
sed -e "s/workspace-full/workspace-mysql/g" ./.gitpod.Dockerfile > work
mv ./work ./.gitpod.Dockerfile

curl https://start.spring.io/starter.zip -d type=gradle-project \
    -d bootVersion=2.4.1 \
    -d javaVersion=11 \
    -d language=java \
    -d packaging=jar \
    -d name=$project_name \
    -d artifactId=$project_name \
    -d groupId=$package \
    -d packageName=$package.$project_name \
    -d baseDir=backend \
    -d dependencies=data-jpa,devtools,lombok,mysql -o backend.zip

unzip backend.zip
rm backend.zip
