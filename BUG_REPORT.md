# Bug Reporting
## This extension is designed for Fantasy Grounds Unity. Fantasy Grounds Classic is ***not*** supported, nor do I ever have plans to do so.

### To report a bug, please do the following:
1. Ensure you are running Unity and not running any other extensions at the same time. I've tried to write this to be compatible with other extensions, but there's no guarantee I succeeded nor is there any guarantee that other extensions were written the same. If the problem persists even when it's the only extension loaded, follow the next steps. If the problem goes away, you can continue with the next steps and I will see what I can do, but it may be another extension colliding with this.
2. Delete the existing extension file and ensure you're using the [latest](https://gitlab.com/ccthiel/CoreRPG-Combat-Highlighter/-/jobs/artifacts/latest/file/CoreRPG-Combat-Highlighter.ext?job=build-extension) version of the plugin. Your bug may have been fixed in a newer version.
3. Visit the [issues](https://gitlab.com/ccthiel/CoreRPG-Combat-Highlighter/-/issues) page and ensure there isn't already an issue filed matching your problem. If there are no similar open issues, continue. If you spot one that is the same problem you're experiencing, you can post in the [fantasy grounds forum thread](https://www.fantasygrounds.com/forums/showthread.php?66336-CoreRPG-Combat-Highlighter&p=581044#post581044) and let me know which issue you're also experiencing.
4. Go to the settings in Fantasy Grounds, and beneath the **CoreRPG Combat Enhancer** section of the settings, ensure the `Debug Level` is set to `Verbose`
5. Exit Fantasy Grounds. This is to reset your console log.
6. Upon entering Fantasy Grounds, perform **only** the actions required to reproduce the bug. This will help keep the console log clear of noise that has nothing to do with the bug. Verbose mode is going to produce a *lot* of log entries.
7. If you don't know where your Fantasy Grounds data folder is, return to the launcher and click the folder icon in the top left of the launcher screen. This will open a file explorer in your Fantasy Grounds data folder. 
8. Locate the `console.log` file.
9. Post in the [fantasy grounds forum thread](https://www.fantasygrounds.com/forums/showthread.php?66336-CoreRPG-Combat-Highlighter&p=581044#post581044) or the [discord channel](https://discord.com/channels/812870526455250945/813173777663131659). Within the post, give a general description of the problem you are experiencing and the steps to reproduce the problem. Attach your `console.log` file to the post.

