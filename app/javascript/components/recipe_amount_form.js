import { initSelect2 } from './init_select2';
const initRecipeForm = () => {
const createButton = document.getElementById("addIngredientBtn");
  createButton.addEventListener("click", () => {
    console.log("click");
    const lastId = document.querySelector(".fieldsetContainer").lastElementChild.id;
    const newId = parseInt(lastId, 10) + 1;
    const newFieldset = document.querySelector("[id='0']").outerHTML.replace(/0/g,newId);
    document.querySelector(".fieldsetContainer").insertAdjacentHTML("beforeend", newFieldset);
    document.querySelector(`[id="${newId}"] span`).remove();
    initSelect2();
  });
}
export { initRecipeForm };
