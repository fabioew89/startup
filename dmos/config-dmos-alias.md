show running-config hostname
config

alias ls
 expansion "show interface link | exclude Down"
!
alias ll
 expansion "show interface link"
!
alias ld
 expansion "show interface description | incl [A-Z]"
!
commit and-quit label alias comment "+ config alias by fabio"
!