---
layout: m2e-docs
title:  Development Environment
---

# Development Environment Setup

Download and unpack Eclipse latest SDK build from <http://download.eclipse.org/eclipse/downloads/> . The instructions below assume fresh/clean Eclipse installation.

Install M2Eclipse 1.5 or newer from <http://download.eclipse.org/technology/m2e/releases> . This is a P2 repository URL, use Eclipse Install UI to use it as explained in <http://help.eclipse.org/topic//org.eclipse.platform.doc.user/tasks/tasks-127.htm>

Clone the M2Eclipse Core repository, see <https://git.eclipse.org/r/#/admin/projects/m2e/m2e-core> for the list of available protocols.

Clone M2Eclipse Tests repository, see <https://github.com/tesla/m2e-core-tests> for the list of available protocols.

Import org.eclipse.m2e.workspace, m2e-core and m2e-core-tests as existing maven projects. Follow onscreen instructions, allow M2Eclipse to install additional software and restart eclipse when requested. Give Eclipse some time to update project configuration after restart. You may need to do Project/Clean.../Clean\_all\_projects to clear all compilation errors.

## Running M2Eclipse Automated Regression Tests from Eclipse

Add the following memory configuration parameters to JVM startup options

```
-XX:MaxPermSize=256m -Xmx1G
```

Use JUnit Plug-in Tests launch configuration type to run/debug M2Eclipse automated regressions tests from Eclipse.

Caveat. Two tests are expected to fail when run from Eclipse

1.  ProjectRegistryManagerTest\#testEnvironmentVariablesConsidered requires TEMP environment variable to be set and is expected to
    failed when run from Eclipse.

2.  MarkerTest\#test is rather sloppy and requires elaborate launch configuration setup to limit set of m2e extensions enabled during
    the test.

Both tests are expected to pass on command line (see instructions
below).

## Building M2Eclipse on the CLI

Building m2e on command line is a two step process, both performed from root of m2e-core checkout directory

First, you need to *install* m2e maven runtime to local maven repository

```
mvn clean install -f m2e-maven-runtime/pom.xml`
```

Then, package M2Eclipse update site:

```
mvn clean package
```

The repository is created under org.eclipse.m2e.site/target/repository directory.

## Running M2Eclipse Automated Regression Tests on the CLI

To run m2e automated regression tests, execute the following command from m2e-core-tests checkout directory

```
mvn clean integration-test -Puts,its -fae -Dm2e-core.url=file://<full-path-to-m2e-repository>
```

## Submitting Patches

### M2Eclipse Core Sources at Eclipse.org

M2Eclipse only accepts changes contributed via Gerrit. Here is the wiki that explains how to use it <http://wiki.eclipse.org/Gerrit> . Good luck.

According to [eclipse legal poster](http://www.eclipse.org/legal/EclipseLegalProcessPoster.pdf), all contributors must have signed Eclipse CLA and their bugzilla email and git commit author must match (otherwise Eclipse git server refuses contribution).

Note that M2Eclipse developers do NOT watch Gerrit submissions directly. All contributions must be referenced from corresponding bugzilla records.

### M2Eclipse Core Tests at Github

In most cases m2e core patches will require corresponding regression
tests. Changes to m2e core tests repository must be submitted as github
pull requests and must be linked to bugzilla record, along with
corresponding Gerrit change set.
