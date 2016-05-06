# Contributing to Docker-Clean

## Team members

* [Killian Brackey](https://github.com/killianbrackey) killian@zzrot.com T: [@kmbrackey](https://twitter.com/kmbrackey)
* [Sean Kilgarriff](https://github.com/Skilgarriff) sean@zzrot.com T: [@seankilgarriff](https://twitter.com/SeanKilgarriff)

Don't hesitate to get in contact with either one of us with problems, questions, etc.


## Adding new features

* Fork it!
* Create your feature branch: git checkout -b my-new-feature
* Commit your changes: git commit -am 'Add some feature'
* Push to the branch: git push origin my-new-feature
* Submit a pull request :D

## ShellCheck

We use ShellCheck to keep our code consistent and readable. Any feature pushed that does not pass a ShellCheck will fail on Travis build, and thus we cannot accept the pull request. Please lint your code before submitting it! :).

(Keep in mind that bats does not have to be ShellChecked, and thus if you are adding tests to .bats don't worry about linting.)

You can either download the ShellCheck program: https://github.com/koalaman/shellcheck or use the ShellCheck website: http://www.shellcheck.net/


Don’t get discouraged! We estimate that the response time from the
maintainers is around: 24 hours.
