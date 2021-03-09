const initRecipeForm = () => {
  const ingrList = document.querySelector(".form-group .ingr-input");
  const ingrInput = document.querySelector(".form-group .ingr-input li");
  const ingrBtn = document.querySelector(".new-ingr-btn");
  console.log(ingrList)
  console.log(ingrBtn)
  const newIngrInput = `<li><input class="text required form-control" required="required" aria-required="true" type="text" value="" name="recipe[ingredient][]" id="recipe_"></li>`;
  ingrBtn.addEventListener("click", (event) => {
    event.preventDefault();
    ingrList.insertAdjacentHTML("beforeend", ingrInput.outerHTML);
  });
}

export { initRecipeForm };
