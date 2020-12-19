#!/bin/sh

if [ $# != 1 ]; then
    echo "no project name!"
    exit 1
fi

project_name=$1

gradle init --type java-library \
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
#
.theia/**
.vscode/**
gradle/**
gradlew
gradlew.bat

' > ./.gitignore
gp init
echo '  - command: export TZ="Asia/Tokyo"' >> .gitpod.yml

rm lib/src/main/java/$project_name/*.java
rm lib/src/test/java/$project_name/*.java

mkdir -p lib/src/main/webapp/WEB-INF
mkdir -p lib/src/main/resources

touch lib/src/main/java/$project_name/.gitkeep
touch lib/src/main/webapp/WEB-INF/.gitkeep
touch lib/src/test/java/$project_name/.gitkeep
touch lib/src/test/resources/.gitkeep

touch lib/src/main/resources/application.properties


echo "plugins {
  id 'war'
  id 'org.gretty' version '3.0.3'
}

sourceCompatibility = '11'
targetCompatibility = '11'

compileJava.options.encoding = 'UTF-8'
compileTestJava.options.encoding = 'UTF-8'

repositories {
    jcenter()
}


dependencies {
    providedCompile 'javax.servlet:javax.servlet-api:4.0.1'

    compileOnly 'org.projectlombok:lombok:1.18.12'
	annotationProcessor 'org.projectlombok:lombok:1.18.12'
	
	testCompileOnly 'org.projectlombok:lombok:1.18.12'
	testAnnotationProcessor 'org.projectlombok:lombok:1.18.12'

    implementation 'org.apache.taglibs:taglibs-standard-impl:1.2.5'
    implementation 'javax.servlet.jsp.jstl:javax.servlet.jsp.jstl-api:1.2.1'
    // implementation 'mysql:mysql-connector-java:8.0.21'
    // implementation 'org.hibernate:hibernate-core:5.4.21.Final'

    // Use JUnit Jupiter API for testing.
    testImplementation 'org.junit.jupiter:junit-jupiter-api:5.6.2'

    // Use JUnit Jupiter Engine for testing.
    testRuntimeOnly 'org.junit.jupiter:junit-jupiter-engine'

}

tasks.named('test') {
    // Use junit platform for unit tests.
    useJUnitPlatform()
}

gretty {
    httpPort = 3000
    contextPath = '/'
}
" > lib/build.gradle

sed -e "s/include('lib')/include('$project_name')/g" settings.gradle > w
rm settings.gradle
mv w settings.gradle

mv lib $project_name
