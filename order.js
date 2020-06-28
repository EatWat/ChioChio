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

  firebase.auth().onAuthStateChanged(user => {
    if (user) {
      document.querySelectorAll('.logged-out').forEach(item => item.style.display = 'none');
      document.querySelectorAll('.logged-in').forEach(item => item.style.display = 'block');
    } else {
      document.querySelectorAll('.logged-out').forEach(item => item.style.display = 'block');
      document.querySelectorAll('.logged-in').forEach(item => item.style.display = 'none');
    }
})

// logout
document.querySelector('#logout').addEventListener('click', (e) => {
    e.preventDefault();
    firebase.auth().signOut();
    location.replace("index.html");
  });

readNewOrder();
readAcceptedOrder();

function readNewOrder() {
    firebase.firestore().collection("Order").onSnapshot(function(snapshot) {
        document.getElementById("NewOrderSection").innerHTML="<h4>New Orders</h4></br>";
        snapshot.forEach(function(taskValue){
          if(taskValue.data().foodStoreId == firebase.auth().currentUser.email && taskValue.data().status == 1){
            document.getElementById("NewOrderSection").innerHTML+= 
              `<div class="NewOrder mb-3">
                  <div class="NewOrder-body">
                      <p class="NewOrder-customer">Customer id: ${taskValue.data().userId}</h5>
                      <p class="NewOrder-orderid">Order id: ${taskValue.id}</h5>`;
            for (i = 0; i < taskValue.data().dishes.length; i++) {
                document.getElementById("NewOrderSection").innerHTML+= `
                <p class="NewOrder-dish">Dish: ${taskValue.data().dishes[i].name}</p>
                <p class="NewOrder-quantity">Quantity: ${taskValue.data().dishes[i].quantity}</p>`
            }
            document.getElementById("NewOrderSection").innerHTML+= 
            `<p class="NewOrder-price">Price: ${taskValue.data().totalPrice}</p>
           
            <button type="submit" style="color:white" class="btn btn-warning" 
                      onclick="accept('${taskValue.id}')">Accept Order</button>
            <button type="submit" class="btn btn-danger" onclick="reject('${taskValue.id}')">
            Reject Order
            </button>
            <p>-----------------------------------------------</p>
            </div>
                  </div>`    
                  
          }
        });
    });
  }

function accept(id) {
    let db = firebase.firestore().collection("Order").doc(id);
    db.update({
    "status": 2,
  });

}

function reject(id) {
    let db = firebase.firestore().collection("Order").doc(id);
    db.update({
    "status": 3,
  });
}

function readAcceptedOrder() {
    firebase.firestore().collection("Order").onSnapshot(function(snapshot) {
        document.getElementById("AcceptedOrderSection").innerHTML="<h4>New Orders</h4></br>";
        snapshot.forEach(function(taskValue){
          if(taskValue.data().foodStoreId == firebase.auth().currentUser.email && taskValue.data().status == 1){
            document.getElementById("AcceptedOrderSection").innerHTML+= 
              `<div class="NewOrder mb-3">
                  <div class="NewOrder-body">
                      <p class="NewOrder-customer">Customer id: ${taskValue.data().userId}</h5>
                      <p class="NewOrder-orderid">Order id: ${taskValue.id}</h5>`;
            for (i = 0; i < taskValue.data().dishes.length; i++) {
                document.getElementById("NewOrderSection").innerHTML+= `
                <p class="NewOrder-dish">Dish: ${taskValue.data().dishes[i].name}</p>
                <p class="NewOrder-quantity">Quantity: ${taskValue.data().dishes[i].quantity}</p>`
            }
            document.getElementById("NewOrderSection").innerHTML+= 
            `<p class="NewOrder-price">Price: ${taskValue.data().totalPrice}</p>
           
            <button type="submit" style="color:white" class="btn btn-warning" 
                      onclick="accept('${taskValue.id}')">Accept Order</button>
            <button type="submit" class="btn btn-danger" onclick="reject('${taskValue.id}')">
            Reject Order
            </button>
            <p>-----------------------------------------------</p>
            </div>
                  </div>`    
                  
          }
        });
    });
  }