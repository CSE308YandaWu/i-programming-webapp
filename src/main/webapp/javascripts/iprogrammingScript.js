/**
 * Created by YandaWu on 4/1/2017.
 */

/**
 * ---------------------------------------Button functions in all pages---------------------------------------
 */
/* Home Page sign-in button */
function toMain() {
    document.getElementById("formToMain").action = "/main";
    document.getElementById("formToMain").submit();
}
/* Main Page Create Course button */
function toCreateCourse() {
    document.getElementById("createCourse").action = "/createCourse";
    document.getElementById("createCourse").submit();
}
/* Main Page Add Course button */
function toSearchCourse() {
    document.getElementById("searchCourse").action = "/searchCourse";
    document.getElementById("searchCourse").submit();
}
/* Main Page Edit Course button */
function toEditCourse(index) {
    // document.getElementById("editId").setAttribute("value", a.getElementsByTagName("input")[0].value);
    document.getElementById("editId").value = document.getElementById("editCourseId"+index).value;
    document.getElementById("toEditCourse").action = "/editCourse";
    document.getElementById("toEditCourse").submit();
}
/* Main Page Course button */
function toCoursePage(index) {
    // document.getElementById("cId").setAttribute("value", a.getElementsByTagName("input")[0].value);
    document.getElementById("cId").value = document.getElementById("courseId"+index).value;
    document.getElementById("toCoursePage").action = "/enterCourse";
    document.getElementById("toCoursePage").submit();
}

/* Edit Course Page Add lesson button */
function toEditLesson() {
    document.getElementById("toEditLesson").action = "/editLesson";
    document.getElementById("toEditLesson").submit();
}

function courseStatus() {
    var value = document.getElementById("status").value;
    var statusRow = document.getElementById("statusRow");
    if (value == "private")
        statusRow.style.display = "initial";
    if (value == "public")
        statusRow.style.display = "none";
}

function checkCode(validCode, index) {
    var input = document.getElementById("accessCode"+index).value;
    if(input == validCode) {
        return true;
    }
    else{
        document.getElementById("errorMsg"+index).style.display = "inline";
        return false;
    }
}


/**
 * ---------------------------------------Back navigation button functions for all pages---------------------------------------
 */


function goBack() {
    history.back();
}
/* let the courseContent page select which page to go back */
function goBackSelector(originalPlace) {
    if(originalPlace=="editCoursePage"){
        //back to editCourse Page
        document.getElementById("backToEditCourse").action = "/editCourse";
        document.getElementById("backToEditCourse").submit();
    }else{//from the main
        //back to main Page
        document.getElementById("backToCourseInfo").action = "/enterCourse";
        document.getElementById("backToCourseInfo").submit();
    }
}

/* createCourse Page cancel button */
function createCourseToMainCancel() {
    document.getElementById("createCourseToMainCancel").action = "/main";
    document.getElementById("createCourseToMainCancel").submit();
}
/* searchCourse Page add button */
function searchCourseToMain() {
    document.getElementById("searchCourseToMain").action = "/main";
    document.getElementById("searchCourseToMain").submit();
}


/* createCourse Page cancel button */
function editLessonToEditCourseCancel() {
    document.getElementById("editLessonToEditCourseCancel").action = "/editCourse";
    document.getElementById("editLessonToEditCourseCancel").submit();
}
/**
 * ---------------------------------------editCourse Page function---------------------------------------
 */
function setCourseTitle(x) {
    document.getElementById("title2Save").setAttribute("value", x.value);
    document.getElementById("titleEditLesson").setAttribute("value", x.value);
    document.getElementById("titleDeleteLesson").setAttribute("value", x.value);
}
function setInstructor(x) {
    document.getElementById("instructor2Save").setAttribute("value", x.value);
    document.getElementById("instructorEditLesson").setAttribute("value", x.value);
    document.getElementById("instructorDeleteLesson").setAttribute("value", x.value);
}
function setDescription(x) {
    document.getElementById("description2Save").setAttribute("value", x.value);
    document.getElementById("descriptionEditLesson").setAttribute("value", x.value);
    document.getElementById("descriptionDeleteLesson").setAttribute("value", x.value);
}
function setAccessCode(x) {
    document.getElementById("accessCode2Save").setAttribute("value", x.value);
    document.getElementById("accessCodeEditLesson").setAttribute("value", x.value);
    document.getElementById("accessCodeDeleteLesson").setAttribute("value", x.value);
}
function setStatus(x){
    showAccessCode();
    document.getElementById("status2Save").setAttribute("value", x.value);
    document.getElementById("statusEditLesson").setAttribute("value", x.value);
    document.getElementById("statusDeleteLesson").setAttribute("value", x.value);
}
function showAccessCode(){
    var x = document.getElementById("status").value;
    var y = document.getElementById("statusRow");
    if ( x == "public")
        y.style.display = "none";
    else
        y.style.display = "table-row";
}

/**
 * ---------------------------------------View lesson buttons(view lesson in editCourse Page)---------------------------------------
 */
function viewLesson(lessonIndex) {//assignment index
    document.getElementById("viewLesson"+lessonIndex).action = "/courseContent";
    document.getElementById("viewLesson"+lessonIndex).submit();
}
function deleteLesson(lessonIndex) {//assignment index
    document.getElementById("viewLesson"+lessonIndex).action = "/deleteLesson";
    document.getElementById("viewLesson"+lessonIndex).submit();
}