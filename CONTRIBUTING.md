## Contribution Guide
* Recommended to have `forked` master branch to be updated to upstream.
* Configure [Syncing a fork](https://help.github.com/articles/configuring-a-remote-for-a-fork/).
  - `git remote add upstream https://github.com/hyochan/bookoo2`
  - Check it with `git remote -v`
* Fetch the branches from upstream repository by `git fetch upstream`
* When you want to give `PR`, make new branch `git checkout -b [feature_name]`
  - Before pushing `PR`, do `git fetch upstream` from master branch then try the rebase by `git rebase master`
  - Check your status by `git log --decorate --oneline --all --graph` or `npm run git:log`

### Issue
* Please search and register if you already have the issue you want to create. If you have a similar issue, you can add additional comments.
* Please write a problem or suggestion in the issue. Never include more than one item in an issue.
* Please be as detailed and concise as possible.
	* If necessary, please take a screenshot and upload an image.

### Pull request(PR)
* PR is available to `master` branch.
