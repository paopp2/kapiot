var prevRiderIndex = '';
var prevDriverIndex = '';
var prevRiderIdIndex = '';
var prevDriverIdIndex = '';
function action(e,option){
    var wnd = '';
    var url = ''
    if(option==4){
        url = "http://localhost:5001/kapiot-46cbc/us-central1/populateAll";
    }
    else if(option==1 || option==2 || option==3){
        const rider_index = document.getElementById("rider_index").value.toString();
        const driver_index = document.getElementById("driver_index").value.toString();
        if(option==1 || option==3){
            if(prevDriverIndex!='' && prevRiderIndex != ''){
                document.querySelector(".rider"+prevRiderIndex).classList.remove('performed');
                document.querySelector(".driver"+prevDriverIndex).classList.remove('performed');
                document.querySelector(".riderId"+prevRiderIndex).classList.remove('performed');
                document.querySelector(".driverId"+prevDriverIndex).classList.remove('performed');
            }
            document.querySelector(".rider"+rider_index).classList.add('performed');
            document.querySelector(".driver"+driver_index).classList.add('performed');
            document.querySelector(".riderId"+rider_index).classList.add('performed');
            document.querySelector(".driverId"+driver_index).classList.add('performed');
        }
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
        prevRiderIndex = rider_index;
        prevDriverIndex = driver_index;
        prevRiderIdIndex = rider_index;
        prevDriverIdIndex = driver_index;
    }
    else{
        alert('An error occured');
    }
    wnd = window.open(url);
    wnd.close();
    e.preventDefault();
}