/**
 * Created by YandaWu on 4/1/2017.
 */

function onSuccess(googleUser) {
    console.log('Logged in as: ' + googleUser.getBasicProfile().getName());
    // document.getElementById('userEmail').innerHTML = (googleUser.getBasicProfile().getEmail());

    // document.getElementById("myForm").action = "/hello";
    // document.getElementById("myForm").submit();
}

function onFailure(error) {
    console.log(error);
}
function renderButton() {
    gapi.signin2.render('my-signin2', {
        'scope': 'profile email',
        'width': 240,
        'height': 50,
        'longtitle': true,
        'theme': 'dark',
        'onsuccess': onSuccess,
        'onfailure': onFailure
    });
}

function signOut() {
    var auth2 = gapi.auth2.getAuthInstance();
    auth2.signOut().then(function () {
        console.log('User signed out.');
    });
    //document.getElementById('userEmail').style.display='none';
    // document.getElementById("myGod").action = "/out";
    // document.getElementById("myGod").submit();
}
/* Home Page sign-in button */
function toMain(){
    document.getElementById("formToMain").action = "/main";
    document.getElementById("formToMain").submit();
}
/* Main Page Create Course button */
function toCreateCourse(){
    document.getElementById("createCourse").action = "/create_course";
    document.getElementById("createCourse").submit();
}
/* Main Page Add Course button */
function toSearchCourse(){
    document.getElementById("addCourse").submit();
}

function toCoursePage() {
    var name = document.getElementById("coursecode").innerHTML;
    alert(name);
    document.getElementById("entercourse").setAttribute("coursecode", name);
    alert(document.getElementById("entercourse").getAttribute("coursecode"));
    document.getElementById("entercourse").submit();
}

/* Main Page Home button */
function mainToHome(){
    document.getElementById("mainToHome").action = "/";
    document.getElementById("mainToHome").submit();
}
/* create_course Page Home button                                   NOT YET */
function createToHome(){
    document.getElementById("create_courseToHome").action = "/";
    document.getElementById("create_courseToHome").submit();
}
/* search_course Page Home button                                    NOT YET */
function search_courseToHome(){
    document.getElementById("search_courseToHome").action = "/";
    document.getElementById("search_courseToHome").submit();
}
/* editLesson Page Home button */
function editLessonToHome(){
    document.getElementById("editLessonToHome").action = "/";
    document.getElementById("editLessonToHome").submit();
}


function ff20(){
    document.getElementById("myForm").action = "/hello";
    document.getElementById("myForm").submit();
}
function ff10(){
    document.getElementById("myForm2").action = "/";
    document.getElementById("myForm2").submit();
}