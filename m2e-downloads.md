---
layout: default
title:  Downloads
---
# Update Sites

<div class="dlBackground">
  <a href="http://download.eclipse.org/technology/m2e/releases"><div class="col-md-4 buttonBG">
    <h2>Latest Release Build<br />
    <span class="footnote">(recommended)</span></h2>
  </div></a>
  <a href="http://download.eclipse.org/technology/m2e/milestones/1.6"><div class="col-md-4 buttonBG">
    <h2>Latest Milestone Build<br />
    <span class="footnote">(toward 1.6)</span></h2>
  </div></a>
  <a href="https://otto.takari.io/content/sites/m2e.extras/m2e/1.6.0/N/LATEST/"><div class="col-md-4 buttonBG">
    <h2>Latest SNAPSHOT Build<br />
    <span class="footnote">(not tested, not hosted at eclipse.org)</span></h2>
  </div></a>
</div>

# M2Eclipse Download Area Layout

```
releases/
 1.0/
   1.0.0.<qualifier>/
   1.0.100.<qualifier>/
   1.0.200.<qualifier>/
 1.1/
   ...

milestones/
 1.0/
   1.0.300.<qualifier>/
   1.0.300.<qualifier>/
   1.0.300.<qualifier>/
 
 ...
 
 1.1/
   1.1.0.<qualifier>/
   1.1.0.<qualifier>/
   1.1.0.<qualifier>/
```

M2Eclipse will advertise <http://download.eclipse.org/technology/m2e/releases/> as canonical M2Eclipse repository url. This repository is a composite that will contain all released M2Eclipse versions, so clients who use this url will be able to install releases and service releases from the same location. Clients will be able to use release-specific repositories (i.e. <http://download.eclipse.org/technology/m2e/releases/1.0>) if they are only interested in maintenance releases.

<http://download.eclipse.org/technology/m2e/milestones/> contains milestone builds towards releases. It has similar structure as releases/
repository but without composite p2 repository at the top level. Users will need to pick release-specific milestone build "stream".

M2Eclipse does not provide snapshot/nightly builds from download.eclipse.org

## M2Eclipse Git Repository Tags

M2Eclipse git repository tags will match download area directory structure, i.e. "releases/1.0/1.0.0.20110607-2117", "milestones/1.1/1.1.0.\<qualifier\>" and so on. Since builds are promoted from milestones to releases repositories, the same build can have multiple tags associated with it.

Tags are pushed to canonical git repository soon after build goes "live".

## M2Eclipse Release Train Contributions

