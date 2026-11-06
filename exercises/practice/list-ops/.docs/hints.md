# Hints

## General

- Try using:

  ```roc
  match list {
      [] => ...
      [first, .. as rest] => ...
  }
  ```

  or

  ```roc
  match list {
      [] => ...
      [.. as rest, last] => ...
  }
  ```
