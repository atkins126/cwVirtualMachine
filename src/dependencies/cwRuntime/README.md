<<<<<<< HEAD
# cwRuntime

* Currently undergoing some major edits on the master branch, including rebuild of the CI.
* Everything but cwLog should be working again, there may be some new issues in cwThreading due to a rewrite/redesign.

Compiler agnostic and cross platform collection of utility libraries for Delphi and Freepascal.

While this library does still depend on some parts of the Delphi / Freepascal rtl libraries, 
the goal is to remove that dependency entirely. This library has been migrated from my personal 
collection to become open source under the three clause BSD license. Migration is in advanced 
stages but is not yet complete. 

Current Features:
	
	cwTest        - A light-weight unit testing framework.
	cwStatus      - A TGUID/Boolean/String compatible type for function return enumeration.
	cwTypes       - A collection of type-helpers and half-precision floating point type.
	cwCollections - Generic collection classes List/Stack/Ring etc.
	cwDynLib      - Dynamic library loading.
	cwIO          - Classes for serialization/deserialzation of streams.
	cwLog         - (Currently refactoring) - Logging and error reporting system with language translation.
	cwThreading   - A system for organizing multi-threaded code.
	cwUnicode     - A Unicode Codec and string data type to convert between unicode formats.
	cwVectors     - A simple vector math library.
	cwTiming      - A high precision timer (where available on target).
	cwSockets     - A low level sockets wrapper for WinSock2 / BSD Sockets.
	cwHeap        - Simple wrapper around Windows API / cLib heap alllocation.

