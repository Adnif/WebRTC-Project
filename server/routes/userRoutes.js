const express = require("express");
const router = express.Router();
const { getUser, addFriend } = require("../controllers/user/profileController");
const auth = require("../middleware/auth");

router.get(
    "/getUser",
    auth,
    getUser
)

router.post(
    "/addFriend",
    auth,
    addFriend
)


module.exports = router;