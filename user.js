module.exports = function(){
    var express = require('express');
    var router = express.Router();

    // Query existing users
    function getUsers(res, mysql, context, complete){
        mysql.pool.query("SELECT user_name, email, date_created FROM Users ORDER BY date_created DESC", function(err, results, fields){
            if(err){
                res.write(JSON.stringify(err));
            }
            context.user = results;
            complete();
        })
    }
     
    // Render page and display query results
    router.get('/', function(req, res){
        var callbackCount = 0;
        context = {};
        context.jsscripts= ['searchuser.js'];
        var mysql = req.app.get('mysql');
        getUsers(res, mysql, context, complete);
        function complete() {
            callbackCount++;
            if(callbackCount >= 1){
                res.render('user', context)
            }
        }
    });

    return router;
}();
