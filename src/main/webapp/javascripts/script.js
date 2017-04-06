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
    document.getElementById("createCourse").action = "/createCourse";
    document.getElementById("createCourse").submit();
}
/* Main Page Add Course button */
function toSearchCourse(){
    document.getElementById("searchCourse").action = "/searchCourse";
    document.getElementById("searchCourse").submit();
}

/* Main Page Edit Course button */
function toEditCourse(){
    document.getElementById("toEditCourse").action = "/editCourse";
    document.getElementById("toEditCourse").submit();
}

/* Edit Course Page Add Unit button */
function toEditUnit(){
    document.getElementById("toEditUnit").action = "/editUnit";
    document.getElementById("toEditUnit").submit();
}

/* Edit Course Page Add lesson button */
function toEditLesson(){
    document.getElementById("toEditLesson").action = "/editLesson";
    document.getElementById("toEditLesson").submit();
}

//////////////////
function toCoursePage() {
    var name = document.getElementById("coursecode").innerHTML;
    alert(name);
    document.getElementById("entercourse").setAttribute("coursecode", name);
    alert(document.getElementById("entercourse").getAttribute("coursecode"));
    document.getElementById("entercourse").submit();
}
///////////////////

/* Main Page Home button */
function mainToHome(){
    document.getElementById("mainToHome").action = "/";
    document.getElementById("mainToHome").submit();
}
/* create_course Page Home button */
function createCourseToHome(){
    document.getElementById("createCourseToHome").action = "/";
    document.getElementById("createCourseToHome").submit();
}
/* search_course Page Home button */
function searchCourseToHome(){
    document.getElementById("searchCourseToHome").action = "/";
    document.getElementById("searchCourseToHome").submit();
}
/* editCourse Page Home button */
function editCourseToHome(){
    document.getElementById("editCourseToHome").action = "/";
    document.getElementById("editCourseToHome").submit();
}
/* editUnit Page Home button */
function editUnitToHome(){
    document.getElementById("editUnitToHome").action = "/";
    document.getElementById("editUnitToHome").submit();
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