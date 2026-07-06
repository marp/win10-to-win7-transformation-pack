Localization Guide
==================

The Windows 10 to Windows 7 Transformation Pack currently includes en-US (English US)
MUI files for all Control Panel pages.

Adding a New Language
---------------------

1. Run New-Locale.ps1 with your locale code:
   .\Localization\New-Locale.ps1 -Locale "pl-PL"

   This creates empty locale directories under each CPL page.

2. For each CPL page, you need to provide translated MUI files:

   a. Source: Get the original Windows 10 MUI files from your system:
      C:\Windows\System32\en-US\*.mui -> source for English strings

   b. Compare: Open the en-US MUI and the original Windows 10 MUI for your
      locale in Resource Hacker to see what strings differ.

   c. Translate: Using the en-US files from this pack as reference, create
      translated versions with your locale's strings.

   d. Place your translated files here:
      CPL Restoration 4.0 H1\Pages\<Page Name>\<Style>\system32\<locale>\

3. After adding files, run the installer with your locale:
   .\install.ps1 -Language "pl-PL"

MUI File Structure
------------------

Each CPL page has one or more style variants. MUI files follow the structure:

Pages\<Page Name>\<Style>\system32\<locale>\<dllname>.dll.mui

The en-US files in this pack show which files need to be translated.

Note: Some MUI files contain only UI strings; others contain resources
(icons, bitmaps) that should not be translated, only the string tables.

Credits
-------

If you contribute translations, your name and language will be credited in
the main README and in this file.
