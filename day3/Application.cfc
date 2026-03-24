component {

    this.name = "DemoApplication";
    this.sessionManagement = true;
    this.sessionTimeout = createTimeSpan(0, 0, 1, 0);

    // Runs once when app starts
    function onApplicationStart() {
        application.siteName = "My First ColdFusion App";
        return true;
    }

    // Runs when a new user session starts
    function onSessionStart() {
        session.visits = 0;
    }

    // Runs before every page request
    function onRequestStart(targetPage) {
        //session.visits = 0;
        session.visits++;
        return true;
    }

    // Controls page execution
    function onRequest(targetPage) {
        include targetPage;
    }

}
