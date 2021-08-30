/* eslint-disable linebreak-style */
/* eslint-disable indent */
const ridersList = [
    {
        id: "rider1",
        acceptingDriver: null,
        endLocation: {
            address: "Pitogo, Cebu, Philippines",
            lat: 10.3786493,
            lng: 123.97360830000001,
        },
        riderCount: 1,
        runtimeType: "rider",
        startLocation: {
            address: "9W2R+GQF, Mandaue City, Cebu, Central Visayas, Philippines",
            lat: 10.350618,
            lng: 123.9415964,
        },
        timeOfTrip: "2021-08-27T20:02:56.483457",
        user: {
            displayName: "Blithe Jan Tristen Gonzales",
            email: "18102570@usc.edu.ph",
            id: "rider1",
            phoneNumber: "09331239087",
            photoUrl: "https://lh3.googleusercontent.com/a/AATXAJzgbfEHTT7-WV0Sd2LdNZ4squ9aJYtOx_vQpdwE=s96-c",
        }
    },
    {
        id: "rider2",
        acceptingDriver: {
            displayName: "Charles Jr. Ausejo",
            email: "16100938@usc.edu.ph",
            id: "driver1",
            phoneNumber: "09450987654",
            photoUrl: "https://lh3.googleusercontent.com/a-/AOh14Gjh4llC1Ytss067CwoSHmRmHaY31OblZIjSdywz=s96-c",
        },
        endLocation: {
            address: "Basak, Lapu-Lapu City, Cebu, Philippines",
            lat: 10.291023899999999,
            lng: 123.961041,
        },
        riderCount: 1,
        runtimeType: "rider",
        startLocation: {
            address: "Maximo V. Patalinghug Jr Avenue, Lapu-Lapu City, Cebu, Central Visayas, Philippines",
            lat: 10.3006433,
            lng: 123.9625267,
        },
        timeOfTrip: "2021-08-29T06:45:22.819077",
        user: {
            displayName: "Nicolas Paolo Pepito",
            email: "16100825@usc.edu.ph",
            id: "rider2",
            phoneNumber: "09451230987",
            photoUrl: "https://lh3.googleusercontent.com/a-/AOh14GhoQ2pytZ4kx2_MyWLFd1-lAht5b6rtEGvTpj9L=s96-c",
        }
    }
];

const driversList = [
    {
        id: "driver1",
        encodedRoute: "syz}@}krsViAh@FJRM^SRKHIACj@UjBy@dDiBxAq@zDuAdCw@xIcCrAfCT\VRtBpDrAlBfHzD~DxB",
        riderCount: 2,
        runtimeType: "driver",
        timeOfTrip: "2021-08-29T06:47:07.099561",
        user: {
            displayName: "Charles Jr. Ausejo",
            email: "16100938@usc.edu.ph",
            id: "driver1",
            phoneNumber: "09450987654",
            photoUrl: "https://lh3.googleusercontent.com/a-/AOh14Gjh4llC1Ytss067CwoSHmRmHaY31OblZIjSdywz=s96-c"
        }
    },
    {
        id: "driver2",
        encodedRoute: "wxj~@setsVCJKPRVjAdBnAlBh@~@^z@L^j@pCp@xDf@|AdCtGTj@x@`CX~@gAj@a@V",
        riderCount: 3,
        runtimeType: "driver",
        timeOfTrip: "2021-08-30T12:41:39.580591",
        user: {
            displayName: "Nicolas Paolo Pepito",
            email: "16100825@usc.edu.ph",
            id: "driver2",
            phoneNumber: "09451230987",
            photoUrl: "https://lh3.googleusercontent.com/a-/AOh14GhoQ2pytZ4kx2_MyWLFd1-lAht5b6rtEGvTpj9L=s96-c"
        }
    },
    {
        id: "driver3",
        encodedRoute: "w|g~@{|hsVCQ@MTLl@Lx@@F_@BIFEdCg@nA_@t@a@VUFMFc@Ka@Ue@AOCm@Ke@i@aA}@yBc@_A_@i@o@m@YPK@ME",
        riderCount: 1,
        runtimeType: "driver",
        timeOfTrip: "2021-08-30T13:45:35.234433",
        user: {
            displayName: "Christian Benedict Gonzales",
            email: "cgonz@gmail.com",
            id: "driver3",
            phoneNumber: "09451231234",
            photoUrl: "https://lh3.googleusercontent.com/a-/AOh14Gi6RZJXfmElWMUsZUJ0O7zZwQboH7mEH3Hcnxmc=s96-c"
        }
    }
];

