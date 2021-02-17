const triggerTabList = () => {
$('.bootstrap-tabs a').on('click', function (event) {
  event.preventDefault()
  $(this).tab('show')
})
}
export { triggerTabList };
