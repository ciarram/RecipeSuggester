module.exports = function(){
    var express = require('express');
    var router = express.Router();

    /* Add a new user with current date */

    router.get('/'), function(req, res){
        res.render();
    };

    router.post('/', function(req, res){
        var mysql = req.app.get('mysql');
        var sql = "INSERT INTO Users (user_name, email, date_created) VALUES (?,?,NOW())";
        var inserts = [req.body.uname, req.body.email];
        sql = mysql.pool.query(sql,inserts,function(error, results, fields){
            if(error){
                console.log(JSON.stringify(error))
                res.write(JSON.stringify(error));
                res.end();
            }else{
                res.redirect('/user')
            }
        });
    });

    return router;
}();
