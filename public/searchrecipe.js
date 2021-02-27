function searchRecipeByFirstName() {
    //get the first name 
    var search_for_recipe  = document.getElementById('recipe_name').value
    //construct the URL and redirect to it
    window.location = '/people/search/' + encodeURI(search_for_recipe)
}
