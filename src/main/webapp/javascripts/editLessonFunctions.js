/**
 * Created by YANDA WU on 5/12/2017.
 */
/* global variables for adding video/imaga/assignment */
var addVideoCounter = 0;//add video counter
var addVideoLimit = 3;//add video limit is 3
var addImageCounter = 0;//add image counter
var addImageLimit = 10;//add image limit is 10
var addAssignmentCounter = 0;//add assignment counter
var addAssignmentLimit = 5;//add assignment limit is 5

/**
 * ---------------------------------------functions in editLesson page---------------------------------------
 */
/* enable the add video button after the add video option is chosen */
function enableOptionButton() {
    document.getElementById("addOptionButtonVideo").disabled = false;
}
/* add Video button function */
function addVideoOptions(divName) {
    document.getElementById("deleteOptionButtonVideo").disabled = false;//enable delete video button after clicking the add video button
    var e = document.getElementById("videoUploadOption");
    var strOption = e.options[e.selectedIndex].value;//1 stands for video link and 2 stands for video file
    if (addVideoCounter == addVideoLimit) {//test the upload limit
        alert("You have reached the limit of adding " + addVideoCounter + " video");
    } else {//allow user to add video if the videoLimit is not reached
        var newdiv = document.createElement('div');
        switch (strOption) {
            case '1'://generate video Link input field with video description input filed, and hidden form indicating the video type that will be used later in the controller
                newdiv.innerHTML = " <input type='text' id='videoLink" + addVideoCounter + "' class='form-control' name='videoLinks[]' placeholder='Insert URL here' form='lessonInfo'>" +//video URL
                    "<textarea id='videoDescription"+addVideoCounter+"'class='form-control' rows='3' wrap='soft' name='videoDescriptions[]' placeholder='Add Video description here' form='lessonInfo'></textarea>"+//video description
                    "<input id='videoType"+addVideoCounter+"'type='hidden' name='videoTypes[]' value='1' form='lessonInfo'>";//video type, if video link is chosen, video type = 1
                break;
            case '2'://generate video file input field with video description input filed, and hidden form indicating the video type that will be used later in the controller
                newdiv.innerHTML = "<input type='file' id='videoLink" + addVideoCounter + "'class='form-control' name='myFileVideo[]' accept='video/*' form='lessonInfo'>" +//no multiple selection allowed , user can only select one file each time//video file upload
                    "<textarea id='videoDescription"+addVideoCounter+"'class='form-control' rows='3' wrap='soft' name='videoDescriptions[]' placeholder='Add Video description here' form='lessonInfo'></textarea>"+//video description
                    "<input id='videoType"+addVideoCounter+"'type='hidden' name='videoTypes[]' value='2' form='lessonInfo'>";//video type, if video file is chosen, video type = 2
                break;
        }
        document.getElementById(divName).appendChild(newdiv);
        addVideoCounter++;
        document.getElementById("deleteOptionButtonVideo").disabled = false;
    }
}
/* delete Video button function */
function deleteVideoOptions() {
    var videoLink = document.getElementById("videoLink"+(addVideoCounter-1));
    videoLink.parentNode.removeChild(videoLink);
    var videoDescription = document.getElementById("videoDescription"+(addVideoCounter-1));
    videoDescription.parentNode.removeChild(videoDescription);
    var videoType = document.getElementById("videoType"+(addVideoCounter-1));
    videoType.parentNode.removeChild(videoType);
    addVideoCounter--;
    if(addVideoCounter <= 0){
        document.getElementById("deleteOptionButtonVideo").disabled = true;
    }
}
/* add image button function */
function addImageButton(divName) {
    if (addImageCounter == addImageLimit) {
        alert("You have reached the limit of adding " + addImageCounter + " image");
    } else {
        var newdiv = document.createElement('div');
        newdiv.innerHTML = "<input type='file' id='image" + addImageCounter + "' name='myFileImage[]' accept='image/*' form='lessonInfo'>" +//multiple selection allowed , user can select more than one file each time//image file upload
            "<textarea class='form-control' rows='2' wrap='soft' id='imageDescription"+addImageCounter+"'name='imageDescriptions[]' placeholder='Add Image description here' form='lessonInfo'></textarea>";//assignment file upload
        document.getElementById(divName).appendChild(newdiv);
        addImageCounter++;
        document.getElementById("deleteOptionButtonImage").disabled = false;
    }
}
/* delete image button function */
function deleteImageButton() {
    var image = document.getElementById("image"+(addImageCounter-1));
    image.parentNode.removeChild(image);
    var imageDescription = document.getElementById("imageDescription"+(addImageCounter-1));
    imageDescription.parentNode.removeChild(imageDescription);
    addImageCounter--;
    if(addImageCounter <= 0){
        document.getElementById("deleteOptionButtonImage").disabled = true;
    }
}
/* add assignment button function */
function addAssignmentButton(divName) {
    if (addAssignmentCounter == addAssignmentLimit) {
        alert("You have reached the limit of adding " + addAssignmentCounter + " assignment");
    } else {
        var newdiv = document.createElement('div');
        newdiv.innerHTML = "<input type='file' id='assignment"+addAssignmentCounter+"'name='myFileAssignment[]' form='lessonInfo'>" +//multiple selection allowed , user can select more than one file each time//assignment file upload
            "<textarea class='form-control' rows='2' wrap='soft' id='assignmentDescription"+addAssignmentCounter+"' name='assignmentDescriptions[]' placeholder='Add Assignment description here' form='lessonInfo'></textarea>";//assignment description
        document.getElementById(divName).appendChild(newdiv);
        addAssignmentCounter++;
        document.getElementById("deleteOptionButtonAssignment").disabled = false;
    }
}
/* add assignment button function */
function deleteAssignmentButton() {
    var assignment = document.getElementById("assignment"+(addAssignmentCounter-1));
    assignment.parentNode.removeChild(assignment);
    var assignmentDescription = document.getElementById("assignmentDescription"+(addAssignmentCounter-1));
    assignmentDescription.parentNode.removeChild(assignmentDescription);
    addAssignmentCounter--;
    if(addAssignmentCounter<=0){
        document.getElementById("deleteOptionButtonAssignment").disabled = true;
    }
}
/* editLesson Page confirm button */
function editLessonConfirm() {
    //document.getElementById("lessonInfo").action = "/editLessonConfirm";
    var regexp = /(ftp|http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?///check if the entered url is valid
    var videoUploadCheck = 1;//check if user input all files into the chosen option filed
    for(var i = 0;i < addVideoCounter; i++) {//check video field
        if (document.getElementById("videoLink" + i).value == "") {
            alert("You must upload a video or paste a link in Video Option row " + (i + 1) + " if you choose to upload one");
            videoUploadCheck = 0;
            return;
        }
    }
    for(var i = 0;i < addImageCounter; i++) {//check image field
        if (document.getElementById("image" + i).value == "") {
            alert("You must upload a image in Image Option row " + (i + 1) + " if you choose to upload one");
            videoUploadCheck = 0;
            return;
        }
    }
    for(var i = 0;i < addAssignmentCounter; i++){//check assignment field
        if(document.getElementById("assignment" + i).value == "") {
            alert("You must upload a file in File Option row " + (i + 1) + " if you choose to upload one");
            videoUploadCheck = 0;
            return;
        }
    }
    if (document.getElementById("slideShowLink").value != "") {//check slide show link field
        if(regexp.test(document.getElementById("slideShowLink").value) != true){
            alert("You must enter a valid Slide Show Link if you choose to enter one");
            videoUploadCheck = 0;
            return;
        }
    }
    for(var i = 0;i < addVideoCounter; i++) {//check video field
        if (document.getElementById("videoLink" + i).value != "") {
            if((regexp.test(document.getElementById("videoLink" + i).value) != true)
                && (isVideo(document.getElementById("videoLink" + i).value) != true)){//if it is not a valid url or video
                alert("You must enter a valid video link in row " + (i + 1) + " if you choose to enter one");
                videoUploadCheck = 0;
                return;
            }
        }
    }
    if(videoUploadCheck == 1) {//all checking passed, submit the form
        document.getElementById("lessonInfo").submit();
    }
}
function getExtension(filename) {//get uploaded file's extension
    var parts = filename.split('.');
    return parts[parts.length - 1];
}
function isVideo(filename) {//check if the uploaded file is a video
    var ext = getExtension(filename);
    switch (ext.toLowerCase()) {
        case 'm4v':
        case 'avi':
        case 'mpg':
        case 'mp4':
        case 'ogg':
        case 'webm':
            // etc
            return true;
    }
    return false;
}