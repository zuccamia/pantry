const showCircle = (cursor, seconds) => {
  // console.log(cursor);
  const circle = document.createElement("div");
  circle.style.position = "fixed";
  circle.style.backgroundColor = "grey";
  circle.style.borderRadius = "50%";
  circle.style.left = `${cursor.clientX - 18}px`;
  circle.style.top = `${cursor.clientY - 18}px`;
  circle.style.height = "36px";
  circle.style.width = "36px";
  circle.style.opacity = 0.6;
  document.body.appendChild(circle);
  setTimeout(() => {
     circle.remove();
  }, seconds * 500);
};

export { showCircle };
