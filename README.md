# An Automated Windows Temp Clean Up Tool

A Robust Windows Batch utility designed to safely analyze and purge temporary files and redundant directories without breaking active applications or system stabilities.

---

## Requirements

- Windows 10 / 11
- Administrator rights
- Command Prompt (any terminal)

## Key Features

* **Safety-First Threshold:** Automatically filters and deletes files that are **ONLY 3 days or older**, leaving recent cache layers untouched to protect active application sessions.
* **Defensive Directory Purging:** Uses reverse-sorting subfolder evaluation. Empty parent directories are removed **ONLY** after all child folders have been processed (deepest‑first), preventing accidental deletion of structural folders.
* **Robust Space Handling:** Employs nested literal token escaping (`\"@path\"`) to perfectly handle usernames, paths, and filenames containing whitespace strings without tripping or failing silently.
* **Real-Time Logging:** Suppresses errors from locked files, printing only successful deletions for a clean console log.
* **Custom ASCII Terminal UI:** Built with clean ANSI/ESC color matrix configurations for intuitive terminal monitoring.

---

## How It Works Under The Hood

The tool loops through both the current User Profile (`%temp%`) and the System-wide Windows temporary repository (`C:\Windows\Temp`). 


`forfiles /p "%%~G" /s /d -3 /c "cmd /c del /q /f \"@path\" >nul 2>&1 && echo [DELETED]: @file"`
`forfiles /s /d -3`: Recursively evaluates target paths looking for items with a last-modified date older than 3 days.

  `\"@path\" >nul 2>&1`: Encapsulates data tokens in clean escape quotes to survive nested string manipulation, executing the deletion silently so locked files do not clutter the screen with access errors.

  `&& echo [DELETED]: @file`: Leverages conditional execution handles so an entry is only printed to your terminal screen if the deletion was a verified success.

## How To Use It?

**Note** Please verify the integrity of the tool before running the script. To do so, check the Code Integrity & Verification section below.

**Because modifying systemic assets inside `C:\Windows\Temp` requires elevated privileges, the script contains an integrated privilege guard.**
* **Download `Temp-CleanUp.bat`.**
* **Right-click the script and select "Run as Administrator".**
* **Follow the automated real-time tracking logs until the success banner is displayed. Then press any key to exit the script.**

# Code Integrity & Verification

To maintain complete supply-chain security and verify that your downloaded script is authentic, official, and untampered with, you can check its Hash-Value using Windows native CertUtil tool.

* # Official Release Hashes (v1.0.0)

    * File Name: Temp-CleanUp.bat
    * SHA-256 Checksum: fd8e4968d27fb47f83e46647736cc812b5e399a92cd4981293fc60f5c343d6f6

* # How to Verify:

  * Open a `command prompt` or `PowerShell` and run the following command:
  * `certutil -hashfile "path\to\Temp-CleanUp.bat" SHA256`
  * Example: `certutil -hashfile "C:\Users\YourName\Downloads\Temp-CleanUp.bat" SHA256`
  * Expected OutPut: `fd8e4968d27fb47f83e46647736cc812b5e399a92cd4981293fc60f5c343d6f6`
  * **Security Notice: Compare your terminal's output hash string with the official checksum listed above. If they match perfectly, your tool is completely authentic and safe to execute. If they do not match, delete the file immediately and do not execute it.**

 ## Limitations

- Filenames containing `&`, `|`, or `%` may produce garbled console output (extremely rare in temp files). The files themselves are still deleted correctly.
- The script does **NOT** delete files newer than 3 days, even if they are safe to remove.
- Some system‑locked files inside `C:\Windows\Temp` may remain – this is normal and does not indicate a failure.
- The script only deletes files, not registry entries or other system areas.

## License

MIT – use freely, but no warranty. See the `LICENSE` file.
