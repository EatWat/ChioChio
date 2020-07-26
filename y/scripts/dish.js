// Your web app's Firebase configuration
var firebaseConfig = {
	apiKey: 'AIzaSyAEURaYtNCI_CNUyfksS5Jq73keYLo9ZWE',
	authDomain: 'eatwat-f5e10.firebaseapp.com',
	databaseURL: 'https://eatwat-f5e10.firebaseio.com',
	projectId: 'eatwat-f5e10',
	storageBucket: 'eatwat-f5e10.appspot.com',
	messagingSenderId: '316817346204',
	appId: '1:316817346204:web:99b76da8f36ab4b4efa759',
	measurementId: 'G-PFJLZPY5BX'
};
// Initialize Firebase

if (!firebase.apps.length) {
	firebase.initializeApp(firebaseConfig);
}

firebase.auth().onAuthStateChanged((user) => {
	if (user) {
		document.querySelectorAll('.logged-out').forEach((item) => (item.style.display = 'none'));
		document.querySelectorAll('.logged-in').forEach((item) => (item.style.display = 'block'));
	} else {
		document.querySelectorAll('.logged-out').forEach((item) => (item.style.display = 'block'));
		document.querySelectorAll('.logged-in').forEach((item) => (item.style.display = 'none'));
	}
});

// logout
document.querySelector('#logout').addEventListener('click', (e) => {
	e.preventDefault();
	firebase.auth().signOut();
	location.replace('index.html');
});

if (document.getElementById('form')) {
	document.getElementById('form').addEventListener('submit', (e) => {
		var name = document.getElementById('name').value;
		var description = document.getElementById('description').value;
		var price = Number(document.getElementById('price').value).toFixed(2);
		var photo = document.getElementById('photo').value;
		var availability = document.getElementById('availability').checked;
		e.preventDefault();
		if (name != '' && price != 0) {
			createTask(name, description, price, photo, availability);
			form.reset();
		}
		// account info

		document.querySelector('.account-details').innerHTML = `
      <div>Logged in as ${user.email}</div>
    `;
	});
}

function createTask(name, description, price, photo, availability) {
	var dish = {
		name: name,
		description: description,
		price: Number(price),
		photo: photo,
		availability: availability,
		foodStoreId: firebase.auth().currentUser.email
	};
	let db = firebase.firestore().collection('Dish/');
	db.add(dish).then(() => {
		Swal.fire('Good job!', 'Dish Added', 'success');
		document.getElementById('cardSection').innerHTML = '';

		readTask();
	});
}

function readTask() {
	firebase.firestore().collection('Dish').onSnapshot(function(snapshot) {
		document.getElementById('cardSection').innerHTML = '';
		snapshot.forEach(function(taskValue) {
			if (taskValue.data().foodStoreId == firebase.auth().currentUser.email) {
				document.getElementById('cardSection').innerHTML += `
              <div class="card mb-3">
                  <div class="card-body">
                  <table class="table table-borderless">
                  <thead>
                    <tr style="border: none;">
                      <th scope="col"></th>
                      <th scope="col"><h4>${taskValue.data().name}</h4>
                      </th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr style="border: none;">
                      <th scope="row">Description:</th>
                      <td>${taskValue.data().description}</td>
                    </tr>
                  </tbody>
                  <tbody>
                    <tr style="border: none;">
                      <th scope="row">Price:</th>
                      <td>$${taskValue.data().price}</td>
                    </tr>
                  </tbody>
                  <tbody>
                    <tr style="border: none;">
                      <th scope="row">Photo:</th>
                      <td><img src = "${taskValue.data().photo}" style="width:100%; height:auto;"></td>
                    </tr>
                  </tbody>
                  <tbody>
                    <tr style="border: none;">
                      <th scope="row">Availability:</th>
                      <td>${taskValue.data().availability}</td>
                    </tr>
                  </tbody>
                </table>
                      <button type="submit" style="color:white" class="btn btn-warning" 
                      onclick="updateTask('${taskValue.id}','${taskValue.data().name}',
                      '${taskValue.data().description}','${taskValue.data().price}', 
                      '${taskValue.data().photo}','${taskValue.data().availability}')">
                      <i class="fas fa-edit"></i> Edit Dish</button>
                      <button type="submit" class="btn btn-danger" onclick="deleteDish('${taskValue.id}')">
                      <i class="fas fa-trash-alt"></i> Delete Dish
                      </button>
                  </div>
                  </div>
                  `;
			}
		});
	});
}

