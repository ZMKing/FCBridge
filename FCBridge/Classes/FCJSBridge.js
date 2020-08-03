/* eslint-disable */
window.FCCallBackList = {};

window.SM = {
    //存储
    storage: {
        setItem:setItemsmbridgejs,        // 存储数据    smbridgejs
        getItem:getItemsmbridgejs,        // 读取数据
        removeItem:removeItemsmbridgejs,  // 删除数据
        getUserInfo:getUserInfosmbridgejs,// 获取用户信息
        getAppInfo:getAppInfosmbridgejs   // 获取APP信息
    },
    // 相机
    camera:{
        getQrCode:getQrCodesmbridgejs,   // 获取二维码
        getBarCode:getBarCodesmbridgejs, // 获取条形码
        getImage:getImagesmbridgejs,     // 获取图片  相册 相机 全部
    },
    // 位置
    location:{
        setLocationDescription:setLocationDescriptionsmbridgejs, // 设置位置权限
        getLocationDescription:getLocationDescriptionsmbridgejs, // 获取已设置的位置权限类型
    }

};

String.prototype.hashCode = function() {
    var hash = 0;
    if (this.length == 0) return hash;
    for (var index = 0; index < this.length; index++) {
        var charactor = this.charCodeAt(index);
        hash = ((hash << 5) - hash) + charactor;
        hash = hash & hash;
    }
    return hash;
};



window.Callback = function(identifier, resultStatus, resultData) {

    callBackDict = window.FCCallBackList[identifier];

    if (callBackDict) {

        isFinished = true;
        var json = JSON.parse(resultData);
 
        if (resultStatus == "success") {

            callBackDict(json);
        }
        if (resultStatus == "fail") {

            json["result"] = 'fail';

            callBackDict(json);
        }
        if (resultStatus == "progress") {
            isFinished = false;
            callBackDict(resultData);
        }

        if (isFinished) {
            window.FCCallBackList[identifier] = null;
            delete window.FCCallBackList[identifier];
        }
    }
}

var JSCallBackMethodManager = {
    removeAllCallBacks: function(data){
        window.FCCallBackList = {};
    }
};


// Storage   ================存储===================
function setItemsmbridgejs(key, value, success){

    var dataString = encodeURIComponent(JSON.stringify({'abc':value}));
    var timestamp = Date.parse(new Date());
    var identifier = ('storage' + 'setItem' + dataString + timestamp).hashCode().toString();
    window.FCCallBackList[identifier] = success;

    window.webkit.messageHandlers.WKNativeMethodMessage.postMessage({
        targetName:'storage',
        actionName:'writeNativeData',
        data:{'storageKey' : key, 'storageValue': value},
        identifier:identifier,
    });

}

function getItemsmbridgejs(key, success){

    var timestamp = Date.parse(new Date());
    var identifier = ('storage' + 'getItem' + key + timestamp).hashCode().toString();
    window.FCCallBackList[identifier] = success;

    window.webkit.messageHandlers.WKNativeMethodMessage.postMessage({
        targetName:'storage',
        actionName:'readNativeData',
        data:{'storageKey':key},
        identifier:identifier,
    });

}


function removeItemsmbridgejs(key, success){

    var timestamp = Date.parse(new Date());
    var identifier = ('storage' + 'removeItem' + key + timestamp).hashCode().toString();
    window.FCCallBackList[identifier] = success;

    window.webkit.messageHandlers.WKNativeMethodMessage.postMessage({
        targetName:'storage',
        actionName:'removeItem',
        data:{'storageKey': key},
        identifier:identifier,
    });

}

function getAppInfosmbridgejs(success){

    var dataString = encodeURIComponent(JSON.stringify({}));
    var timestamp = Date.parse(new Date());
    var identifier = ('storage' + 'getAppInfo' + dataString + timestamp).hashCode().toString();
    window.FCCallBackList[identifier] = success;

    window.webkit.messageHandlers.WKNativeMethodMessage.postMessage({
        targetName:'storage',
        actionName:'getAppInfo',
        data:{},
        identifier:identifier,
    });
}


function getUserInfosmbridgejs(success){

    var dataString = encodeURIComponent(JSON.stringify({}));
    var timestamp = Date.parse(new Date());
    var identifier = ('storage' + 'getUserInfo' + dataString + timestamp).hashCode().toString();
    window.FCCallBackList[identifier] = success;

    window.webkit.messageHandlers.WKNativeMethodMessage.postMessage({
        targetName:'storage',
        actionName:'getUserInfo',
        data:{},
        identifier:identifier,
    });
}


// camera ====================相机====================
function getQrCodesmbridgejs(success){

    var dataString = encodeURIComponent(JSON.stringify({}));
    var timestamp = Date.parse(new Date());
    var identifier = ('storage' + 'getUserInfo' + dataString + timestamp).hashCode().toString();
    window.FCCallBackList[identifier] = success;

    window.webkit.messageHandlers.WKNativeMethodMessage.postMessage({
        targetName:'camera',
        actionName:'getQrCode',
        data:{},
        identifier:identifier,
    });
}

function getBarCodesmbridgejs(success){

    var dataString = encodeURIComponent(JSON.stringify({}));
    var timestamp = Date.parse(new Date());
    var identifier = ('storage' + 'getBarCode' + dataString + timestamp).hashCode().toString();
    window.FCCallBackList[identifier] = success;

    window.webkit.messageHandlers.WKNativeMethodMessage.postMessage({
        targetName:'camera',
        actionName:'getBarCode',
        data:{},
        identifier:identifier,
    });
}
//  cameraType:相机 photoType：相册 all：相机和相册
function getImagesmbridgejs(type, success){

    var dataString = encodeURIComponent(JSON.stringify({'type':type}));
    var timestamp = Date.parse(new Date());
    var identifier = ('storage' + 'getPhotoImg' + dataString + timestamp).hashCode().toString();
    window.FCCallBackList[identifier] = success;

    window.webkit.messageHandlers.WKNativeMethodMessage.postMessage({
        targetName:'camera',
        actionName:'getPhotoImg',
        data:{'type': type},
        identifier:identifier,
    });
}


// location ===================位置权限======================
function setLocationDescriptionsmbridgejs(type, success){

    var dataString = encodeURIComponent(JSON.stringify({'type':type}));
    var timestamp = Date.parse(new Date());
    var identifier = ('location' + 'setLocationDescription' + dataString + timestamp).hashCode().toString();
    window.FCCallBackList[identifier] = success;

    window.webkit.messageHandlers.WKNativeMethodMessage.postMessage({
        targetName:'location',
        actionName:'setLocationDescription',
        data:{'type': type},
        identifier:identifier,
    });
}

function getLocationDescriptionsmbridgejs(success){

    var dataString = encodeURIComponent(JSON.stringify({'type':''}));
    var timestamp = Date.parse(new Date());
    var identifier = ('location' + 'getLocationDescription' + dataString + timestamp).hashCode().toString();
    window.FCCallBackList[identifier] = success;

    window.webkit.messageHandlers.WKNativeMethodMessage.postMessage({
        targetName:'location',
        actionName:'getLocationDescription',
        data:{},
        identifier:identifier,
    });
}
