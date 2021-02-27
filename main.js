var express = require('express');
var mysql = require('./dbcon.js');
var bodyParser = require('body-parser');

var app = express();
var handlebars = require('express-handlebars').create({
        defaultLayout:'main',
        });

app.engine('handlebars', handlebars.engine);
app.use(bodyParser.urlencoded({extended:true}));
app.use('/static', express.static('public'));
app.set('view engine', 'handlebars');
app.set('port', process.argv[2]);
app.set('mysql', mysql);


app.get('/new-user', function(req,res){
    res.render('new-user');
    require('./new-user.js')
});
app.get('/user', function(req,res){
    res.render('user');
    require('./user.js')
});
app.get('/ingredients', function(req,res){
    res.render('ingredients');
    require('./ingredients.js')
});
app.get('/user-ingredients', function(req,res){
    res.render('user-ingredients');
    require('./user-ingredients.js')
});
app.get('/new-user-ingredients', function(req,res){
    res.render('new-user-ingredients');
    require('./new-user-ingredients.js')
});
app.get('/recipes', function(req,res){
    res.render('recipes');
    require('./recipes.js')
});
app.get('/favorites', function(req,res){
    res.render('favorites');
    require('./favorites.js')
});


app.use('/', express.static('public'));


app.use(function(req,res){
  res.status(404);
  res.render('404');
});

app.use(function(err, req, res, next){
  console.error(err.stack);
  res.status(500);
  res.render('500');
});

app.listen(app.get('port'), function(){
  console.log('Express started on http://localhost:' + app.get('port') + '; press Ctrl-C to terminate.');
});