const singleRider = {
    // id: "single_add",
    // name: "Jane",
    // address: "Tunga sa old bridge",
    id: "rider1",
    acceptingDriver: null,
    endLocation: {
        address: "Pitogo, Cebu, Philippines",
        lat: 10.3786493,
        lng: 123.97360830000001,
    },
    riderCount: 1,
    runtimeType: "rider",
    startLocation: {
        address: "9W2R+GQF, Mandaue City, Cebu, Central Visayas, Philippines",
        lat: 10.350618,
        lng: 123.9415964,
    },
    timeOfTrip: "2021-08-27T20:02:56.483457",
    user: {
        displayName: "Blithe Jan Tristen Gonzales",
        email: "18102570@usc.edu.ph",
        id: "rider1",
        phoneNumber: "09331239087",
        photoUrl: "https://lh3.googleusercontent.com/a/AATXAJzgbfEHTT7-WV0Sd2LdNZ4squ9aJYtOx_vQpdwE=s96-c",
    } 
};

const requestingRider = [
    // {
    //     id: "requesting1",
    //     name: "Irish",
    //     address: "Lahug",
    // },
    // {
    //     id: "requesting2",
    //     name: "Angel",
    //     address: "Labangon",
    // },
    {
        id: "rider1",
        acceptingDriver: null,
        endLocation: {
            address: "Pitogo, Cebu, Philippines",
            lat: 10.3786493,
            lng: 123.97360830000001,
        },
        riderCount: 1,
        runtimeType: "rider",
        startLocation: {
            address: "9W2R+GQF, Mandaue City, Cebu, Central Visayas, Philippines",
            lat: 10.350618,
            lng: 123.9415964,
        },
        timeOfTrip: "2021-08-27T20:02:56.483457",
        user: {
            displayName: "Blithe Jan Tristen Gonzales",
            email: "18102570@usc.edu.ph",
            id: "rider1",
            phoneNumber: "09331239087",
            photoUrl: "https://lh3.googleusercontent.com/a/AATXAJzgbfEHTT7-WV0Sd2LdNZ4squ9aJYtOx_vQpdwE=s96-c",
        }
    },
    {
        id: "rider2",
        acceptingDriver: null,
        endLocation: {
            address: "Basak, Lapu-Lapu City, Cebu, Philippines",
            lat: 10.291023899999999,
            lng: 123.961041,
        },
        riderCount: 1,
        runtimeType: "rider",
        startLocation: {
            address: "Maximo V. Patalinghug Jr Avenue, Lapu-Lapu City, Cebu, Central Visayas, Philippines",
            lat: 10.3006433,
            lng: 123.9625267,
        },
        timeOfTrip: "2021-08-29T06:45:22.819077",
        user: {
            displayName: "Nicolas Paolo Pepito",
            email: "16100825@usc.edu.ph",
            id: "rider2",
            phoneNumber: "09451230987",
            photoUrl: "https://lh3.googleusercontent.com/a-/AOh14GhoQ2pytZ4kx2_MyWLFd1-lAht5b6rtEGvTpj9L=s96-c",
        }
    }
];

module.exports = {
    ridersList,
    driversList,
    singleRider,
    requestingRider,
};


