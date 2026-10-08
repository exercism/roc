# Instructions Append

## Date and time support

The [`roc-isodate` package](https://github.com/ageron/roc-isodate) is included in the app's header in `swift-scheduling-test.roc`, so you can use it in your code.

## Hints

<details>
<summary>Show hints</summary>

Try importing `isodate.Date` and `isodate.DateTime`.
`DateTime.from_iso_str` parses the input, while `format`, `add_days`, and `add_hours` help construct the output.
The library's `weekday()` uses `0` for Sunday and `6` for Saturday.
`Date.days_in_month` handles varying month lengths and leap years.

</details>
