module.exports = function(){
    var express = require('express');
    var router = express.Router();

    function getIngredients(res, mysql, context, complete){
        mysql.pool.query("SELECT ingredient_ID as id, ingredient_name FROM ingredients", function(error, results, fields){
            if(error){
                res.write(JSON.stringify(error));
                res.end();
            }
            context.people = results;
            complete();
        });
    }

    /*Display all people. Requires web based javascript to delete users with AJAX*/

    router.get('/', function(req, res){
        var callbackCount = 0;
        var mysql = req.app.get('mysql');
        getIngredients(res, mysql, context, complete);
        function complete(){
            callbackCount++;
            if(callbackCount >= 2){
                res.render('ingredients', context);
            }

        }
    });

    /* Adds a person, redirects to the people page after adding */

    router.post('/', function(req, res){
        console.log(req.body)
        var mysql = req.app.get('mysql');
        var sql = "INSERT INTO ingredients (ingredient_name) VALUES (?)";
        var inserts = [req.body.ingredient_name];
        sql = mysql.pool.query(sql,inserts,function(error, results, fields){
            if(error){
                console.log(JSON.stringify(error))
                res.write(JSON.stringify(error));
                res.end();
            }else{
                res.redirect('/ingredients');
            }
        });
    });

    return router;
}();


