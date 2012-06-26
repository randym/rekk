var ReductiveSearch = {
  
  init: function(options) {
    this.input = options.input
    this.target = options.target
    $(this.input).keyup( function() { ReductiveSearch.search() })
  },
  
  last_query: '',

  search: function() {
    var query = $(this.input).val().toLowerCase();
    var targets = $(this.target)
    if(query.length > this.last_query.length) {
      targets.each(function(index, item) {
        var item = $(this)
        if(!(item.text().toLowerCase().indexOf(query) >= 0)) {
          item.hide(); 
        }
      })
    } else if(query.length < this.last_query.length) {
      targets.each(function(index, item) {
        var item = $(this)
        if(item.text().toLowerCase().indexOf(query) >= 0) {
          item.show();
        }
      });
    } else if(query.length == 0) {
      targets.show()
    }
  }
}
  
