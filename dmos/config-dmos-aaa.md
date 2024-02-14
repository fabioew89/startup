config
aaa authentication-order [ local tacacs ]
aaa server tacacs SERVER-TACACS
host 143.137.92.114
authentication
authorization
accounting
shared-secret $7$kAPMAXqGDgvx0t27r6JLplKkSoMD/Kvx
top
!
commit and-quit label aaa comment "+ config aaa by fabio"
!