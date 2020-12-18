#!/bin/sh

if [ $# != 1 ]; then
    echo "no project name!"
    exit 1
fi

project_name=$1

touch .gitignore
echo '# Java
*.class
*.jar
*.war
*.ear
# Eclipse
.project
.classpath
.settings
# Idea
.idea
*.iml
*.iws
*.ipr
# OS
Thumbs.db
.DS_Store
# Gradle
.gradle
!gradle-wrapper.jar
# Maven
target
# Build
out
build
bin
# Other
*.log
*.swp
*.bak
' > ./.gitignore
gp init
echo '  - command: export TZ="Asia/Tokyo"' >> .gitpod.yml
mvn archetype:generate   -DinteractiveMode=false \
                         -DarchetypeGroupId=org.graphast \
                         -DarchetypeArtifactId=servlet31-archetype-webapp \
                         -DarchetypeVersion=1.0.11 \
                         -DgroupId=com.example \
                         -DartifactId=$project_name \
                         -Dversion=0.0.1-SNAPSHOT \
                         -Dpackage=$project_name \
                         -Dpackaging=war

rm $project_name/src/main/webapp/WEB-INF/web.xml
rm $project_name/src/main/java/Hello.java 

mkdir -p $project_name/src/main/java/$project_name
mkdir -p $project_name/src/test/java/$project_name

touch $project_name/src/main/java/$project_name/.gitkeep
touch $project_name/src/main/webapp/WEB-INF/.gitkeep
touch $project_name/src/test/java/$project_name/.gitkeep

touch $project_name/src/main/resources/application.properties

sed -e "s/<source>1.7/<source>1.8/g" $project_name/pom.xml  | sed -e "s/<target>1.7/<target>1.8/g" > $project_name/pom1.xml
rm $project_name/pom.xml
mv $project_name/pom1.xml $project_name/pom.xml
