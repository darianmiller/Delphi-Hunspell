# Delphi-Hunspell
Simple Hunspell wrapper for Delphi

Source from [Code Central](https://cc.embarcadero.com/item/27428) by Chris Rolliston.
* See [original blog post](https://delphihaven.wordpress.com/hunspell/)
* And follow-up blog post on [Building Hunspell DLL](https://delphihaven.wordpress.com/2010/02/06/compiling-a-hunspell-dll-step-by-step/)

### Code Central Description
[Hunspell](http://hunspell.github.io/) is the open source spell checking engine used in OpenOffice; this wrapper class calls into a DLL compiled from the standard Hunspell sources, with one such DLL (built using v1.2.8 of Hunspell) included in the ZIP. The wrapper itself is then both code page aware (doing any needed conversions behind the scenes) and compatible between D2006/7 and later Unicode Delphis.

Note that v1.1 fixes the issue described here: http://delphihaven.wordpress.com/hunspell/#comment-964


## +OpenOffice 3 Spell Checker for Delphi
* Alternative to using CCR Hunspell
* Open source component to implement spell checking using OpenOffice 3 dictionaries. [D2007,D2009,D2010,XE]  This is a spelling checker based on the NHunspell project

## +Latest Hunspell dictionary from SCOWL and Friends
* en_US.dic from 2019.10.06  (UTF8)

## +Latest Hunspell DLL - Win32 release build 
* libhunspell.dll from 2019.11.12 
* Built with Visual Studio 2019 with quick notes on changes needed to build