---
layout: default
title: Website Publishing
---

# M2Eclipse Website

The M2Eclipse website is a Jekyll-based website. This means the sources are a standard looking Jekyll-based site, and the website we publish for the outside world is what Jekyll generates. Currently at Eclipse websites are checked into a Git repository in their final form and that's what is served as our public website. There is no mechanism, currently, to run a transformation process so the M2Eclipse website is in one Git repository and then we push the final version to another Git repository. This is not idea but that's what we have. 

To try and make it as simple as possible the Git repository with the sources contains a submodule that contains the final site. To get the sources and the module containing the `_site` directory do the following:

```
git clone --recursive git@github.com:takari/m2eclipse-website.git
```

Now you should have something that looks like the following:

```
bash-3.2$ tree -L 1
.
├── Icon.
├── README.md
├── _config.yml
├── _includes
├── _layouts
├── _plugins
├── _references.md
├── _site
├── assets
├── documentation
├── index.html
├── jekyll.jar
├── jekyll.sh
├── m2e-community.md
├── m2e-downloads.md
├── m2e-news.md
└── projectplan
```

The easiest way to edit the site is to execute the script provided. Start it up and you will see something like the following:

```
bash-3.2$ ./jekyll.sh

     Source directory: /Users/jvanzyl/Dropbox/takari-website-m2e
Destination directory: /Users/jvanzyl/Dropbox/takari-website-m2e/_site

website.md
m2e-development-environment.md
m2e-documentation.md
m2e-execution-not-covered.md
m2e-extension-development.md
m2e-faq.md
release-notes-15.md
index.html
m2e-community.md
m2e-downloads.md
m2e-news.md
116 [main] INFO org.eclipse.jetty.server.Server - jetty-9.0.z-SNAPSHOT
138 [main] INFO org.eclipse.jetty.server.handler.ContextHandler - Started o.e.j.s.ServletContextHandler@1332fa84{/,null,AVAILABLE}
138 [main] INFO org.eclipse.jetty.server.handler.ContextHandler - Started o.e.j.s.h.ContextHandler@77dcf9f4{/m2e,file:/Users/jvanzyl/Dropbox/takari-website-m2e/_site/,AVAILABLE}
151 [main] INFO org.eclipse.jetty.server.ServerConnector - Started ServerConnector@69317d48{HTTP/1.1}{0.0.0.0:4000}
```

Now you can add and edit content for the website, reload your browser, edit, rinse, repeat. The content will be generated in the `_site` directory as you make changes. Once you are finish working on content, you can go into the `_site` directory, add, commit, and then push changes to the production website. They should appear on <http://eclipse.org/m2e> fairly soon after.

NOTE: Ideally we will eventually have a process on the Eclipse host that will the transformation for us, or possibly ask the Webmaster to pull the final site from a directory within the Git repository. In a standard Jekyll-based build the default location of the generated site is `_site`. If we can ask to have our public facing website pulled from the `_site` directory in out website's Git repository we can probably put it all in a single repository.