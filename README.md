hubot-cron-json [![NPM](https://badge.fury.io/js/hubot-cron-json.svg)](https://www.npmjs.org/package/hubot-cron-json) [![MIT License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat)](https://github.com/tcnksm/hubot-cron-json/blob/master/LICENCE)
====

Manage hubot cron job defined by json configuration file

## Configuration

All you need to do is just creating `./conf/cron-tasks.json`:

```json
[
    {
        "time" : "0 30 9 * * 1-5 ",
        "msg" : "Good morning ! Let's start morning meeting !"
    },
    {
        "time": "0 45 17 * * 5 ",
        "event": "sample:task"
    }
]
```

`hubot-cron-json` automatically read configuration file and execute job when it's `time` to do. `time` syntax follows ordinal cron syntax, See [http://crontab.org/](http://crontab.org/). 

You can define 2 types of task:

- `mgs` - Just say it to your room.
- `event` - Emit event and another hubot task get it and execute somethig.

And you can check all cron jobs:

```
hubot cron list
```

## Install

To install, use `npm`:

```bash
$ npm install --save hubot-cron-json
```

And add `hubot-cron-json` to your `external-scripts.json`.

## VS.

- [miyagawa/hubot-cron](https://github.com/miyagawa/hubot-cron)
- [hubot-scripts/remind.coffee](https://github.com/github/hubot-scripts/blob/master/src/scripts/remind.coffee)

These are cool scripts which also manages cron jobs. But for storing jobs, they depend `robot.brain` (Redis). `hubot-cron-json` manage cron job by json configuraiton file. It's very easy to share same cron jobs to another team's hubot and to run anywhere without job setting. And `hubot-cron-json` can manage not only saying something to room but emitting `event` to invorke another hubot tasks.

## Contribution

1. Fork ([https://github.com/tcnksm/hubot-cron-json/fork](https://github.com/tcnksm/hubot-cron-json/fork))
1. Create a feature branch
1. Commit your changes
1. Rebase your local changes against the master branch
1. Create new Pull Request

## Author

[tcnksm](https://github.com/tcnksm)
