# definite
Record and recall term-definition pairs.

Definite [working title] is a shell script utility that allows the user to record and recall term-definition pairs from the terminal. These scripts can be run with keyboard shortcuts.

Dependencies:
  - dialog
  - dmenu

Future goals:
  - reverse match: definition -> term using regex
  - possibly add functionality for terminal (w/o dialog)
  - tell user, upon attempt to recall, that pairs file is empty or nonexistent if necessary
    - handle file i/o better in general

Edge cases (marked with (x) if it is, to my knowledge, handled:
  - (x) empty recall string
  - (x) empty record string for term
  - (x) empty record string for definition
  - (x) duplicate term
  - (x) nonexistent recall request
  - (x) strip leading and trailing whitespace

Do anything you want with this source code and call it anything you'd like. I think it's cool and useful.