(* Half precision floating point with permission from, and thanks to Marek Mauder
   at Galfar's Lair: https://galfar.vevb.net *)
	
Supported compilers:  
    XE5, XE6, XE8, 10.0 Seattle, 10.2 Tokyo, 10.3 Rio, Lazarus 2.0.10
	
	Other compilers may also work - in particular the skipped Delphi compilers in the 
	above sequence. These are merely the compilers I have access to install on the 
	CI server.

Still To-Do:

	* cwTypes Still heavily dependent on RTL units for string/type conversion, need to replace.
	* cwIO Still heavily dependent on RTL units, need to replace. (incl heap wrapper)
	* cwIO Unit tests are missing.
	* cwThreading unit tests are missing.
	* cwTiming unit tests are missing.
	* cwCollections - IStringList to get serialize/deserialze methods for save to file, load from file.	
	* Documentation needs work.
	
    CI Server :- Currently performs builds and runs unit tests for Windows Only, need to add targets.

Installation & Usage:

 There is nothing to install when using the cwRuntime (the included package comes out of legacy CI, and will likely be removed soon, it should not be installed). Instead, simply add the following two paths to your compilers search path...
 
 * cwRuntime/src/main/api
 * cwRuntime/src/main/implementation
 
Each feature may then be used by adding two units to your uses list. For example, to use cwCollections you can add both cwCollections and cwCollections.Standard to your uses list. There are some exceptions to this rule, see the api directory and associated documentation.

---  
Usage videos will be uploaded to youtube soon :- https://youtube.com/c/ChapmanWorldOnTube.

CI Migration Status:

	* Delphi
		Win32        - Builds
		Win64        - Builds / Unit Tested
		Linux_x86_64 - Builds / Unit Tested
		Android      - TBD
		MacOS        - TBD
		iOS          - TBD

	* Lazarus
		Win32        - Builds / Unit Tested
		Win64        - Builds / Unit Tested
		Linux_x86_64 - Builds / Unit Tested
		Linux_i386   - Builds / Unit Tested
		Linux_ARM    - Builds / Unit Tested
		Linux_AARCH  - Builds / Unit Tested
		Android      - TBD
		MacOS        - TBD
		iOS          - TBD ? possible ?
		 

Notes: For cross compiling to Linux from Windows, see issue #8
=======
# cwRuntime

* Currently undergoing some major edits on the master branch, including rebuild of the CI.
* Everything but cwLog should be working again, there may be some new issues in cwThreading due to a rewrite/redesign.
* Sorry: I tried to retain compatibiltiy with Lazarus 2.0.8 but too many features require FPC 3.2.0 which is the
         compiler used in Lazarus 2.0.10 - Lazarus 2.0.10 is the minimum requirement.

Compiler agnostic and cross platform collection of utility libraries for Delphi and Freepascal.

While this library does still depend on some parts of the Delphi / Freepascal rtl libraries, 
the goal is to remove that dependency entirely. This library has been migrated from my personal 
collection to become open source under the three clause BSD license. Migration is in advanced 
stages but is not yet complete. 

Current Features:
	
	cwTest        - A light-weight unit testing framework.
	cwStatus      - A TGUID/Boolean/String compatible type for function return enumeration.
	cwTypes       - A collection of type-helpers and half-precision floating point type.
	cwCollections - Generic collection classes List/Stack/Ring etc.
	cwDynLib      - Dynamic library loading.
	cwIO          - Classes for serialization/deserialzation of streams.
	cwLog         - (Currently refactoring) - Logging and error reporting system with language translation.
	cwThreading   - A system for organizing multi-threaded code.
	cwUnicode     - A Unicode Codec and string data type to convert between unicode formats.
	cwVectors     - A simple vector math library.
	cwTiming      - A high precision timer (where available on target).
	cwSockets     - A low level sockets wrapper for WinSock2 / BSD Sockets.
	cwHeap        - Simple wrapper around Windows API / cLib heap alllocation.

(* Half precision floating point with permission from, and thanks to Marek Mauder
   at Galfar's Lair: https://galfar.vevb.net *)
	
Supported compilers:  
    XE5, XE6, XE8, 10.0 Seattle, 10.2 Tokyo, 10.3 Rio, Lazarus 2.0.10
	
	Other compilers may also work - in particular the skipped Delphi compilers in the 
	above sequence. These are merely the compilers I have access to install on the 
	CI server.

Still To-Do:

	* cwTypes Still heavily dependent on RTL units for string/type conversion, need to replace.
	* cwIO Still heavily dependent on RTL units, need to replace. (incl heap wrapper)
	* cwIO Unit tests are missing.
	* cwThreading unit tests are missing.
	* cwTiming unit tests are missing.
	* cwCollections - IStringList to get serialize/deserialze methods for save to file, load from file.	
	* Documentation needs work.
	
    CI Server :- Currently performs builds and runs unit tests for Windows Only, need to add targets.

Installation & Usage:

 There is nothing to install when using the cwRuntime (the included package comes out of legacy CI, and will likely be removed soon, it should not be installed). Instead, simply add the following two paths to your compilers search path...
 
 * cwRuntime/src/main/api
 * cwRuntime/src/main/implementation
 
Each feature may then be used by adding two units to your uses list. For example, to use cwCollections you can add both cwCollections and cwCollections.Standard to your uses list. There are some exceptions to this rule, see the api directory and associated documentation.

---  
Usage videos will be uploaded to youtube soon :- https://youtube.com/c/ChapmanWorldOnTube.

CI Migration Status:

	* Delphi
		Win32        - Builds
		Win64        - Builds / Unit Tested
		Linux_x86_64 - Builds / Unit Tested
		Android      - TBD
		MacOS        - TBD
		iOS          - TBD

	* Lazarus
		Win32        - Builds / Unit Tested
		Win64        - Builds / Unit Tested
		Linux_x86_64 - Builds / Unit Tested
		Linux_i386   - Builds / Unit Tested
		Linux_ARM    - Builds / Unit Tested
		Linux_AARCH  - Builds / Unit Tested
		Android      - TBD
		MacOS        - TBD
		iOS          - TBD ? possible ?
		 

Notes: For cross compiling to Linux from Windows, see issue #8
>>>>>>> 6c4801d2dc5041f543a87f07704a36d49a557ce1
