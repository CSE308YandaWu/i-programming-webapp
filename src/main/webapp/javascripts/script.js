/**
 * Created by YandaWu on 4/1/2017.
 */

/**
 * ---------------------------------------Google sign-in functions---------------------------------------
 */

function onSuccess(googleUser) {
    console.log('Logged in as: ' + googleUser.getBasicProfile().getName());
    // alert(googleUser.getBasicProfile().getName());
    // var id_token = googleUser.getAuthResponse().id_token;
    // alert(id_token);
    if(document.getElementById('userEmail') != null){
        document.getElementById('userEmail').innerHTML = (googleUser.getBasicProfile().getEmail());
    }
    toMain();

    // var userEmail = googleUser.getBasicProfile().getEmail();
    // document.getElementById('userEmail').setAttribute("value", userEmail);
    // toMain();

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
        signOutToHome();//back to home after sign out
    });
    //document.getElementById('userEmail').style.display='none';
}

/**
 * ---------------------------------------Button functions in all pages---------------------------------------
 */

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

/**
 * ---------------------------------------Home/Sign-Out Button functions for all pages---------------------------------------
 */
/* Main Page Home button */
function mainToHome(){
    document.getElementById("mainToHome").action = "/main";
    document.getElementById("mainToHome").submit();
}
/* create_course Page Home button */
function createCourseToHome(){
    document.getElementById("createCourseToHome").action = "/main";
    document.getElementById("createCourseToHome").submit();
}
/* search_course Page Home button */
function searchCourseToHome(){
    document.getElementById("searchCourseToHome").action = "/main";
    document.getElementById("searchCourseToHome").submit();
}
/* editCourse Page Home button */
function editCourseToHome(){
    document.getElementById("editCourseToHome").action = "/main";
    document.getElementById("editCourseToHome").submit();
}
/* editUnit Page Home button */
function editUnitToHome(){
    document.getElementById("editUnitToHome").action = "/main";
    document.getElementById("editUnitToHome").submit();
}
/* editLesson Page Home button */
function editLessonToHome(){
    document.getElementById("editLessonToHome").action = "/main";
    document.getElementById("editLessonToHome").submit();
}
/* signOut function for all pages back to home page */
function signOutToHome(){
    document.getElementById("signOutToHome").action = "/";
    document.getElementById("signOutToHome").submit();
}
/**
 * ---------------------------------------Back navigation button functions for all pages---------------------------------------
 */
/* createCourse Page confirm button */
function createCourseToMainConfirm(){
    document.getElementById("createCourseToMainConfirm").action = "/main";
    document.getElementById("createCourseToMainConfirm").submit();
}
/* createCourse Page cancel button */
function createCourseToMainCancel(){
    document.getElementById("createCourseToMainCancel").action = "/main";
    document.getElementById("createCourseToMainCancel").submit();
}
/* searchCourse Page add button */
function searchCourseToMain(){
    document.getElementById("searchCourseToMain").action = "/main";
    document.getElementById("searchCourseToMain").submit();
}
/* editUnit Page confirm button */
function editUnitToEditCourseConfirm(){
    document.getElementById("editUnitToEditCourseConfirm").action = "/editCourse";
    document.getElementById("editUnitToEditCourseConfirm").submit();
}
/* editUnit Page cancel button */
function editUnitToEditCourseCancel(){
    document.getElementById("editUnitToEditCourseCancel").action = "/editCourse";
    document.getElementById("editUnitToEditCourseCancel").submit();
}
/* editLesson Page confirm button */
function editLessonToEditCourseConfirm(){
    document.getElementById("editLessonToEditCourseConfirm").action = "/editCourse";
    document.getElementById("editLessonToEditCourseConfirm").submit();
}
/* createCourse Page cancel button */
function editLessonToEditCourseCancel(){
    document.getElementById("editLessonToEditCourseCancel").action = "/editCourse";
    document.getElementById("editLessonToEditCourseCancel").submit();
}

/**
 * ---------------------------------------test functions---------------------------------------
 */

function toCoursePage() {
    var name = document.getElementById("coursename").innerHTML;
    // alert(name);
    document.getElementById("nameinput").setAttribute("value", name);
    // alert(document.getElementById("nameinput").getAttribute("value"));
    document.getElementById("entercourse").submit();
}

function ff20(){
    document.getElementById("myForm").action = "/hello";
    document.getElementById("myForm").submit();
}
function ff10(){
    document.getElementById("myForm2").action = "/";
    document.getElementById("myForm2").submit();
}