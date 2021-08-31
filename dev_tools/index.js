function action(e,option){
    var wnd = '';
    var url = ''
    if(option==4){
        url = "http://localhost:5001/kapiot-46cbc/us-central1/populateAll";
    }
    else if(option==1 || option==2 || option==3){
        const rider_index = document.getElementById("rider_index").value.toString();
        const driver_index = document.getElementById("driver_index").value.toString();
        switch(option){
            case 1:
                url  = "http://localhost:5001/kapiot-46cbc/us-central1/requestDriver?r=" + rider_index + "&d=" + driver_index;
                break;
            case 2:
                url = "http://localhost:5001/kapiot-46cbc/us-central1/requestAllDrivers?r=" + rider_index;
                break;
            case 3: 
                url = "http://localhost:5001/kapiot-46cbc/us-central1/acceptRider?r=" + rider_index + "&d=" + driver_index;
                break;
        }
    }
    else{
        alert('An error occured');
    }
    wnd = window.open(url);
    wnd.close();
    e.preventDefault();
}