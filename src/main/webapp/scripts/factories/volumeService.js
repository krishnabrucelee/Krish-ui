/**
 * Panda - Cloud Management Portal
 * Copyright 2015 Assistanz.com
 *
 * VolumeService
 * @author - Jamseer N
 */


function volumeService($window, $rootScope, localStorageService, $stateParams, notify) {
    var volume = {};
    volume.volumeElements = {
        diskOfferingList: [
            {id: 1, name: 'Small', size: "5 GB", price: 0.10, custom:false},
            {id: 2, name: 'Medium', size: "10 GB", price: 0.20, custom:false},
            {id: 3, name: 'Large', size: "15 GB", price: 0.40, custom:false},
            {id: 4, name: 'Custom', size: "15 GB", price: 0.40, custom:true}
        ],
        diskOffer: {
            category : 'static',
            diskSize: {
                floor: 0,
                ceil: 1024,
                value: 0
            },
            iops: {
                floor: 0,
                ceil: 500,
                value: 0
            },
            isOpen:false
                        
        },
        
        type: [
            {id:1, name:"Performance"},
            {id:2, name:"Capacity"}
        ]
    };
    
    volume.save = function(object) {
        var homerTemplate = 'views/notification/notify.html';
        notify({message: 'Added successfully', classes: 'alert-success', templateUrl: homerTemplate});
        volume.cancel();

    };
    
    volume.saveByInstance = function(object, instance) {
        var instanceVolume = {};       
        var volumeList = localStorageService.get("volumeList");
        if(angular.isUndefined(volumeList)) {
            volumeList = {};
        }
        instanceVolume.id = volumeList.length + 1;
        instanceVolume.name = object.name;
        instanceVolume.type = object.type;
        instanceVolume.plan = object.diskOfferings;
        var dt = new Date();
        instanceVolume.createdDate = dt.getDate() + "-" + (dt.getMonth() + 1) + "-" + dt.getFullYear();
        volumeList.push(instanceVolume);
        return volumeList;
        
    };

    
    return volume;
    
}

/**
 * Pass function into module
 */
angular
    .module('homer')
    .factory('volumeService', volumeService)

