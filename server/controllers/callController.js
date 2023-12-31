const { Server } = require("socket.io");

const callController = (server) => {
    const IO = new Server(server);
  
    IO.use((socket, next) => {
      if (socket.handshake.query) {
        let callerId = socket.handshake.query.callerId;
        socket.user = callerId;
        next();
      }
    });
  
    IO.on("connection", (socket) => {
      console.log(socket.user, "Connected");
      socket.join(socket.user);
  
      socket.on("makeCall", (data) => {
        let calleeId = data.calleeId;
        let sdpOffer = data.sdpOffer;
        console.log("testing out")
        socket.to(calleeId).emit("newCall", {
          callerId: socket.user,
          sdpOffer: sdpOffer,
        });
      });
  
      socket.on("answerCall", (data) => {
        let callerId = data.callerId;
        let sdpAnswer = data.sdpAnswer;
  
        socket.to(callerId).emit("callAnswered", {
          callee: socket.user,
          sdpAnswer: sdpAnswer,
        });
      });
  
      socket.on("IceCandidate", (data) => {
        let calleeId = data.calleeId;
        let iceCandidate = data.iceCandidate;
  
        socket.to(calleeId).emit("IceCandidate", {
          sender: socket.user,
          iceCandidate: iceCandidate,
        });
      });

      socket.on("chat", (data) => {
        let calleeId = data.calleeId;
        let msg = data.msg;
  
        socket.to(calleeId).emit("chat", {
          sender: socket.user,
          msg: msg,
        });
      });
    });
  
    return IO;
  };
  
  module.exports = callController;