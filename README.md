[![Gitpod Ready-to-Code](https://img.shields.io/badge/Gitpod-ready--to--code-blue?logo=gitpod)](https://gitpod.io/#https://github.com/joomlatools/joomlatools-gitpod)
# Joomlatools Gitpod
A super simple way to test drive our latest component [Joomlatools-pages](https://github.com/joomlatools/joomlatools-pages), straight from the browser.

You can test drive [Joomlatools-pages](https://github.com/joomlatools/joomlatools-pages) with in a native [Joomla](https://github.com/joomla/joomla-cms) environment.

### What is Joomlatools pages playground?

[Joomlatools-pages-playground](https://github.com/joomlatools/joomlatools-pages-playground) is a complete [Integrated Development Environment](https://en.wikipedia.org/wiki/Integrated_development_environment) and in this instance we have: 

* A online cloud source editor [Theia](https://theia-ide.org/)
* A LAMP server (Linux, Apache, MySql, PHP)
* A preconfigured Joomla
* Installed sample Joomlatools-pages ready to edit 

The actual IDE is provided by [Gitpod](https://www.gitpod.io) we've just extended their great work to showcase [Joomlatools-pages](https://github.com/joomlatools/joomlatools-pages)

This means that when you launch your Gitpod workspace, you can edit our sample [Joomlatools-pages](https://github.com/joomlatools/joomlatools-pages) in the cloud and see  the results in your browser straight away.

## Requirements

* Chrome of Firefox

## Installation

1. Install the [Gitpod Chrome or Firefox](https://www.gitpod.io/docs/browser-extension/) extension and click the `Gitpod`button.
2. Go to http://gitpod.io#https://github.com/joomlatools/joomlatools-gitpod

## Documentation

You can find all the documentation for Gitpod IDE (Theia) here: https://www.gitpod.io/docs/ide/

## Forking 

Please feel free to fork this repository, in the [normal manner](https://help.github.com/en/github/getting-started-with-github/fork-a-repo#fork-an-example-repository). 

We've also made great efforts to make this repository configurable to your needs 

## Configuring

`.gitpod/config/config.sh` is where you are able to configure how this repository will operate.

* By providing a `joomla` variable (valid version number), this specific version will be downloaded and installed. The default with no `joomla` variable means the latest Joomla! version will be installed 
* By providing a `repo` variable you can even install custom Joomla! instance. The repo variable should point to an existing Joomla github repo and use the https protocol. 
Further if you create `.gitpod/install.sql` dump you can even migrate a supporting database for this custom Joomla! site 
* By providing a `composer` variable you can specify which composer packages you would like added to the default Joomla! site

## Contributing

Joomlatools Pages is an open source, community-driven project. Contributions are welcome from everyone. 
We have [contributing guidelines](CONTRIBUTING.md) to help you get started.

## Contributors

See the list of [contributors](https://github.com/joomlatools/joomlatools-gitpod/contributors).

## License

Joomlatools Gitpod is open-source software licensed under the [GPLv3 license](LICENSE.txt).

## Community

Keep track of development and community news.

* Follow [@joomlatoolsdev on Twitter](https://twitter.com/joomlatoolsdev)
* Join [joomlatools/dev on Gitter](http://gitter.im/joomlatools/dev)
* Read the [Joomlatools Developer Blog](https://www.joomlatools.com/developer/blog/)
* Subscribe to the [Joomlatools Developer Newsletter](https://www.joomlatools.com/developer/newsletter/)

