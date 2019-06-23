// let dayMonthYearDate;
// let time;
let number;
let elementForCurrentDelete;
let elementForCurrentEdit;

// Select the Elements
const clear = document.querySelector(".clear");
const list = document.getElementById("list");
const input = document.getElementById("input");

// Classes names
const CHECK = "filters__center-bgColor";
const UNCHECK = "";
const BG = "tasks-bgColor";
const BGNONE = "";

// Variables  Переменные
let LIST, id;

// Вычислаем дату и время
function getFormattedDate() {
  let date = new Date();
  let year = date.getFullYear();

  let month = (1 + date.getMonth()).toString();
  month = month.length > 1 ? month : "0" + month;

  let day = date.getDate().toString();
  day = day.length > 1 ? day : "0" + day;

  return day + "." + month + "." + year;
}

function getFormattedTime() {
  let date = new Date();

  let hour = date.getHours().toString();
  hour = hour.length > 1 ? hour : "0" + hour;

  let minutes = date.getMinutes().toString();
  minutes = minutes.length > 1 ? minutes : "0" + minutes;

  return hour + ":" + minutes;
}

number = 1;

// get item from localstorage получить из localstorage
let data = localStorage.getItem("TODO");

// проверяем, если данные не пусты
if (data) {
  LIST = JSON.parse(data);
  id = LIST.length; // устанавливаем id на последний в списке
  loadList(LIST); // загрузить список в пользовательский интерфейс
} else {
  // если данные  пусты
  LIST = [];
  id = 0;
}

// load items to the user's interface, загружать элементы в интерфейс пользователя
function loadList(array) {
  array.forEach(function(item) {
    addToDo(
      item.dates,
      item.times,
      item.numbers,
      item.name,
      item.id,
      item.done,
      item.trash
    );
  });
}

// clear the local storage
clear.addEventListener("click", function() {
  localStorage.clear();
  location.reload();
});

// add to do function
function addToDo(dates, times, numbers, toDo, id, done, trash) {
  if (trash) {
    return;
  }

  const DONE = done ? CHECK : UNCHECK;
  const DONETASK = done ? BG : BGNONE;

  const text = `<li class="center__items" id="items-${id}">
             <div class="dateTime">
                <div class="date">${dates}</div>
                <div class="time">${times}</div>
            </div>
            <div class="number">${number}</div>
                <div class="scrolling">
                <p><i class="fas fa-angle-up"></i></p>
                   <i class="fas fa-angle-down"></i>
                </div>
                <div class="tasks ${DONETASK}">${toDo}</div>
            <div class="filters">
                <div class="filters__left"><i class="fas fa-pencil-alt" title="edit" id="${id}"></i></div>
                <div class="filters__center ${DONE}"><i class="fas fa-check" title="complete" id="${id}"></i></div>
                <div class="filters__right"><i class="fas fa-trash-alt" title="delete" id="${id}"></i></div>
            </div>
            <div class="separator"></div>
        </li>
        <!-- /.center__items -->
                `;

  const position = "afterbegin";
  list.insertAdjacentHTML(position, text);
}

// добавить элемент в список пользователя клавишей ввода, add an item to the list user the enter key
// document.addEventListener("keyup",function(even){
//     if(event.keyCode == 13 ){
//add = document.getElementById('add');
document.getElementById("add").onclick = function() {
  const toDo = input.value;

  // if the input isn't empty, если не пусто
  if (toDo) {
    addToDo(
      getFormattedDate(),
      getFormattedTime(),
      number,
      toDo,
      id,
      false,
      false
    );

    LIST.push({
      dates: getFormattedDate(),
      times: getFormattedTime(),
      numbers: number,
      name: toDo,
      id: id,
      done: false,
      trash: false
    });

    // add item to localstorage ( this code must be added where the LIST array is updated)
    // добавить элемент в localstorage
    localStorage.setItem("TODO", JSON.stringify(LIST));

    id++;
    input.value = "";
  } else {
    alert("Введите хоть 1 символ!");
  }
};

// показать окно Edit
function openPopupToEdit(element) {
  elementForCurrentEdit = element;
  document.getElementById("edit").classList.toggle("display-none");
  // elementForCurrentEdit.parentElement.parentElement.
  let task =
    elementForCurrentEdit.parentElement.parentElement.previousElementSibling
      .innerText;
  let input = document.querySelector("#edit input");
  input.value = task;
}

//функция редактирования
function editToDo() {
  // document.getElementById('list').removeChild(document.getElementById(`item-${elementForCurrentEdit.id}`));
  // element.parentNode.parentNode.removeChild(element.parentNode);
  const text = document.querySelector("#edit input").value;
  LIST[elementForCurrentEdit.id].name = text;
  document.querySelector(
    `#items-${elementForCurrentEdit.id} .tasks`
  ).innerText = text;
  localStorage.setItem("TODO", JSON.stringify(LIST));
  document.getElementById("edit").classList.toggle("display-none");
}

// спрятать окно Edit
function closePopupEdit() {
  elementForCurrentEdit = {};
  document.getElementById("edit").classList.toggle("display-none");
}

// complete to do, выполнено
function completeToDo(element) {
  element.classList.toggle(CHECK);
  // element.classList.toggle(UNCHECK);
  const textElement =
    element.parentElement.parentElement.previousElementSibling;
  textElement.classList.toggle(BG);
  // element.classList.toggle(BGNONE);
  //    LIST[element.id].done = LIST[element.id].done ? false : true;
  LIST[element.id].done = !LIST[element.id].done;
}

// показать окно delete
function openPopupToDelete(element) {
  elementForCurrentDelete = element;
  document.getElementById("delete").classList.toggle("display-none");
}

//remove to do, удалить, функция удаления
function removeToDo() {
  document
    .getElementById("list")
    .removeChild(document.getElementById(`items-${elementForCurrentDelete.id}`));
  // element.parentNode.parentNode.removeChild(element.parentNode);
  LIST[elementForCurrentDelete.id].trash = true;
  // add item to localstorage ( this code must be added where the LIST array is updated)
  // добавить элемент в localstorage (этот код должен быть добавлен при обновлении массива LIST)
  localStorage.setItem("TODO", JSON.stringify(LIST));
  document.getElementById("delete").classList.toggle("display-none");
}

// спрятать окно Delete
function closePopupDelete() {
  elementForCurrentDelete = {};
  document.getElementById("delete").classList.toggle("display-none");
}

// target the items created dynamically, целевые элементы, созданные динамически
list.addEventListener("click", function(event) {
  const element = event.target; // вернуть выбранный элемент внутри списка, return the clicked element inside list
  const elementJob = element.attributes.title.value; // завершить или удалить или редактировать, complete or delete or edit

  if (elementJob === "complete") {
    completeToDo(element);
    localStorage.setItem("TODO", JSON.stringify(LIST));
  } else if (elementJob === "delete") {
    openPopupToDelete(element);
  } else if (elementJob === "edit") {
    openPopupToEdit(element);
  }
});

//console.log(number);
//console.log(DONETASK);

//+при удалении удаляется только кнопка, а не вся строка
//+при установке выполнено не меняется класс task
//+ полечил при обновлении страницы дата и время считается заново, а должно брать с масива
