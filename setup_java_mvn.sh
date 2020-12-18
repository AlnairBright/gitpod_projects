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
                         -DarchetypeGroupId=pl.org.miki \
                         -DarchetypeArtifactId=java8-quickstart-archetype \
                         -DgroupId=com.example \
                         -DartifactId=$project_name \
                         -Dversion=0.0.1-SNAPSHOT \
                         -Dpackage=$project_name \
                         -Dpackaging=jar


mkdir -p $project_name/src/main/java/$project_name
mkdir -p $project_name/src/test/java/$project_name

touch $project_name/src/main/java/$project_name/.gitkeep
touch $project_name/src/test/java/$project_name/.gitkeep
