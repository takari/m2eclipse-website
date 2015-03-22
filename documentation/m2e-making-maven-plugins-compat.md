---
layout: m2e-docs
title:  Making Maven Plugins M2Eclilpse Compatible
---

### Overview

Starting with m2e 1.1, maven plugin developers can embed m2e lifecycle
mapping metadata as META-INF/m2e/lifecycle-mapping-metadata.xml file
included with main plugin artifact.

This file uses the same format as lifecycle-mapping-metadata.xml used by
m2e project configurators and embedded in pom.xml file with some minor
extensions to the format -- elements are not required to provide plugin
groupId, artifactId and versionRange because this information can be
automatically derived from maven plugin already. Although groupId,
artifactId and versionRange information is not required, it is still
allowed by the format and maven plugin developers can still provide it
if they choose so.

### mapping

```
<lifecycleMappingMetadata>
  <pluginExecutions>
    <pluginExecution>
      <pluginExecutionFilter>
        <goals>
          <goal>some-goal</goal>
        </goals>
      </pluginExecutionFilter>
      <action>
        <ignore/>
      </action>
    </pluginExecution>
  </pluginExecutions>
</lifecycleMappingMetadata>
```

### mapping

```
<lifecycleMappingMetadata>
  <pluginExecutions>
    <pluginExecution>
      <pluginExecutionFilter>
        <goals>
          <goal>some-goal</goal>
        </goals>
      </pluginExecutionFilter>
      <action>
        <execute>
          <runOnIncremental>see below</runOnIncremental>
          <runOnConfiguration>see below</runOnConfiguration>
        </execute>
      </action>
    </pluginExecution>
  </pluginExecutions>
</lifecycleMappingMetadata>
```

If is set to *true*, corresponding mojo will be executed during both
full and incremental workspace builds. If set to *false* (the default),
the mojo will be executed during full workspace build only.

If set to *true*, corresponding maven mojos will be executed as part of
project import and configuration update. This is necessary for mojos
that make changes to MavenProject instance and expect these changes to
be available to other maven plugins. It will also trigger m2e to update
the Eclipse project accordingly. For example, most code generation
plugins, like modello or antlr3, add new source directories to
MavenProject instance and need to have set to *true*. m2e will then
update the Eclipse project to use these directories as source folders.

### BuildContext

Regardless of build type, all mojos mapped to **MUST** use plexus-build-api [BuildContext](https://github.com/sonatype/sisu-build-api/blob/master/src/main/java/org/sonatype/plexus/build/incremental/BuildContext.java) to change workspace resources and to associate warning/error/info messages with workspace resources. Additionally, mojos mapped to during incremental build or on configuration **MUST** use [BuildContext](https://github.com/sonatype/sisu-build-api/blob/master/src/main/java/org/sonatype/plexus/build/incremental/BuildContext.java) to skip execution when there none of relevant workspace resources changed.

**BuildContext provides reasonable default behaviour for command line build**. It has virtually no impact on build performance, i.e. all build context methods are just pass-though straight to filesystem and thus BuildContext can be used outside of m2e without any impact on the build result.

Use of BuildContext is required for two reasons

All filesystem changes must be registered as such with build context. This allows m2e to synchronize these changes with their corresponding workspace resources, which will trigger required workspace processing of the changes. For example, if the mojo generates java source code, the new code will not be compiled or won't even be visible in workspace unless workspace is refreshed. Out-of-sync files under target/classes or target/test-classes can also cause unexpected JDT "clean" builds, which result in all non-java files removed.

Mojos that runOnIncremental=true (the default), will be executed for any
resource file, including all sources and generated files under target/.
For performance and stability reasons it is absolutely essential to
short-cut any time consuming work and all filesystem changes if there
are no changes to the input sources processed by the mojo. For java code
generating mojos, failure to act on relevant input changes only will
almost certainly result in endless build -- mojo generates .java files,
which triggers jdt to generate .class files, which triggers the mojo to
generate .java files, and so on.

Although the current plexus-build-api will still be supported, it will
likely be replaced with a new version more tightly integrated with Maven
CLI build and other Maven-based tools in the near future.

### BuildContext code snippets

Add plexus-build-api to pom.xml


```
 <dependency>
   <groupId>org.sonatype.plexus</groupId>
   <artifactId>plexus-build-api</artifactId>
   <version>0.0.7</version>
 </dependency>
```   

Instruct Maven to inject BuildContext instance in the mojo

```
  /** @component */
  private BuildContext buildContext;
```  

To check if single input file was modified since previous build

```
  File source = ...;
  if ( buildContext.hasDelta( source ) )
  {
     ... process the source;
  }
```

To check if any of the paths in given collection was modified since
previous build (paths are relative to \${project.basedir})

```
  List relpaths = ...;
  if ( buildContext.hasDelta( relpaths ) )
  {
     ... process the sources;
  }
```

Scanning for modified resources

```
 File modelDir = ...;
 Scanner scanner = buildContext.newScanner( modelDir );
 // code below is standard plexus Scanner stuff
 scanner.setIncludes( new String[] {"*.mdo"} );
 scanner.scan()
 String[] includedFiles = scanner.getIncludedFiles();
 if ( includedFiles != null )
 {
     for ( String includedFile : includedFiles )
     {
         File modelFile = new File( scanner.getBasedir(), includedFile );
         ... process the file 
     }
 }
```

Open new output stream, which is automatically synchronized with Eclipse
workspace

```
 File file = ...;
 OutputStream os = buildContext.newFileOutputStream( file );
 try
 {
     ... write to the stream;
 }
 finally
 {
     IOUtils.close( os );
 }
```

Notify build context about a file created, updated or deleted without
use of newFileOutputStream. This works for directories, too.

```
 File file = ...;
 buildContext.refresh( file );
```

Dealing with error messages


```
 File source = ...;
 buildContext.removeMessages( source );
 // processs source file...
 if ( error in the source file )
 {
     buildContext.addMessage( source, line, column, message, BuildContext.SEVERITY_ERROR, null);
 }
``` 