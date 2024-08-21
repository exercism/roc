# Tests

To download an exercise, for example `hello-world`, open a terminal and run:

```bash
exercism download --track roc --exercise hello-world
```

Then go to the exercise directory and edit the code to solve the exercise. For example:

```bash
cd {your Exercism folder}/roc/hello-world
edit HelloWorld.roc
```

Each exercise comes with a test suite. You can run the tests using the `roc test` command, for example:

```
roc test hello-world-test.roc
```

If you've solved the exercise, you should see 0 failed test, for example:

```
0 failed and 1 passed in 583 ms.
```

However, if your code has any errors, they will look like this:

```
── EXPECT FAILED in hello-world-test.roc ───────────────────────────────────────

This expectation failed:

6│  expect hello == "Hello, World!"
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


1 failed and 0 passed in 1264 ms.
```

This should help you fix your code. Once your code works, you can submit it using the `exercism submit` command (see `HELP.md` in the exercise directory for more details).
