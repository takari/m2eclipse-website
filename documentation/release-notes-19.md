---
layout: m2e-docs
title:  1.9 Release Notes
Author: Fred Bricon
Date: June 27th, 2018
---

[M2Eclipse](https://www.eclipse.org/m2e) released version 1.9.0 as part of the
Eclipse Photon release train. 

This 1.9.0 release brings a whole set of big and small improvements to the Maven Integration experience. [27 bugs and improvements](https://projects.eclipse.org/projects/technology.m2e/releases/1.9/bugs) were addressed during that development cycle. Highlights of this release include:

* Proper test classpath isolation, main classes no longer see test scoped classes/dependencies
* Improved Java 9/10 support
* Contribution to the advanced source lookup mechanism
* New binary project type, to improve the debugging experience
* Embedded Maven 3.5.3
* POM XML editor opened by default
* Custom source encoding support
* Custom access rules support
* Fallback to downloading Javadoc when sources are missing 
* Automatically enables the "Store information about method parameters" compiler option according to the maven-compiler-plugin configuration
* New possibility to disable archetype catalogs


