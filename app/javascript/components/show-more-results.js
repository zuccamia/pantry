const showMoreResults = () => {
  document.getElementById('card-pantry-search-more').hidden = true;

  $('#search-more').on('click', function (event) {
    event.preventDefault;
    document.getElementById('card-pantry-search-more').hidden = false;
  })
}

export {showMoreResults};
