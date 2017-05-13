/**
 * Created by YANDA WU on 5/12/2017.
 */
/**
 * ---------------------------------------Serve buttons(serves content in courseContentPage)---------------------------------------
 */
/* serve Assignment */
function serveAssignment(index) {//assignment index
    document.getElementById("serveAssignment" + index).action = "/serve";
    document.getElementById("serveAssignment" + index).submit();
}