#!/usr/bin/osascript

on run argv
    if length of argv = 1 then
        display notification (item 1 of argv) with title "Notification"
    else if length of argv > 1 then
        display notification (item 1 of argv) with title (item 2 of argv)
    else
        return "<message> is required\nUsage: notify <message> [<title>]"
    end if
end run
