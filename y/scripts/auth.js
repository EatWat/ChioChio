
  
const homeContent = document.querySelector('.home');

// listen for auth status changes
auth.onAuthStateChanged(user => {
    if (user) {
      homeContent.innerHTML = '<h5 class="center-align">Welcome</h5>';
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

  // sign up the user
  auth.createUserWithEmailAndPassword(email, password).then(() => {
    // close the signup modal & reset form
    const modal = document.querySelector('#modal-signup');
    M.Modal.getInstance(modal).close();
    signupForm.reset();
    signupForm.querySelector('.error').innerHTML = "";
  }).catch(err => {
    signupForm.querySelector('.error').innerHTML = err.message;
  });

  // then(cred => {
  //   return db.collection('Users').doc(cred.user.uid).set({
     
  //     userName: signupForm['signup-username'].value
    
  //   });
  // }).
  

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
    loginForm.querySelector('.error').innerHTML = "";
  }).catch(err => {
    loginForm.querySelector('.error').innerHTML = err.message;
  });

});