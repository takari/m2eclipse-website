---
layout: m2e-docs
title:  FAQ
---

# FAQ (we know this needs to be updated)

## Unable to Locate the Javac Compiler Error

Some users reported the following error that happens when importing Maven projects or when invoking "Update Sources" action.

```
6/25/07 1:15:44 PM CDT: ERROR mojo-execute : compiler:compile : Compilation failure
Unable to locate the Javac Compiler in:
C:Program FilesJavaj2re1.4.2_14..libtools.jar
Please ensure you are using JDK 1.4 or above and
not a JRE (the com.sun.tools.javac.Main class is required).
In most cases you can change the location of your Java
installation by setting the JAVA_HOME environment variable.
```

That happens because those actions runs in the same JVM where Eclipse is running. If that JVM comes from JRE that isn't part of JDK, there is no
Java compiler (the tools.jar) around. To workaround this you can add `-vm` argument to Eclipse command line or eclipse.ini. For Eclipse 3.3 it would look something like this:

```
-showsplash
org.eclipse.platform
--launcher.XXMaxPermSize
256m
-vm
C:\jdk1.6.0\bin\javaw.exe
-vmargs
-Xms40m
-Xmx256m
```

Alternatively you could specify compilerId in the pom.xml, so Maven won't be looking for the JDK when compiling Java code:

```
<plugin>
  <artifactid>maven-compiler-plugin</artifactid>
  <configuration>
    <compilerid>eclipse</compilerid>
  </configuration>
  <dependencies>
    <dependency>
      <groupid>org.codehaus.plexus</groupid>
      <artifactid>plexus-compiler-eclipse</artifactid>
      <version>xxxx</version>
    </dependency>
  </dependencies>
</plugin>
```

Also note that to launch Maven from within Eclipse, JRE used for launch also need to come from JDK. By default Eclipse registers JRE it is
started in, but this can be configured on "Window / Preferences / Java / Installed JREs" preference page.

## Compilation errors on restricted classes

Projects using classes from `rt.jar`, such as `com.sun.*` (and some others) can have compilation errors like: "Access restriction: The type
RE is not accessible due to restriction on required library <jrepath>/lib/rt.jar". Such errors indicate use of non-API classes and those access rules are defined by Eclipse JDT.

You can change compiler settings to not fail on those restrictions in workspace settings in Window / Preferences / Java / Compiler /
Errors/Warnings / Deprecated and restricted API / Forbidden reference (access rules) / Warnings; or per-project from Project / Properties / Java Compiler / Errors/Warnings / Deprecated and restricted API / Forbidden reference (access rules) / Warnings

## How to Configure Proxy and Location of Maven local Repository

M2Eclipse is using Maven `settings.xml` for proxy, local repository location and any other environment-specific configuration. This way we can use same settings between the command line and the IDE.

Default location of the `settings.xml` is at `~/.m2/settings.xml`, but you can also specify location of the global settings, i.e. one in `<maven home>/conf/settings.xml`

## Why do Resource Folders in Java Project Have `excluded="*"`

Many users are confused that when Java project is configured in Eclipse, resource folders gets `excluded="*"`. This is done intentionally, because those resources are processed by the "Maven Builder" registered to the project. This builder provides special resource handling, that includes filtering, as well as execution of other Maven plugins for processing resources. See Maven build lifecycle for more details.

If you manually remove resource exclusion, JDT will copy resources and overwrite filtered resources generated by Maven plugins.

Actually project resource folder doesnât really need to be added to the buildpath (Maven Builder is going to work without it), but it been considered convenient and look better in the Package Explorer and other Eclipse views.

Also note, that classpath used for JUnit and Java Application launch configurations for projects that have Maven support enabled is also calculated in a special way and excluded resources does not affect it either.

## Why Generated Source Folders are not Added to the Classpath

Maven plugins used to generate source code from resources or other sources can register additional source folders to Maven project during the build. Usually such plugins are bound to `process-resources` (or `process-test-resources`) build phase (for example jaxb, modello or xdoclet plugins). This means that to get those source folders for generated sources, we have to run corresponding Maven build phase.

Not all projects using generated sources, so for performance reasons, M2Eclipse does not run any Maven goals by default on project import. This can be changed in the Maven settings in "Window / Preferences / Maven / Goals to run on project import" (e.g. you can specify "process-resources" build phase or specific plugins in that field).

Alternatively you can run "Maven / Update project configuration" action from the project popup menu, which is configured to run "process-resources" by default and it can be also changed on the same preference page.

## Why projects are renamed on import

When projects are imported directly into Eclipse workspace folder, the
project name should match folder name. It is not an issue if you specify
an alternative location for those projects.

Also, by default, Maven project import/checkout is using project name template like [artifactId]. You can specify alternative name template in
Advanced section of the project import wizards (e.g. you can use [artifactId]-[version] template). Note that you need to make sure that artifact versions are different between those projects, or else dependency resolver will get really confused.

## Why does M2Eclipse checkout Maven projects as "maven.NNNNNNNN"?

