# delphi_hunspell
Simple Hunspell wrapper for Delphi

Source from [Code Central](https://cc.embarcadero.com/item/27428) by Chris Rolliston.
* See [original blog post](https://delphihaven.wordpress.com/hunspell/)
* And follow-up blog post on [Building Hunspell DLL](https://delphihaven.wordpress.com/2010/02/06/compiling-a-hunspell-dll-step-by-step/)

## Code Central Description
[Hunspell](http://hunspell.github.io/) is the open source spell checking engine used in OpenOffice; this wrapper class calls into a DLL compiled from the standard Hunspell sources, with one such DLL (built using v1.2.8 of Hunspell) included in the ZIP. The wrapper itself is then both code page aware (doing any needed conversions behind the scenes) and compatible between D2006/7 and later Unicode Delphis.

Note that v1.1 fixes the issue described here: http://delphihaven.wordpress.com/hunspell/#comment-964
