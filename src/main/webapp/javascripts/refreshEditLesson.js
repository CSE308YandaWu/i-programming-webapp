/**
 * Created by Yanda Wu on 5/12/2017.
 */

/*
 * if user click the back button from editCourse, s/he will be redirected to editLesson page and it needs to be refreshed to generate a new blobstore uploadUrl,
 * otherwise it will give "No upload session error" , I fixed this bug by refreshing the editLesson page.
 */
/* called from EditCoursePage, set teh visited page */
function refreshBackFromEditCoursePage(){
    // sessionStorage.setItem("editCoursePageVisited", "True");
}
/* called from editLesson page, refresh the editLesson page */
function refreshEditLesson(){
    // if (sessionStorage.getItem("editCoursePageVisited")) {
    //     sessionStorage.removeItem("editCoursePageVisited");
    //     window.location.reload(true); // force refresh editCourse Page
    // }
}