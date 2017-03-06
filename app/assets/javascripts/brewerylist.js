var BREWERIES = {}
var namesorted = false
var yearsorted = false
var beerssorted = false
var activesorted = false

BREWERIES.show = function(){
  $("#brewerytable tr:gt(0)").remove();
    var table = $("#brewerytable");

    $.each(BREWERIES.list, function (index, brewery) {
      table.append('<tr>'
                      +'<td>'+brewery['name']+'</td>'
                      +'<td>'+brewery['year']+'</td>'
                      +'<td>'+brewery['beers'].length+'</td>'
                      +'<td>'+brewery['active']+'</td>'
                  +'</tr>');
    });
};

BREWERIES.sort_by_name = function(){
    BREWERIES.list.sort( function(a,b){
        namesorted = true;
        return a.name.toUpperCase().localeCompare(b.name.toUpperCase());
    });
};

BREWERIES.sort_by_year = function(){
    BREWERIES.list.sort( function(a,b){
        yearsorted = true;
        return a.year < b.year;
    });
};

BREWERIES.sort_by_beers = function(){
    BREWERIES.list.sort( function(a,b){
        beerssorted = true;
        return a.beers.length < b.beers.length;
    });
};

BREWERIES.sort_by_active = function(){
    BREWERIES.list.sort( function(a,b){
        activesorted = true;
        return (a.active == b.active)? 0 : a.active? -1 : 1;
    });
};

$(document).ready(function () {

    $("#name").click(function (e) {
      if (namesorted) BREWERIES.list.reverse();
      else BREWERIES.sort_by_name();
      BREWERIES.show();
      e.preventDefault();
  });

  $("#year").click(function (e) {
      if (yearsorted) BREWERIES.list.reverse();
      else BREWERIES.sort_by_year();
      BREWERIES.show();
      e.preventDefault();
  });

  $("#beers").click(function (e) {
      if (beerssorted) BREWERIES.list.reverse();
      else BREWERIES.sort_by_beers();
      BREWERIES.show();
      e.preventDefault();
  });

  $("#active").click(function (e) {
      if (activesorted) BREWERIES.list.reverse();
      else BREWERIES.sort_by_active();
      BREWERIES.show();
      e.preventDefault();
  });

  $.getJSON('breweries.json', function (breweries) {
      BREWERIES.list = breweries;
      BREWERIES.show();
  });
});
