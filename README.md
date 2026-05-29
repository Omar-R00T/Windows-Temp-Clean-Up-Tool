# An Automated Windows Temp Clean Up Tool

A Robust Windows Batch utility designed to safely analyze and purge temporary files and redundant directories without breaking active applications or system stabilities.

---

## Key Features

* **Safety-First Threshold:** Automatically filters and deletes files that are **ONLY 3 days or older**, leaving recent cache layers untouched to protect active application sessions.
* **Defensive Directory Purging:** Uses reverse-sorting subfolder evaluation. Redundant parent directories are ONLY removed if they are completely empty, preventing accidental deletion of structural folders.
* **Robust Space Handling:** Employs nested literal token escaping (`\"@path\"`) to perfectly handle usernames, paths, and filenames containing whitespace strings without tripping or failing silently.
* **Real-Time Logging:** Supplements standard outputs to intercept locked/system-restricted files gracefully, printing only successful purges via a compact `@file` rolling console feed.
* **Custom ASCII Terminal UI:** Built with clean ANSI/ESC color matrix configurations for intuitive terminal monitoring.

---

## How It Works Under The Hood

The tool loops through both the current User Profile (`%temp%`) and the System-wide Windows temporary repository (`C:\Windows\Temp`). 

cmd
forfiles /p "%%~G" /s /d -3 /c "cmd /c del /q /f \"@path\" >nul 2>&1 && echo [DELETED]: @file"
  forfiles /s /d -3: Recursively evaluates target paths looking for items with a last-modified date older than 3 days.

  \"@path\" >nul 2>&1: Encapsulates data tokens in clean escape quotes to survive nested string manipulation, executing the deletion silently so locked files do not clutter the screen with access errors.

  && echo [DELETED]: @file: Leverages conditional execution handles so an entry is only printed to your terminal screen if the deletion was a verified success.

## How To Use It?

* **Because modifying systemic assets inside C:\Windows\Temp requires elevated security tokens, the script contains an integrated privilege guard.**
* **Download Temp-CleanUp.bat.**
* **Right-click the script and select "Run as Administrator".**
* **Follow the automated real-time tracking logs until the success banner is displayed. Then press any key to exit the script.**

## Code Integrity & Verification
To maintain complete supply-chain security and verify that your downloaded script is authentic, official, and untampered with, you can check its Hash-Value using Windows' native CertUtil tool.

# Official Release Hashes (v1.0.0)
  File Name: Temp-CleanUp.bat
  SHA-256 Checksum: fd8e4968d27fb47f83e46647736cc812b5e399a92cd4981293fc60f5c343d6f6

# How to Verify:
  Open a command prompt or PowerShell and run the following command:
certutil -hashfile "path\to\Temp-CleanUp.bat" SHA256
  Example: certutil -hashfile "D:\Desktop\Temp-CleanUp.bat" SHA256
  output should be: fd8e4968d27fb47f83e46647736cc812b5e399a92cd4981293fc60f5c343d6f6
    Compare your output hash string with the official checksum listed above. If they match perfectly, your tool is completely authentic and safe to execute!
      If they don't match please remove the tool and do not run it.
