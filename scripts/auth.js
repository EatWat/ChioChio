// Your web app's Firebase configuration
var firebaseConfig = {
  apiKey: "AIzaSyAEURaYtNCI_CNUyfksS5Jq73keYLo9ZWE",
  authDomain: "eatwat-f5e10.firebaseapp.com",
  databaseURL: "https://eatwat-f5e10.firebaseio.com",
  projectId: "eatwat-f5e10",
  storageBucket: "eatwat-f5e10.appspot.com",
  messagingSenderId: "316817346204",
  appId: "1:316817346204:web:99b76da8f36ab4b4efa759",
  measurementId: "G-PFJLZPY5BX"
};
// Initialize Firebase

if (!firebase.apps.length) {
  firebase.initializeApp(firebaseConfig);
}
  
const homeContent = document.querySelector('.home');

// listen for auth status changes
auth.onAuthStateChanged(user => {
    if (user) {
      homeContent.innerHTML = `

      <div class="row">
      <div class="col-md-6" id="firstSection">
          <form class="border p-4 mb-4" id="form"> 
              <div class="form-group">
                  <label>Dish name: </label>
                  <input type="text" class="form-control" id="name" placeholder="Enter Dish Name:" required></input>
              </div>

              <div class="form-group">
                  <label>Description: </label>
                  <textarea class="form-control" id="description" placeholder="Enter Description of The Dish:"></textarea>
              </div>

              <div class="form-group">
                  <label>Price: </label>
                  <input type="number" class="form-control" id="price" placeholder="Enter Dish Price:" required></input>
              </div>

              <div class="form-group">
                  <label>Photo Link: </label>
                  <input type="text" class="form-control" id="photo" placeholder="(Optional) Enter Photo's Link:"></input>
              </div>

              <div class="form-group">
                  <label>Availability: </label>
                  <input type="checkbox" class="form-control" id="availability" checked=true></input>
              </div>

              <button type="submit" id="button1" class="btn btn-primary"><i class="fa fa-plus" aria-hidden="true"></i>Add Dish</button>
              <button style="display: none" id="button2" class="btn btn-success">Update Dish</button>
              <button style="display: none" id="button3" class="btn btn-danger">Cancel</button>

          </form>
          
      </div>

      <div class="col-md-6" id="cardSection">
      </div>
      

  </div>`;
      setupUI(user);
    } else {
      homeContent.innerHTML = '<h5 class="center-align">Please Login to Access All Features</h5>';
      setupUI();
    }
})
  
// signup
const signupForm = document.querySelector('#signup-form');
signupForm.addEventListener('submit', (e) => {
  e.preventDefault();
  
  // get user info
  const email = signupForm['signup-email'].value;
  const password = signupForm['signup-password'].value;
  // for database
  const userName = signupForm['signup-username'].value;
  var newUser={
    email: email,
    password: password,
    userName: userName,
    point: 0.0,
    role: "vendor",
  }
  let db = firebase.firestore().collection("User/");
  db.add(newUser);
  if(auth.user != null) {
    console.log("yay");
  }

  // sign up the user
  auth.createUserWithEmailAndPassword(email, password).then(cred => {
    // close the signup modal & reset form
    const modal = document.querySelector('#modal-signup');
    M.Modal.getInstance(modal).close();
    signupForm.reset();
  });

});

// logout
const logout = document.querySelector('#logout');
logout.addEventListener('click', (e) => {
  e.preventDefault();
  auth.signOut();
});

// login
const loginForm = document.querySelector('#login-form');
loginForm.addEventListener('submit', (e) => {
  e.preventDefault();
  
  // get user info
  const email = loginForm['login-email'].value;
  const password = loginForm['login-password'].value;

  // log the user in

  auth.signInWithEmailAndPassword(email, password).then((cred) => {
    // close the signup modal & reset form
    const modal = document.querySelector('#modal-login');
    M.Modal.getInstance(modal).close();
    loginForm.reset();
  });

});