grails.project.class.dir = "target/classes"
grails.project.test.class.dir = "target/test-classes"
grails.project.test.reports.dir = "target/test-reports"
//grails.project.war.file = "target/${appName}-${appVersion}.war"
grails.project.dependency.resolution = {
    // inherit Grails' default dependencies
    inherits("global") {
        // uncomment to disable ehcache
        // excludes 'ehcache'
    }
    log "warn" // log level of Ivy resolver, either 'error', 'warn', 'info', 'debug' or 'verbose'
    repositories {
        grailsPlugins()
        grailsHome()
        grailsCentral()

        // uncomment the below to enable remote dependency resolution
        // from public Maven repositories
        //mavenLocal()
        //mavenCentral()
        //mavenRepo "http://snapshots.repository.codehaus.org"
        //mavenRepo "http://repository.codehaus.org"
        //mavenRepo "http://download.java.net/maven/2/"
        //mavenRepo "http://repository.jboss.com/maven2/"
    }
    plugins {
        build ":tomcat:$grailsVersion"

        compile ':commentable:0.8.1'
        compile ':searchable:0.6.4'
        compile ':rateable:0.7.0'
        compile ':mail:1.0'
        compile ':greenmail:1.2.2'
        compile ':spring-security-core:1.2.7.3'
        compile ':spring-security-ui:0.2'

        runtime ":hibernate:$grailsVersion"
        runtime ':jquery:1.6.1.1'
        runtime ':jquery-ui:1.8.11'
        runtime(':avatar:0.5.2') {excludes "spock"}
        runtime ':fckeditor:0.9.5'
        runtime ':famfamfam:1.0.1'
    }
    dependencies {
        // specify dependencies here under either 'build', 'compile', 'runtime', 'test' or 'provided' scopes eg.

        // runtime 'mysql:mysql-connector-java:5.1.13'

        compile('org.apache.poi:poi:3.8')
    }
}
