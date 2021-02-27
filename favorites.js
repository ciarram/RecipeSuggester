module.exports = function(){
    var express = require('express');
    var router = express.Router();

    function getUsers(res, mysql, context, complete){
        mysql.pool.query("SELECT user_name FROM Users ORDER BY date_created DESC", function(err, results, fields){
            if(err){
                res.write(JSON.stringify(err));
                res.end();
            }
            context.user = results;
            complete();
        })
    }

    function getRecipes(res, mysql, context, complete){
        mysql.pool.query("SELECT recipe_name, recipe_ID FROM Recipes INNER JOIN Favorite_Recipes ON Recipes.recipe_ID = Favorite_Recipes.r_ID WHERE Favorite_Recipes.u_ID = 1", function(err, results, fields){
            if(err){
                res.write(JSON.stringify(err));
                res.end();
            }
            context.recipe = results;
            complete();
        });
    }

    router.get('/', function(req, res){
        var callbackCount = 0;
        context = {};
        context.jsscripts= ['searchuser.js'];
        var mysql = req.app.get('mysql');
        getUsers(res, mysql, context, complete);
        getRecipes(res, mysql, context, complete);
        function complete() {
            callbackCount++;
            if(callbackCount >= 2){
                res.render('favorites', context)
            }
        }
    });

    return router;
}();