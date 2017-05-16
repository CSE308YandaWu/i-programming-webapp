/**
 * Created by YANDA WU on 5/12/2017.
 */
/**
 *
 * ---------------------------------------Google sign-in/out functions---------------------------------------
 */
function onSuccess(googleUser) {
    console.log('Logged in as: ' + googleUser.getBasicProfile().getName());

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

}
/* signOut function for all pages back to home page */
function signOutToHome() {
    document.getElementById("signOutToHome").action = "/logout";
    document.getElementById("signOutToHome").submit();
}