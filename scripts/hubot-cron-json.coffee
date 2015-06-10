# Description:
#   Register cron jobs from json file
#
# Commnads:
#   hubot cron list - List all cron msg/events
#
# Author
#   tcnksm <https://github.com/tcnksm>
#

Cron = require('cron').CronJob
Fs   = require 'fs'
Path = require 'path'

module.exports = (robot) ->

  # Hipchat room for send
  user = process.env.HUBOT_HIPCHAT_ROOMS.split(",").map (word) -> { room: word }

  # Read cron setting from cron-msg.json
  cronTask = new CronTask(robot, user)
  cronTask.setAll()
  
  # Say all cron tasks
  robot.respond /cron (list|ls)/i, (msg) ->
    cronTask.list()

                
class CronTask

  constructor: (@robot,@user) ->

  read: (cb) ->
    configFilePath = Path.resolve ".", "conf", "cron-tasks.json"
    Fs.exists configFilePath, (exists) =>
      if exists
        Fs.readFile configFilePath, (err, data) =>
          if data.length > 0
            cb JSON.parse data
          else
            for r in @user
              @robot.send r['room'], "Definition file is empty: " + configFilePath
      else
        for r in @user
          @robot.send r['room'], "Definition file not found: " + configFilePath

  list: ->
    @read (tasks) =>
      for t in tasks
        if t['msg']?
          for r in @user
            @robot.send r['room'], 'Tell ' + t['msg'] + ' at ' + t['time']
        
        if t['event']?
          for r in @user
            @robot.send r['room'], 'Emit ' + t['event'] + ' at ' + t['time']

  setAll: ->
    @read (tasks) =>
      for t in tasks
        if t['msg']?
          @setMsg(t['time'],t['msg'])
        
        if t['event']?
          @setEvent(t['time'], t['event'])

  setMsg: (time, msg) ->
    new Cron(time, () =>
      for r in @user
        @robot.send r['room'], msg
    ).start()
    console.log('Set cron msg, ' + msg + ' at ' + time)

  setEvent: (time, event) ->
    new Cron(time, () =>
      @robot.emit event
    ).start()
    console.log('Set cron event, ' + event + ' at ' + time)


