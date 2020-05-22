# definite
Record and recall term-definition pairs.

Definite [working title] is a shell script utility that allows the user to record and recall term-definition pairs from the terminal. These scripts can be run with keyboard shortcuts.

Dependencies:
  - dialog
  - dmenu

Future goals:
  - reverse match: definition -> term using regex
  - add removal functionality
  - make sure empty terms or definitions can't be input
  - add functionality for terminal (w/o dialog)
  - tell user, upon attempt to recall, that pairs file is empty or nonexistent if necessary
