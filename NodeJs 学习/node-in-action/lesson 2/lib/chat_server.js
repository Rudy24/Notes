const socketio = require('socket.io')
let io
let guestNumber = 1
let nickNames = {}
let namesUserd = {}
let currentRoom = {}

exports.listen = function (server) {
  io = socketio.listen(server)
  io.set('log level', 1)
  io.sockets.on('connection', function (socket) {
    guestNumber = assignGuestName(socket, guestNumber, nickNames, namesUserd)
    joinRoom(socket, 'Lobby')
    handleNameChnageAttempts(socket, nickNames, namesUserd)
    handleRoomJoining(socket)

    socket.on('rooms', function () {
      socket.emit('rooms', io.sockets.manager.rooms)
    })

    handleClientDisconnection(socket, nickNames, namesUserd)
  })
}

function assignGuestName(socket, guestNumber, nickNames, namesUserd) {
  const name = 'Guest' + guestNumber
  nickNames[socket.id] = name
  socket.emit('nameResult', {
    success: true,
    name: name
  })
  namesUserd.push(name)
  return guestNumber + 1
}

function joinRoom (socket, room) {
  socket.join(room)
  currentRoom[socket.id] = room
  socket.emit('joinResult', { room: room })
  socket.broadcase.to(room).emit('message', {
    text: nickNames[socket.id] + ' has joined ' + room + '.'
  })

  const usersInRoom = io.sockets.clients(room)
  if (usersInRoom.length > 1) {
    let usersInRoomSummary = 'Users currently in ' + room + ': '
    for (let index in usersInRoom) {
      let userSocketId = usersInRoom[index].id
      if (userSocketId !== socket.id) {
        if (index > 0) {
          usersInRoomSummary += ', '
        }
        usersInRoomSummary += nickNames[userSocketId]
      }
    }
    usersInRoomSummary += '.'
    socket.emit('message', {text: usersInRoomSummary})
  }
}