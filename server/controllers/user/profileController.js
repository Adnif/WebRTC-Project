  const User = require("../../models/user");

  function getUser(req, res) {
      const userId = req.user.userId; // Assuming your JWT payload includes user ID
    
      // Fetch user data from database
      User.findById(userId)
          .then(user => {
              if (!user) {
                return res.status(404).json({ message: 'User not found.' });
              }
              // Send user credentials
              const { username, phonenum, _id, friends,  /* other credentials */ } = user;
              res.json({ username, phonenum,  _id, friends, /*, other credentials */ });
            })
            .catch(err => {
              console.error(err);
              res.status(500).json({ message: 'Error fetching user data.' });
            });
  }

  function addFriend(req, res){
    const userId = req.user.userId;
    const { phonenum }  = req.body;

    User.findById(userId)
        .then(user => {
          if(!user){
            return res.status(404).json({ message: 'User not found' });
          }

          console.log('ini nomor telepon : ' + phonenum);
          console.log(userId);
          User.findOne({ phonenum: phonenum })
              .then(friend => {
                if(!friend){
                  
                  return res.status(404).json({ message: 'Friend not found'});
                }

                if(user.friends.includes(friend._id)){
                  return res.status(400).json({ message: 'Friend already added.' });
                }

                let friended = {...friend._doc};
                delete friended.friends;

                console.log("ini setelah coba delete: " + friended);
                user.friends.push(friended);

                user.save()
                    .then(updatedUser => {
                      const { username, phonenum, _id, friends } = updatedUser;
                      res.json({ username, phonenum, _id, friends});
                    })
                    .catch(err => {
                      console.error(err);
                      res.status(500).json({ message: 'Error saving user data.'})
                    })
              })
              .catch(err => {
                console.error(err);
                res.status(500).json({ message: 'Error finding friend' });
              });
        })
        .catch(err => {
          console.error(err);
          res.status(500).json({ message: 'Error fetching user data.' });
        })


  }
    
    
    module.exports = { getUser, addFriend }