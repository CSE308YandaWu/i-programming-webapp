/**
 * Created by GangdiHuang on 5/3/17.
 */
function do_search(){
    var input = document.getElementById("UserIn").value;
    if(input == "" || input == null){
        window.alert("Input can't not be empty")

    }
    var method = document.getElementById("MySelect").value;
    document.getElementById("select_method").value = method;
}