const menuItem = () => {
  if (location.pathname === '/item_amounts/new') {
    $('.input').addClass('active');
    $('#additem-text').addClass('active');
  }
}
export { menuItem };


const menuPantry = () => {
  if (location.pathname === '/pantry') {
    $('#pantry-text').addClass('active');
    $('.kitchen').addClass('active');
  }
}
export { menuPantry };


const menuRecipes = () => {
  if (location.pathname === '/recipes' || location.pathname === '/search' || location.pathname === '/view') {
    $('#recipes-text').addClass('active');
    $('.restaurant').addClass('active');
  }
}
export { menuRecipes };


const menuAddrecipe = () => {
  if (location.pathname === '/recipes/new') {
    $('#addrecipe-text').addClass('active');
    $('.note_alt').addClass('active');
  }
}
export { menuAddrecipe };