function reset() {
	document.getElementById('firstSection').innerHTML = `
    <form class="border border-dark p-4 mb-4" id="form">
      <div class="form-group">
          <label>Dish name: </label>
          <input type="text" class="form-control" id="name" placeholder="Enter Dish Name:"></input>
      </div>

      <div class="form-group">
          <label>Description: </label>
          <textarea class="form-control" id="description" placeholder="Enter Description of The Dish:"></textarea>
      </div>

      <div class="form-group">
          <label>Price: </label>
          <input type="number" class="form-control" id="price" placeholder="Enter Dish Price:"></input>
      </div>

      <div class="form-group">
          <label>Photo: </label>
          <input type="text" class="form-control" id="photo" placeholder="(Optional) Enter Photo's Link:"></input>
      </div>

      <div class="form-group">
                        <input type="checkbox" class="custom-control-input" id="availability" checked style="display: inline-block;"> 
                        <label for="availability" class="custom-control-label">Availability: </label>
                    </div>

      <button type="submit" id="button1" class="btn btn-primary"><i class="fa fa-plus" aria-hidden="true"></i>Add Dish</button>
      <button style="display: none" id="button2" class="btn btn-success">Update Dish</button>
      <button style="display: none" id="button3" class="btn btn-danger">Cancel</button>
    </form>`;

	document.getElementById('form').addEventListener('submit', (e) => {
		var name = document.getElementById('name').value;
		var description = document.getElementById('description').value;
		var price = Number(document.getElementById('price').value).toFixed(2);
		var photo = document.getElementById('photo').value;
		var availability = document.getElementById('availability').checked;

		e.preventDefault();
		createTask(name, description, price, photo, availability);
		form.reset();
	});
}

function updateTask(id, name, description, price, photo, availability) {
	document.getElementById('firstSection').innerHTML = `<form class="border p-4 mb-4" id="form2">
      <div class="form-group">
          <label>Dish name: </label>
          <input type="text" class="form-control" id="name" placeholder="Enter Dish Name:"></input>
      </div>

      <div class="form-group">
          <label>Description: </label>
          <textarea class="form-control" id="description" placeholder="Enter Description of The Dish:"></textarea>
      </div>

      <div class="form-group">
          <label>Price: </label>
          <input type="number" class="form-control" id="price" placeholder="Enter Dish Price:"></input>
      </div>

      <div class="form-group">
          <label>Photo: </label>
          <input type="text" class="form-control" id="photo" placeholder="(Optional) Enter Photo's Link:"></input>
      </div>

      <div class="form-group">
                        <input type="checkbox" class="custom-control-input" id="availability" checked style="display: inline-block;"> 
                        <label for="availability" class="custom-control-label">Availability: </label>
                    </div>

      <button style="display: none" id="button1" class="btn btn-primary">Add Dish</button>
      <button type="submit" style="display: inline-block" id="button2" class="btn btn-success">
      <i class="fas fa-sunc"></i>Update Dish</button>
      <button style="display: inline-block" id="button3" class="btn btn-danger">
      <i class="fas fa-ban"></i>Cancel</button>
    </form>`;

	document.getElementById('form2').addEventListener('submit', (e) => {
		e.preventDefault();
	});

	document.getElementById('button3').addEventListener('click', (e) => {
		reset();
	});

	document.getElementById('button2').addEventListener('click', (e) => {
		updateTask2(
			id,
			document.getElementById('name').value,
			document.getElementById('description').value,
			Number(document.getElementById('price').value).toFixed(2),
			document.getElementById('photo').value,
			document.getElementById('availability').checked
		);
	});

	document.getElementById('name').value = name;
	document.getElementById('description').value = description;
	document.getElementById('price').value = Number(price).toFixed(2);
	document.getElementById('photo').value = photo;

	document.getElementById('availability').checked = availability;
}

function updateTask2(id, name, description, price, photo, availability) {
	var dishUpdated = {
		name: name,
		description: description,
		price: Number(price),
		photo: photo,
		availability: availability,
		foodStoreId: firebase.auth().currentUser.email
	};

	let db = firebase.firestore().collection('Dish').doc(id);
	db.set(dishUpdated).then(() => {
		Swal.fire('Good job!', 'Dish Updated', 'success');
	});
	document.getElementById('cardSection').innerHTML = '';
	readTask();
	reset();
}

function deleteDish(id) {
	firebase.firestore().collection('Dish').doc(id).delete().then(() => {
		Swal.fire('Good job!', 'Dish Deleted', 'success');
	});
	reset();
	document.getElementById('cardSection').innerHTML = '';
	readTask();
}
