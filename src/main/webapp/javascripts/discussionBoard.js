/**
 * Created by JIAQI ZHANG on 5/14/2017.
 */
/**
 * ---------------------------------------Discussion Board function---------------------------------------
 */
function likeComment(index){
    document.getElementById("likeForm"+index).action = "/likeComment";
    document.getElementById("likeForm"+index).submit();
}
function dislikeComment(index){
    document.getElementById("likeForm"+index).action = "/dislikeComment";
    document.getElementById("likeForm"+index).submit();
}
function deleteComment(index){
    document.getElementById("deleteComment"+index).submit();
}