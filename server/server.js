const express = require("express");
const http = require("http");
const cors = require("cors");
const mongoose = require("mongoose");
require("dotenv").config();

const authRoutes = require("./routes/authRoutes");
const userRoutes = require("./routes/userRoutes");

const PORT = process.env.PORT || process.env.API_PORT;

const app = express();
app.use(express.json());
app.use(cors());

//Route Registry
app.use("/api/auth", authRoutes);
app.use("/api/user/", userRoutes);

//Create the server
const server = http.createServer(app);

const callController = require("./controllers/callController");

//Create the Socket.IO server
const IO = callController(server);

//Start the Socket.IO server
// IO.listen(() => {
//   console.log("Socket.IO server started");
// });


mongoose
    .connect(process.env.MONGO_URI, { useNewUrlParser: true, useUnifiedTopology: true})
    .then(() => {
        server.listen(PORT, () => {
            console.log(`Server is listening on ${PORT}`);
        });
    })
    .catch((err) => {
        console.log("database connection failed. Server not started");
        console.error(err);
    })

