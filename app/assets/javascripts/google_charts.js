
		google.load("visualization", "1", {packages:["corechart"]});

    var doit;

          //re-draw the google charts 100ms after a window re-size has been completed
    $(window).resize(function() {
      clearTimeout(doit);
      doit = setTimeout(function() {
          drawAllCharts();
      }, 100);
    });


    //called by clicking on a tab. when a tab is selected, set a 10ms timer and then re-draw all google charts
    function initTimeout() {
      clearTimeout(doit);
      doit = setTimeout(function() {
          drawAllCharts();
      }, 10);
    }

    //draw all google charts after page load has completed
    google.setOnLoadCallback(function() {
      drawAllCharts();
    });

