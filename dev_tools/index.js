function populateAll(e){
    const wnd = window.open("http://localhost:5001/kapiot-46cbc/us-central1/populateAll");
    wnd.close();
    e.preventDefault();
}
function acceptRider(e){
    const rider_index = document.getElementById("rider_index").value.toString();
    const driver_index = document.getElementById("driver_index").value.toString();
    const url = "http://localhost:5001/kapiot-46cbc/us-central1/acceptRider?r=" + rider_index + "&d=" + driver_index;
    const wnd = window.open(url);
    wnd.close();
    e.preventDefault();
}
function action(e,option){
    var wnd = '';
    if(option==4){
        wnd = window.open("http://localhost:5001/kapiot-46cbc/us-central1/populateAll")
    }
    else if(option==2 || option==3){
        const rider_index = document.getElementById("rider_index").value.toString();
        const driver_index = document.getElementById("driver_index").value.toString();
        if(option==2){
            window.location = "http://localhost:5001/kapiot-46cbc/us-central1/requestDriver?r=" + rider_index + "&d=" + driver_index;
        }
        else{
            const url = "http://localhost:5001/kapiot-46cbc/us-central1/acceptRider?r=" + rider_index + "&d=" + driver_index;
        }
        
        wnd = window.open(url);
    }
    wnd.close();
    e.preventDefault();
}