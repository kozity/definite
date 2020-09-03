# definite
Record and recall term-definition pairs.

Definite [working title] is a shell script utility that allows the user to record and recall term-definition pairs from the terminal. These scripts can be run with keyboard shortcuts.

Implementations:
  - Shell, dialog, dmenu
  - Shell, dialog
  - Shell
  - C

Future goals:
  - reverse match: definition -> term using regex
  - possibly add functionality for terminal (w/o dialog)
  - tell user, upon attempt to recall, that pairs file is empty or nonexistent if necessary
    - handle file i/o better in general
  - upon entering a duplicate (record) or nonexistent (recall) term, offer user opportunity to edit or create definition
  - C implementation: add sorting when existing pairs are listed

Edge cases (marked with (x) if it is, to my knowledge, handled):
  - [x] empty recall string
  - [x] empty record string for term
  - [x] empty record string for definition
  - [x] duplicate term
  - [x] nonexistent recall request
  - [x] strip leading and trailing whitespace

Known issues:
  - none :) (but tell me if you discover otherwise)

Do anything you want with this source code and call it anything you'd like.
