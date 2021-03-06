const menuItem = () => {
  if (location.pathname === '/item_amounts/new') {
    $('.fa-plus-square').addClass('active');
    $('#additem-text').addClass('active');
  }
}
export { menuItem };


const menuPantry = () => {
  if (location.pathname === '/pantry') {
    $('#pantry-text').addClass('active');
    $('.fa-shopping-basket').addClass('active');
  }
}
export { menuPantry };


const menuRecipes = () => {
  if (location.pathname === '/recipes' || location.pathname === '/search' || location.pathname === '/view') {
    $('#recipes-text').addClass('active');
    $('.fa-utensils').addClass('active');
  }
}
export { menuRecipes };


const menuAddrecipe = () => {
  if (location.pathname === '/recipes/new') {
    $('#addrecipe-text').addClass('active');
    $('.fa-folder-plus').addClass('active');
  }
}
export { menuAddrecipe };
