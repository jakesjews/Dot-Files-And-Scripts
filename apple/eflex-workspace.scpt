tell application "iTerm"
  activate
  
  if (count of terminal) = 0 then make new terminal
  
  set eflex_dir to "/users/jacob/dev/eflexsystems/eflex/"
  
  my open_tab("zsh", "cd " & eflex_dir)
  my open_tab("Mongodb", "mongod")
  my open_tab("Redis", "redis-server /usr/local/etc/redis.conf")
  my open_tab("Zookeeper", "zkServer start-foreground")
  my open_tab("Brunch", "cd " & eflex_dir & "webApp && ./run.sh")
  
end tell

on open_tab(title, command)
  tell application "iTerm" to tell first terminal
    launch session "Default"
    tell last session
      write text command
      set name to title
    end tell
  end tell
end open_tab

tell application "Robomongo"
  activate
end tell

tell application "Xamarin Studio"
  activate
  open "/Users/jacob/dev/eflexsystems/eflex/EFlex.sln"
end tell

delay 5

tell application "System Events"
  tell application "Xamarin Studio" to activate
  key code 36 using command down
end tell

tell application "Sublime Text 2"
  activate
end tell

delay 5

tell application "System Events"
  tell application "Sublime Text 2" to activate
  tell process "Sublime Text 2"
    tell menu bar item "Project" of menu bar 1
      tell menu item "Recent Projects" of menu "Project"
        tell menu "Recent Projects"
          click menu item "~/dev/eflexsystems/eflex/eflex.sublime-project"
        end tell
      end tell
    end tell
  end tell
end tell

tell application "Google Chrome"
  activate
  set URL of active tab of window 1 to "http://localhost:3333"
end tell

tell application "System Events"
  tell application "Google Chrome" to activate
  key code 34 using {command down, option down}
end tell

tell application "Moom"
  arrange windows according to snapshot named "eFlex"
end tell
