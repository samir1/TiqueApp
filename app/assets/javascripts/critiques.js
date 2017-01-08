function refreshCritques(type, instructor_code){
  $.ajax({
   url: "/refresh_pluses_minuses/"+instructor_code+"",
   type: 'GET',
   data: {critique_type: type}
  });
}