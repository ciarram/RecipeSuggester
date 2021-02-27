/* -------------------------- SELECTS --------------------------*/

/* Select user name and join dates */
SELECT user_name, date_created FROM Users
ORDER BY date_created DESC;

/* Select user's favorite recipes */
SELECT recipe_name, recipe_ID FROM Recipes 
JOIN Favorite_Recipes ON Recipes.recipe_ID = Favorite_Recipes.r_ID 
WHERE Favorite_Recipes.u_ID = (
    SELECT user_id FROM Users 
    WHERE user_name = :usernameinput;
)

/* View ingredients that a user has */
SELECT Users.user_name, Ingredients.ingredient_name, User_Ingredients.ingredient_amount, User_Ingredients.ingredient_unit FROM Users
JOIN User_Ingredients ON Users.user_ID = User_Ingredients.u_ID
JOIN Ingredients ON User_Ingredients.i_ID = Ingredients.ingredient_ID
WHERE Users.user_name = :usernameInput;

/* Select from the list of genreal ingredients */
SELECT ingredient_name FROM Ingredients;

/* Select from the list of recipes */
SELECT recipe_name FROM Recipes; 

/* -------------------------- INSERTS --------------------------*/

/* Insert a new user */
INSERT INTO Users (user_name, email, date_created) VALUES (
    :usernameInput,
    :emailInput,
    NOW()
);

/* Insert a new user favorite */
INSERT INTO Favorite_Recipes (u_ID, r_ID) VALUES (
    (SELECT user_ID FROM Users
    WHERE user_name = :usernameInput
    OR email = :emailInput),
    (SELECT recipe_ID FROM Recipes
    WHERE recipe_name = :recipenameInput)
);

/* Insert new user ingredient */
INSERT INTO User_Ingredients (u_ID, i_ID, ingredient_amount, ingredient_unit) VALUES (
    (SELECT user_ID FROM Users
    WHERE user_name = :usernameInput
    OR email = :emailInput),
    (SELECT ingredient_ID FROM Ingredients
    WHERE ingredient_name = :ingredientNameInput),
    :amountInput,
    :unitInput
);

/* Insert a new ingredient */
INSERT INTO Ingredients (ingredient_name) VALUES (:ingredientNameInput);


/* -------------------------- UPDATES --------------------------*/

/* Update username */
UPDATE Users
SET user_name = :newUsernameInput
WHERE user_name = :oldUsernameInput
AND email = :emailInput;

/* Update user email */
UPDATE Users
SET email = :newEmailInput
WHERE user_name = :usernameInput
AND email = :oldEmailInput;

/* Update user ingredient amounts */
UPDATE User_Ingredients
SET ingredient_amount = :ingredientAmountInput
    ingredient_unit = :ingredientUnitInput
WHERE u_id = (
    SELECT user_id FROM Users
    WHERE user_name = :usernameInput
)
AND i_id = (
    SELECT ingredient_ID FROM Ingredients
    WHERE ingredient_name = :ingredientNameInput
)

/* -------------------------- DELETES --------------------------*/

/* Delete user */
DELETE FROM Users
WHERE user_name = :usernameInput
AND email = :emailInput

/* Delete user favorite */
DELETE FROM Favorite_Recipes
WHERE u_id = (
    SELECT user_ID FROM Users
    WHERE user_name = :usernameInput
) 
AND r_id = (
    SELECT recipe_ID FROM Recipes
    WHERE recipe_name = :recipeNameInput
)

/* Remove ingredient from user */
DELETE FROM User_Ingredients
WHERE u_id = (
    SELECT user_ID FROM Users
    WHERE user_name = :usernameInput
) 
AND i_id = (
    SELECT ingredient_ID FROM Ingredients
    WHERE ingredient_name = :ingredientNameInput
)

/* Remove ingredients from the ingredient page */
DELETE FROM Ingredients WHERE ingredient_name = :ingredientNameInput