The Maven project checkout is based on generic Maven SCM API (which supports number of SCM providers out of the box) and we don't have any information about Maven projects before the actual checkout (e.g. we don't know if folder or project names are going to be conflicting). There are two scenarios:

1.  the root checked out folder has pom.xml
2.  the checked out folder has number of projects without pom.xml at the root

The second scenario could happen when there is several projects located at selected SCM URL or when user selected multiple SCM URLs, e.g. using one of the available SCM UI integrations (CVS, Subclipse, etc).

In the first case the checkout folder will be renamed to match the result Eclipse project name for the Maven pom.xml and in the first case folder stays with "maven.NNNNNNNN" name. It is not clear if it is always possible to move checkout folder around for all SCMs (e.g. because of the SCM metadata).

Also see [Why projects are renamed on import](#Why_projects_are_renamed_on_import "wikilink")

## How to Connect to HTTPS Repositories

The Maven howto describes how to configure Maven to work with https repositories. To make the same properties work in Eclipse they need to be specified in two additional places:

1.  to make in-process Maven use them (e.g. on project import or "Maven / Update project configuration" actions) add them to -vmargs section in eclipse.ini or to Eclipse command line

2.  to make Maven launch configuration use them use "Window / Preferences / Java / Installed JREs / Edit / Default VM arguments"

To make both Maven cli and Eclipse use the preferences they would need to come from the Mavenâs settings.xml, but that would require changes in the Maven itself.

## Miscellaneous

## How Search Works

Dependency search is using local index for Maven repositories:

-   indexes for remote Maven repositories, such as Central repository,
    can be downloaded from remote repositories if they publish index
    created using Nexus Indexer tool or if repository is managed by
    Nexus repository manager
-   indexes for remote Maven repositories can be also packaged as
    Eclipse plugin and installed using Eclipse Update manager.
-   index for a Local Maven repository is updated incrementally when
    plugin downloads jars from any remote repositories. Local repository
    can be also reindexed from Window / Preferencesâ¦ / Maven
    preferences page.
-   index for an Eclipse workspace is updated when projects are added,
    removed or changed in Eclipse workspace.

## M2Eclipse vs. maven-eclipse-plugin

M2Eclipse is an Eclipse plugin that allows execution of Maven goals and manages Maven dependencies. It is a different beast to the maven-eclipse-plugin which is a Maven plugin that attempts to manage/modify Eclipse project files to account for Maven dependencies. Generally, if you are using m2eclipse you don't really need maven-eclipse-plugin. The former is providing advanced project import and configuration features and provides integration with other Eclipse tools.

## What Version of Maven is used by M2Eclipse?

Plugin is not actually using Maven itself. It is using component that is part of Maven called Maven Embedder. This component is not available for
Maven 2.0.x. The Embedder is used by the Maven command line interface (CLI) starting from version 2.1 that includes number of improvements to
allow it to actually embed Maven.

The m2eclipse is currently using the Embedder component from Maven 3.3.9. If you want to execute particular version of Maven installed elsewhere,
you can do so from the Maven launch configuration or select it as default in Maven / Installations preference page.

## Why does my Maven build work on the CLI but not in M2Eclipse?

Because M2Eclipse is using the embedded Maven runtime in Maven 3.0, you can see differences in the execution between m2eclipse and command line
when Maven 2.1.x is used. We hope that such regressions and incompatibilities will be fixed in the future releases of Maven 3.0.
Note that m2eclipse is always using embedded Maven runtime when running Maven builder, importing projects and updating project configuration, however you can configure m2eclipse to use external Maven installation when launching Maven using "Run as¦ / Maven XXX" actions.

## How to generate a thread dump

-   On Windows press Ctrl-Break in the Java console started with Eclipse
    IDE. To start Eclipse with Java console use java.exe instead of
    javaw.exe in eclipse.ini.

<!-- -->

    -vm
    C:\jdk1.6.0_03\bin\java.exe

-   On Unix, Linux, Mac OS X press `Ctrl-\` in the terminal console used
    to start Eclipse IDE
-   Alternatively on Unix, Linux, Mac OS X send the QUIT signal to the
    Java VM running Eclipse: kill -QUIT processid, where processid is
    the process number of the respective java process
-   All OS: use jps and jstack tool from JDK 1.5 or JDK 6.0 installation
    (run jps to get the process id, jstack <pid> to print thread dump).
-   All OS: use StackTrace tool
    -   launch from
        <http://www.adaptj.com/root/webstart/stacktrace/app/launch.jnlp>
    -   details <http://www.adaptj.com/root/main/stacktrace>
    -   to generate thread dump invoke "Process / Selectâ¦" from the
        main main menu and select Java process from the drop down list,
        then invoke "Process / Thread Dump"
-   Other tools listed on Javapedia ThreadDump page

## How to retrieve an actual command line used to start JVM and Maven

An actual command line used to start JVM processes in Eclipse, including
Maven builds, can be retrieved from the Debug view (e.g. from the Debug
perspective):

debugview.png

There you can select corresponding Java process and open its properties
(from the popup menu or using Alt-Enter shortcut):

processproperties.png
