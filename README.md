# QuickTerm

QuickTerm is a FinderSync extension that allows quick opening of a terminal session 
in the current directory. This feature is typically present in most operating systems, 
but, interestingly is absent in macOS.

## Why?
Previous utilities I used were rendered obsolete with advent of System Integrity Protection
– a feature I'd like to avoid disabling.

Additionally, using the services context menu seems unnatural, as it only seems to work
for selected files – i.e. not the currently open directory.

## Compatibility
Should be compatible with macOS 10.10+, tested on 10.13.6.

Only supports Terminal and iTerm2.

## Bugs
Please note: iTerm2 creates an additional window when one of its services is called, if iTerm2
was not previously running. I did consider fixing this issue by means of calling iTerm2 via an
AppleScript, however, I believe the root cause of the issue should be fixed. As I do not 
actually use iTerm2, I have no plans to personally address this issue.