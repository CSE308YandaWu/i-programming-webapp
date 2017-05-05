/**
 * Created by YandaWu on 4/1/2017.
 */

var addVideoCounter = 0;//add video counter   reset????
var addVideoLimit = 4;//add video limit
/**
 *
 * ---------------------------------------Google sign-in/out functions---------------------------------------
 */
function onSuccess(googleUser) {
    console.log('Logged in as: ' + googleUser.getBasicProfile().getName());
    /* if user email changes, we might need to use the id_token to save the userInfo */
    // alert(googleUser.getBasicProfile().getName());
    // var id_token = googleUser.getAuthResponse().id_token;
    // alert(id_token);
    if (document.getElementById('userEmail') != null) {//home page doesn't have userEmial
        document.getElementById('userEmail').innerHTML = (googleUser.getBasicProfile().getEmail());
    }
    document.getElementById('userEmail').setAttribute("value", googleUser.getBasicProfile().getEmail());
    toMain();//from home page.to main page

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
function toEditCourse(a) {
    document.getElementById("editId").setAttribute("value", a.getElementsByTagName("input")[0].value);
    document.getElementById("toEditCourse").action = "/editCourse";
    document.getElementById("toEditCourse").submit();
}
/* Main Page Course button */
function toCoursePage(a) {
    document.getElementById("cId").setAttribute("value", a.getElementsByTagName("input")[0].value);
    document.getElementById("toCoursePage").action = "/enterCourse";
    document.getElementById("toCoursePage").submit();
}
/* Edit Course Page Add Unit button */
function toEditUnit() {
    document.getElementById("toEditUnit").action = "/editUnit";
    document.getElementById("toEditUnit").submit();
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
 * ---------------------------------------Home/Sign-Out Button functions for all pages---------------------------------------
 */
/* Main Page Home button */
function mainToHome() {
    document.getElementById("mainToHome").action = "/main";
    document.getElementById("mainToHome").submit();
}
/* create_course Page Home button */
function createCourseToHome() {
    document.getElementById("createCourseToHome").action = "/main";
    document.getElementById("createCourseToHome").submit();
}
/* search_course Page Home button */
function searchCourseToHome() {
    document.getElementById("searchCourseToHome").action = "/main";
    document.getElementById("searchCourseToHome").submit();
}
/* courseInfo Page Home button */
function courseInfoToHome() {
    document.getElementById("courseInfoToHome").action = "/main";
    document.getElementById("courseInfoToHome").submit();
}
/* editCourse Page Home button */
function editCourseToHome() {
    document.getElementById("editCourseToHome").action = "/main";
    document.getElementById("editCourseToHome").submit();
}
/* editUnit Page Home button */
function editUnitToHome() {
    document.getElementById("editUnitToHome").action = "/main";
    document.getElementById("editUnitToHome").submit();
}
/* editLesson Page Home button */
function editLessonToHome() {
    document.getElementById("editLessonToHome").action = "/main";
    document.getElementById("editLessonToHome").submit();
}
/* courseContent Page Home button */
function courseContentToHome() {
    document.getElementById("courseContentToHome").action = "/main";
    document.getElementById("courseContentToHome").submit();
}
/* signOut function for all pages back to home page */
function signOutToHome() {
    document.getElementById("signOutToHome").action = "/logout";
    document.getElementById("signOutToHome").submit();
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
        document.getElementById("backToMain").action = "/main";
        document.getElementById("backToMain").submit();
    }
}

/* createCourse Page confirm button */
function createCourseToMainConfirm() {
    document.getElementById("createCourseToMainConfirm").action = "/main";
    document.getElementById("createCourseToMainConfirm").submit();
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
/* editUnit Page confirm button */
function editUnitToEditCourseConfirm() {
    document.getElementById("editUnitToEditCourseConfirm").action = "/editCourse";
    document.getElementById("editUnitToEditCourseConfirm").submit();
}
/* editUnit Page cancel button */
function editUnitToEditCourseCancel() {
    document.getElementById("editUnitToEditCourseCancel").action = "/editCourse";
    document.getElementById("editUnitToEditCourseCancel").submit();
}
/* editLesson Page confirm button */
function editLessonConfirm() {
    //document.getElementById("lessonInfo").action = "/editLessonConfirm";
    document.getElementById("lessonInfo").submit();
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
 * ---------------------------------------Other navigation button---------------------------------------
 */

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
/**
 * ---------------------------------------Serve buttons(serves content in courseContentPage)---------------------------------------
 */
function serveAssignment(index) {//assignment index
    document.getElementById("serveAssignment" + index).action = "/serve";
    document.getElementById("serveAssignment" + index).submit();
}
function serveAssignment1() {
    document.getElementById("serveAssignment1").action = "/serve";
    document.getElementById("serveAssignment1").submit();
}
function serveImage() {
    document.getElementById("serveImage").action = "/serve";
    document.getElementById("serveImage").submit();
}
function serveVideo() {
    document.getElementById("serveVideo").action = "/serve";
    document.getElementById("serveVideo").submit();
}
function serveVideo1() {
    document.getElementById("serveVideo1").action = "/serve";
    document.getElementById("serveVideo1").submit();
}

/**
 * ---------------------------------------Add Content functions---------------------------------------
 */
function enableOptionButton() {
    document.getElementById("addOptionButton").disabled = false;
}
function addVideoOptions(divName) {
    var newdiv = document.createElement('div');
    var e = document.getElementById("videoUploadOption");
    var strOption = e.options[e.selectedIndex].value;
    if (addVideoCounter == addVideoLimit) {
        alert("You have reached the limit of adding " + addVideoCounter + " video");
    } else {
        switch (strOption) {
            case '1':
                newdiv.innerHTML = " <br><input type='text' class='form-control' name='videoLinks[]' placeholder='Insert URL here' form='lessonInfo'>" +//video URL
                    "<br><textarea class='form-control' rows='3' wrap='soft' name='videoDescriptions[]' placeholder='Add Video description here' form='lessonInfo'></textarea>"+//video description
                    "<input type='hidden' name='videoTypes[]' value='1' form='lessonInfo'>";//video type, if video link is chosen, video type = 1
                break;
            case '2':
                newdiv.innerHTML = " <br><input type='file' name='myFileVideo[]' accept='video/*' form='lessonInfo'>" +//no multiple selection allowed , user can only select one file each time//video file upload
                    "<br><textarea class='form-control' rows='3' wrap='soft' name='videoDescriptions[]' placeholder='Add Video description here' form='lessonInfo'></textarea>"+//video description
                    "<input type='hidden' name='videoTypes[]' value='2' form='lessonInfo'>";//video type, if video file is chosen, video type = 2
                break;
        }
        document.getElementById(divName).appendChild(newdiv);
        addVideoCounter++;
    }
}
function addImageButton(divName) {
    var newdiv = document.createElement('div');
    newdiv.innerHTML = " <br><input type='file' multiple name='myFileImage[]' accept='image/*' form='lessonInfo'>" +//multiple selection allowed , user can select more than one file each time//image file upload
        "<br><textarea class='form-control' rows='2' wrap='soft' name='imageDescriptions[]' placeholder='Add Image description here' form='lessonInfo'></textarea>";//assignment file upload
    document.getElementById(divName).appendChild(newdiv);
}
function addAssignmentButton(divName) {
    var newdiv = document.createElement('div');
    newdiv.innerHTML = " <br><input type='file' multiple name='myFileAssignment[]' form='lessonInfo'>" +//multiple selection allowed , user can select more than one file each time//assignment file upload
        "<br><textarea class='form-control' rows='2' wrap='soft' name='assignmentDescriptions[]' placeholder='Add Assignment description here' form='lessonInfo'></textarea>";//assignment description
    document.getElementById(divName).appendChild(newdiv);
}
/**
 * ---------------------------------------test functions---------------------------------------
 */

// function toCoursePage() {
//     // var name = document.getElementById("coursename").innerHTML;
//     // // alert(name);
//     // document.getElementById("nameinput").setAttribute("value", name);
//     // alert(document.getElementById("nameinput").getAttribute("value"));
//     document.getElementById("entercourse").submit();
// }

function ff20() {
    document.getElementById("myForm").action = "/hello";
    document.getElementById("myForm").submit();
}
function ff10() {
    document.getElementById("myForm2").action = "/";
    document.getElementById("myForm2").submit();
}
function ff30() {
    document.getElementById("serve").action = "/serve";
    document.getElementById("serve").submit();
}
