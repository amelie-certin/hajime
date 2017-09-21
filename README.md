# Hajime

## Configuration
- Ruby 2.4.1
- Rails 5.1.3
- SQLite

## Overcommit
Please install overcommit on your machine to avoid unconventional commits.
1. Run `bundle install`
2. Change your git user name to have a space character somewhere. Run a command like `git config user.name "Firstname Lastname"`
3. Run `overcommit --install`

## Rules
* This is a turn-based combat.
* A character can't hold more weapons than arms.
* A speed bonus is given to a character for each leg. But he must have enough focus to not fall flat on his face.
* Focus determines the attack precision.
* The character depresses if he has not enough charisma and let the opponent hurt him.
