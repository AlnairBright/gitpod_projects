#!/bin/sh

if [ $# != 1 ]; then
    echo "no project name!"
    exit 1
fi

project_name=$1
gp init
echo '  - command: export TZ="Asia/Tokyo"' >> .gitpod.yml

gradle init     --type  java-application \
                --dsl groovy \
                --project-name $project_name \
                --package $project_name \
                --test-framework junit-jupiter

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

touch app/src/main/java/$project_name/.gitkeep
touch app/src/main/resources/.gitkeep
touch app/src/test/java/$project_name/.gitkeep
touch app/src/test/resources/.gitkeep
