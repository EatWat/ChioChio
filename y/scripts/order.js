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
readCompletedOrder();


function readNewOrder() {
    firebase.firestore().collection("Order").onSnapshot(function(snapshot) {
        document.getElementById("NewOrderSection").innerHTML="<h4>New Orders| Accept Now</h4></br>";
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
            `<p class="NewOrder-price">Total Price: ${taskValue.data().totalPrice}</p>
           
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
        document.getElementById("CompleteOrderSection").innerHTML="<h4>Accepted Orders | Cook Now</h4></br>";
        snapshot.forEach(function(taskValue){
          if(taskValue.data().foodStoreId == firebase.auth().currentUser.email && taskValue.data().status == 2){
            document.getElementById("CompleteOrderSection").innerHTML+= 
              `<div class="CompleteOrder mb-3">
                  <div class="CompleteOrder-body">
                      <p class="CompleteOrder-customer">Customer id: ${taskValue.data().userId}</h5>
                      <p class="CompleteOrder-orderid">Order id: ${taskValue.id}</h5>`;
            for (i = 0; i < taskValue.data().dishes.length; i++) {
                document.getElementById("CompleteOrderSection").innerHTML+= `
                <p class="CompleteOrder-dish">Dish: ${taskValue.data().dishes[i].name}</p>
                <p class="CompleteOrder-quantity">Quantity: ${taskValue.data().dishes[i].quantity}</p>`
            }
            document.getElementById("CompleteOrderSection").innerHTML+= 
            `<p class="CompleteOrder-price">Total Price: ${taskValue.data().totalPrice}</p>
           
            <button type="submit" style="color:white" class="btn btn-primary" 
                      onclick="complete('${taskValue.id}')">Order Ready</button>
            
            <p>-----------------------------------------------</p>
            </div>
                  </div>`    
                  
          }
        });
    });
  }

  function complete(id) {
    let db = firebase.firestore().collection("Order").doc(id);
    db.update({
    "status": 4,
  });
}

function readCompletedOrder() {
    firebase.firestore().collection("Order").onSnapshot(function(snapshot) {
        document.getElementById("AcceptedOrderSection").innerHTML="<h4>Wait for Collection & Payment</h4></br>";
        snapshot.forEach(function(taskValue){
          if(taskValue.data().foodStoreId == firebase.auth().currentUser.email && taskValue.data().status == 4){
            document.getElementById("AcceptedOrderSection").innerHTML+= 
              `<div class="AcceptedOrder mb-3">
                  <div class="AcceptedOrder-body">
                      <p class="AcceptedOrder-customer">Customer id: ${taskValue.data().userId}</h5>
                      <p class="AcceptedOrder-orderid">Order id: ${taskValue.id}</h5>`;
            for (i = 0; i < taskValue.data().dishes.length; i++) {
                document.getElementById("AcceptedOrderSection").innerHTML+= `
                <p class="AcceptedOrder-dish">Dish: ${taskValue.data().dishes[i].name}</p>
                <p class="AcceptedOrder-quantity">Quantity: ${taskValue.data().dishes[i].quantity}</p>`
            }
            document.getElementById("AcceptedOrderSection").innerHTML+= 
            `<p class="AcceptedOrder-price">Total Price: ${taskValue.data().totalPrice}</p>
           
            <button type="submit" style="color:white" class="btn btn-warning" 
                      onclick="paid('${taskValue.id}')">Order Completed</button>
            
            <p>-----------------------------------------------</p>
            </div>
                  </div>`    
                  
          }
        });
    });
  }

  function paid(id) {
    let db = firebase.firestore().collection("Order").doc(id);
    db.update({
    "status": 5,
  });
}