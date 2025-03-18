


$(document).ready(function() {
    checkCountry();
    var script = document.createElement('script');

    var apiKey = 'YOUR_googleapis_API_KEY_HERE';
 
    script.src = 'https://maps.googleapis.com/maps/api/js?key=' + apiKey + '&libraries=places';

    
    script.defer = true;
    script.async = true;
    script.onload = function() {
        function initializeAutocomplete() {
            var input = document.getElementById('city-name');
            var options = {
                types: ['(cities)']
            };

            var autocomplete = new google.maps.places.Autocomplete(input, options);

            // Événement déclenché lorsque l'utilisateur sélectionne une suggestion
            autocomplete.addListener('place_changed', function() {
                var place = autocomplete.getPlace();

                if (place.geometry && place.geometry.location) {
                    var latitude = place.geometry.location.lat();
                    var longitude = place.geometry.location.lng();

                    document.getElementById('city-lat').value = latitude;
                    document.getElementById('city-lon').value = longitude;
                    
                }

                if (place.address_components) {
                    var city = '';

                    var i = 0; 
                    while (i < place.address_components.length) {
                        var component = place.address_components[i];

                        if (component.types.includes('locality')) {
                            city = component.long_name;
                            break;
                        }
                        i++;
                    }

                    document.getElementById('city-name').value = city;
                }
                
            });
            // Événement de modification de la liste déroulante du pays
            $('#city-countryid').on('change', function() {
                checkCountry();
                $('#city-name').val('');
                restrictionCity(autocomplete);
            });

            restrictionCity(autocomplete);
        }
        
        initializeAutocomplete();
        
    };

    document.head.appendChild(script);
});

function restrictionCity(autocomplete) {

    var selectedCountryId = $('#city-countryid option:selected').val();
    var countryCode = '';

    // Récupérer le code du pays à partir de la variable "country" (contenant les données des pays)
    if (selectedCountryId && countries[selectedCountryId]) {
        countryCode = countries[selectedCountryId-1].code; //-1 le tableau commence à 0 mais pas la DB
    }

    // Restreindre la recherche de villes au pays sélectionné
    if (countryCode) {
        var componentRestrictions = { country :  countryCode };
        autocomplete.setComponentRestrictions(componentRestrictions);
    } else {
        // Réinitialiser les restrictions de composants si aucun pays n'est sélectionné
        autocomplete.setComponentRestrictions(null);
    }
}

function checkCountry(){
    console.log($('#city-countryid').val());
    if($('#city-countryid option:selected').val() == ''){
        $('#city-name').prop('disabled', true);
    }
    else{
        $('#city-name').prop('disabled', false);
    }
}