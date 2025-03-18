
$(document).ready(function() {
    var toggleSwitch = $('#data-collection-toggle');
    var collectNow = $('#recolt_now');

    $.ajax({
        url: '../data-collection/fetch-status',
        method: 'POST',
        success: function(response) {
            var status = JSON.parse(response).status;
            if (status) {
                toggleSwitch.prop('checked', true); 
            } else {
                toggleSwitch.prop('checked', false);
            }
        },
        error: function() {
            console.error('Failed to fetch status.');
        }
    });

    collectNow.on('click',function(){
        $.ajax({
            url: '../data-collection/collect',
            method: 'POST',
            success: function(response) {
                console.log(response);
            },
            error: function() {
                console.error('Failed to collect.');
            }
        });

    });
    
    toggleSwitch.on('change', function() {
        var isEnabled  = toggleSwitch.is(':checked'); //récupère la valeur du bouton switch
        
        // Requêtes AJAX
        if(isEnabled){
            $.ajax({
                url: '../data-collection/start-scheduler',
                method: 'POST',
                success: function(response) {
                    console.log(response);
                },
                error: function() {
                    console.error('Failed to start the scheduler.');
                }
            });
        }else{
            $.ajax({
                url: '../data-collection/stop-scheduler',
                method: 'POST',
                success: function(response) {
                    console.log(response);
                },
                error: function() {
                    console.error('Failed to stop the scheduler.');
                }
            });
        }       
        
    });
});