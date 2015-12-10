This directory contains imported sources of PDClib.

Directories ./functions, ./includes and ./internals contain the actual
implementation of the C library. There should be no need to tinker
with them at all.  The standard library headers that may be exposed to
target sources are in ./includes directory. ./internals contains
non-standard headers which are specific to PDClib implementation.

Directory ./platform contains the platform-specific glue layer. When
the time is right to hook an OS feature with PDClib, it should be
enough to fill in some of the functions from ./platform directory.

The internal structure of ./platform directory resemples the structure
of ./, so there is a ./platform/includes with additional standard
headers, ./platform/internals/ with PDClib header configuraion, and
most OS function implementations can be found in ./platform/functions.
The remaining directories are what seems like an add-on system for
PDClib, it appreads like such package extension mechanism for PDClib
was under development but never got finished. Therefore some features
were not originally integrated into the main functions tree, and I
decided to leave them that way. These directories contain:

 - nothread - a null thread synchronization mechanism
implemenation. Mutexes are just chars, lock is an increment,
etc. Guarantees no thread safety, but fulfills the required interface
and therefore serves as a simple bootstrap

 - notime - a null time-based functions implementation. time() returns
  -1

 - c_locale - some simple helper procedures for initializing global
  locale

 - basecodecs - codecs for basic charactersets

 - dlmalloc - a fairly complex malloc implementation




The PDClib was written:

 - 2003-2012 by Martin "Solar" Baute
 - 2012- by Owen Shepherd

To the extent possible under law, the author(s) have dedicated all copyright and related and neighboring rights to PDClib to the public domain worldwide. PDClib is distributed without any warranty.

PDCLib necessarily includes Unicode character data derived from that provided by Unicode, Inc in its' implementation of the localization and wide character support (in particular for use by the ctype.h and wctype.h functions.)

Unicode, Inc licenses that data under a license agreement which can be found at <http://www.unicode.org/copyright.html#Exhibit1>, or in the file UNICODE_DATA_LICENSE.txt. found in the same directory as this file.
