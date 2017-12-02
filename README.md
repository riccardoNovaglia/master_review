#### What's this about?
I love to develop on trunk, I'm not a big fan of branches. At the same time, I think that Pull Requests are very useful for sharing knowledge with the rest of my team.  
This aims to be a really simple script that helps you to create a PR on Github, between any two commits on your master branch.


How I'd like to use this:

`master_review feature_name start_commit end_commit`
- Creates 2 branches. One starting from _start_commit_, one from _end_commit_
- Both branches are pushed to github
- A PR is created with title _Feature Name_
- A body for the PR is input
- The PR is created and immediately closed (no point it being open, the work is already in master)
- The two branches created to generate the PR are deleted
- A link to the PR is printed to the screen for sharing

What I'd like it to do in the future
- Integrate PR templates in the body input
- Maybe not add all commits. If the whole team works on trunk, not all commits will be relevant to a specific feature
- An easy way to pick start and end commit
