function refreshCritques(type, instructor_code){
  $.ajax({
   url: "/refresh_pluses_minuses/"+instructor_code+"",
   type: 'GET',
   data: {critique_type: type}
  });
};

function deleteCritque(id, instructor_code){
  $.ajax({
   url: "/delete_critique/"+instructor_code+"",
   type: 'POST',
   data: {critique_id: id}
  });
};
