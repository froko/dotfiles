# Taskwarrior

[Taskwarrior](https://taskwarrior.org/) is my preferred task manager.

## CLI Reference

- `task`: Lists all active tasks
- `task all`: Lists all tasks in all states
- `task add Buy milk`: Adds a new task with the description "Buy milk"
- `task add Clean kitchen +home`: Adds a new task with the description "Clean
  kitchen" and the tag "home"
- `task add Prepare presentation project:Conference +work`: Adds a new task with
  the description "Prepare presentation", the project "Conference" and the tag
  "work"
- `task +work`: Lists all tasks with the tag "work"
- `task project:Conference`: Lists all tasks with the project "Conference"
- `task 1 done`: Completes the task with ID 1
- `task 2 modify due:today`: Marks the task with ID 2 due today
- `task 2 modify -work +private project:TedTalk`: Changes the attributes of task
  with ID2 (remove tag "work", add tag "private", change project to "TedTalk")
- `task 1 delete`: Delets the task with ID 1 but keeps it still in the database
- `task 1 purge`: Removed the task with Id 1 completely
- `task sync`: Synchronizes all tasks with a central instance

## Task Synchronization

Taskwarrior has an integrated sync mechanism which is described
[here](https://taskwarrior.org/docs/man/task-sync.5/)

Here's a step-by-step guide for the Google Cloud Platform. It's assumed that you
already have a Google account:

- Log into the [Google Cloud Console](https://console.cloud.google.com/)
- Create a new project named e.g. "taskwarrior-sync"
- Within this project create a new storage bucket with a globally unique name,
  e.g. "mysync-4711"
- The default values of the wizard are good enough - you may want to chose a
  region near your location for performance reasons.
- Download the gCloud CLI using `brew install --cask gcloud-cli`
- Log in using `gcloud auth application-default login`
- Select your project using `gcloud config set project taskwarrior-sync`
- Prepare 2 passwords with `pwgen`
- **Important** Prevent change tracking for the sync file:

  `cd ~/dotfiles && git update-index --assume-unchanged task/.config/task/taskrc.sync`

- Edit the sync file like this:

  ```
  sync.backend=gcp
  sync.encryption_secret=<Your first password>
  sync.gcp.bucket=mysync-4711
  sync.secret=<Your second password>
  ```

- To synchronize tasks with other computers, make sure all have the same sync
  file content and don't forget to prevent the change tracking of the sync file
  in all of your dotfile clones.
