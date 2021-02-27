module.exports = function(){
    var express = require('express');
    var router = express.Router();

    /* Find recipe based on the first name */
    function getRecipesWithNameLike(req, res, mysql, context, complete) {
      //sanitize the input as well as include the % character
       var query = "SELECT recipes.recipe_id as id, recipe_name, recipe_description, recipe_type, recipe_origin, prep_time, cook_time FROM recipes WHERE recipes.recipe_name LIKE " + mysql.pool.escape(req.params.s + '%');
       console.log(query)
       
       mysql.pool.query(query, function(error, results, fields){
           if(error){
               res.write(JSON.stringify(error));
               res.end();
            }
            context.people = results;
            complete();
        });
    }

    /*Display all people whose name starts with a given string. Requires web based javascript to delete users with AJAX */
    router.get('/search/:s', function(req, res){
        var callbackCount = 0;
        var context = {};
        context.jsscripts = ["searchrecipe.js"];
        var mysql = req.app.get('mysql');
        getRecipesWithNameLike(req, res, mysql, context, complete);
        function complete(){
            callbackCount++;
            if(callbackCount >= 2){
                res.render('recipes', context);
            }
        }
    });

    return router;
}();