During development, M2Eclipse will provide release train contributions via milestone version repository (i.e. <http://download.eclipse.org/technology/m2e/milestones/1.1>). Each new build will be automatically picked up by the release aggregator job and does not require changes to aggregator descriptor.

During release, latest milestone build is \*copied\* to corresponding releases/ directory and M2Eclipse contribution to release train aggregator will need to be updated at this point.

## M2Eclipse Releases

<table>
  <tbody>
    <tr>
      <th>Release</th>
      <th>Full Version</th>         
      <th>Date</th>      
      <th>Tag</th>                         
      <th>p2 URL</th>
    </tr> 
    <tr>
      <td>1.0
      <td>1.0.0.20110607-2117
      <td>2011-06-22
      <td>releases/1.0/1.0.0.20110607-2117
      <td><a href="http://download.eclipse.org/technology/m2e/releases/1.0/1.0.0.20110607-2117">http://download.eclipse.org/technology/m2e/releases/1.0/1.0.0.20110607-2117</a></td>
    </tr>
    <tr>                                                                                  
      <td>1.0 SR1</td> 
      <td>1.0.100.20110804-1717</td>
      <td>2011-09-23</td>
      <td>releases/1.0/1.0.100.20110804-1717</td>
      <td><a href="http://download.eclipse.org/technology/m2e/releases/1.0/1.0.100.20110804-1717">http://download.eclipse.org/technology/m2e/releases/1.0/1.0.100.20110804-1717</a></td>
    </tr>
    <tr>                                                                                 
      <td>1.0 SR2</td>
      <td>1.0.200.20111228-1245</td>
      <td>2012-02-24</td>
      <td>releases/1.0/1.0.200.20111228-1245</td>
      <td><a href="http://download.eclipse.org/technology/m2e/releases/1.0/1.0.200.20111228-1245">http://download.eclipse.org/technology/m2e/releases/1.0/1.0.200.20111228-1245</a></td>
    </tr>
    <tr>                                                                                 
      <td>1.1</td>
      <td>1.1.0.20120530-0009</td>
      <td>2012-06-27</td>
      <td>releases/1.1/1.1.0.20120530-0009</td>
      <td><a href="http://download.eclipse.org/technology/m2e/releases/1.1/1.1.0.20120530-0009">http://download.eclipse.org/technology/m2e/releases/1.1/1.1.0.20120530-0009</a></td>
    </tr>
    <tr>                                                                                  
      <td>1.2</td>
      <td>1.2.0.20120903-1050</td>
      <td>2012-09-19</td>
      <td>releases/1.2/1.2.0.20120903-1050</td>
      <td><a href="http://download.eclipse.org/technology/m2e/releases/1.2/1.2.0.20120903-1050">http://download.eclipse.org/technology/m2e/releases/1.2/1.2.0.20120903-1050</a></td>
    </tr>
    <tr>                                                                                 
      <td>1.3</td>
      <td>1.3.0.20130129-0926</td>
      <td>2013-02-20</td>
      <td>releases/1.3/1.3.0.20130129-0926</td>
      <td><a href="http://download.eclipse.org/technology/m2e/releases/1.3/1.3.0.20130129-0926">http://download.eclipse.org/technology/m2e/releases/1.3/1.3.0.20130129-0926</a></td>
    </tr>
    <tr>                                                                                 
      <td>1.3.1</td>
      <td>1.3.1.20130219-1424</td>
      <td>2013-02-20</td>
      <td>releases/1.3/1.3.1.20130219-1424</td>
      <td><a href="http://download.eclipse.org/technology/m2e/releases/1.3/1.3.1.20130219-1424">http://download.eclipse.org/technology/m2e/releases/1.3/1.3.1.20130219-1424</a></td>
    </tr>
    <tr>                                                                                 
      <td>1.4</td>
      <td>1.4.0.20130601-0317</td>
      <td>2013-06-26</td>
      <td>releases/1.4/1.4.0.20130601-0317</td>
      <td><a href="http://download.eclipse.org/technology/m2e/releases/1.4/1.4.0.20130601-0317">http://download.eclipse.org/technology/m2e/releases/1.4/1.4.0.20130601-0317</a></td>
    </tr>
    <tr>                                                                                 
      <td>1.4.1</td>
      <td>1.4.1.20140328-1905</td>
      <td>2014-03-31</td>
      <td>releases/1.4/1.4.1.20140328-1905</td>
      <td><a href="http://download.eclipse.org/technology/m2e/releases/1.4/1.4.1.20140328-1905">http://download.eclipse.org/technology/m2e/releases/1.4/1.4.1.20140328-1905</a></td>
    </tr>
    <tr>                                                                                 
      <td>1.5</td>
      <td>1.5.0.20140606-0033</td>
      <td>2014-06-25</td>
      <td>releases/1.5/1.5.0.20140606-0033</td>
      <td><a href="http://download.eclipse.org/technology/m2e/releases/1.5/1.5.0.20140606-0033">http://download.eclipse.org/technology/m2e/releases/1.5/1.5.0.20140606-0033</a></td>
    </tr>
    <tr>                                                                                 
      <td>1.5</td>
      <td>1.5.0.20140606-0033</td>
      <td>2014-06-25</td>
      <td>releases/1.5/1.5.0.20140606-0033</td>
      <td><a href="http://download.eclipse.org/technology/m2e/releases/1.5/1.5.0.20140606-0033">http://download.eclipse.org/technology/m2e/releases/1.5/1.5.0.20140606-0033</a></td>
    </tr>
  </tbody>
</table>

# Supported Environments

## M2Eclipse 1.6.0/Mars

M2Eclipse 1.6.0/Mars is tested and validated against Eclipse 4.4 (Luna)

M2Eclipse 1.6.0/Mars requires minimum java 7

M2Eclipse 1.6.0/Mars is tested and validated on the following reference
platforms (this list is updated over the course of the release cycle):

<table>
  <tbody>
  <tr>
    <th>Operating System</th>
    <th>Version</th>
    <th>Hardware</th>
    <th>JRE</th>
    <th>Windowing System</th>
    <th>Latest Results</th>
  </tr>
  <tr>
    <td>Linux</td>
    <td>CentOS 6.5, Ubuntu 14.04</td>
    <td>x86 64-bit</td>
    <td>Oracle Java 1.7.0_45, 1.8.0_05</td>
    <td>GTK+ 2</td>
    <td>1.7, [TBD 1.8]</td>
  </tr>
  <tr>
    <td>OSX</td>
    <td>10.9</td>
    <td>x86 64-bit</td>
    <td>Oracle Java 1.7.0_45, 1.8.0_05</td>
    <td>Cocoa</td>
    <td>[TBD 1.7.0_45], [TBD 1.8.0_05]</td>
  </tr>
  <tr>
    <td>Windows</td>
    <td>Windows 7</td>
    <td>x86 64-bit</td>
    <td>Oracle Java 1.7.0_45, 1.8.0_05</td>
    <td>Windows 7</td>
    <td>[TBD 1.7.0_45], [TBD 1.8.0_05]</td>
  </tr>
  </tbody>
</table>



