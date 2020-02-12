~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
CCR.Hunspell.pas - Hunspell wrapper for Delphi 7-XE
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Compiling the Hunspell DLL
--------------------------

In the ZIP, I've included a version of the Hunspell DLL I compiled using Visual C++ 2008 Express - this was using v1.2.8 of Hunspell. When compiling it for yourself, you basically have two VC++ project files to choose from, unless you create your own of course - one under src\hunspell and one under src\win_api (the former is set up to compile a static library rather than a DLL, but this is easy to change). Either should be OK to use with my wrapper.

Ansi vs. Unicode
----------------

In writing the wrapper, my aim was twofold: to properly support dictionaries with foreign code pages (most standard Hunspell dictionaries not being unicode), and for things to work seamlessly across the unicode 'speedbump' that lies between D2007 and D2009.

Actually demonstrating foreign code page support in D2006/7 is a bit tricky though given how the VCL is itself Ansi. To counter this, the included demo  has an optional HackUnicode define (get it working by removing the '.' - the define's near the top of App.TestFrame.pas), the enabling of which will make the input and output boxes unicode controls, and thus, have the unicode versions of IsCorrectlySpelt and GetSuggestions called.

Whether you enable the demo's unicode mode in D2006/7, or are using D2009 or greater anyhow, putting the unicode support through its paces obviously reqires testing with a dictionary that doesn't use a Latin-1 code page. So, say you download the Greek dictionary, and unzip it to CCR Hunspell\Demo\Dictionaries. Run the demo, load the Greek dictionary (the filename will be el_GR.aff), and try spell checking δοκιμ. (When I try this, the list of suggestions is as thus: δοκιμή, δοκιμών, δοκιμές, δοκιμάσω, and δοκιμάζω.)


Version history
---------------

1.1.2 (2011-04-07): added D7 compatibility. Rename the unit to remove the dot to compile under D6 too.

1.1.1 (2011-03-15): UTF-8 encoded dictionaries should now work again.

1.1.0 (2011-03-14): now handles the case of when characters outside of the dictionary's codepage are passed in. Specifically, IsSpeltCorrectly now returns False, GetSuggestions just works, AddCustomWord or TryAddCustomWord will raise an exception, and RemoveCustomWord will return False.

1.0.0 (2009-10-27): initial release.


Links
-----

http://hunspell.sourceforge.net/ - main Hunspell page. Brief and to the point!
http://wiki.services.openoffice.org/wiki/Dictionaries - get your Hunspell dictionaries here.
http://mh-nexus.de/en/tntunicodecontrols.php - Maël Hörz's fork of Troy Wolbrink's TNT Unicode Controls for D5-D2007.
http://sourceforge.net/projects/nhunspell/ - home of NHunspell, a C++/CLI Hunspell bridge for .Net.
http://www.brainendeavor.com/modx/happy-holidays-have-a-spellchecker.html - Brian Moelk's Hunspell wrapper.
http://www.microsoft.com/express/vcsharp/ - VC++ Express, perfect for compiling a Hunspell DLL.