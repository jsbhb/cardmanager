/** 流程插件
 *    @detail:    流程插件
 *    @author:    linpengteng
 *    @date:      2018.10.18
 */
(function(){

    function device () {
        var deviceObj = {};
        var navigator = window.navigator;
        var userAgent = navigator.userAgent;

        var findCheck = function (val) {
            return userAgent.toLowerCase().indexOf(val) !== -1;
        };
        var findMatch = function (arr) {
            for (var i = 0; i < arr.length; i++) {
                if(deviceObj[arr[i]]()) return arr[i];
            }
            return ''
        };

        deviceObj.ipod = function() { return findCheck('ipod') };
        deviceObj.ipad = function() { return findCheck('ipad') };
        deviceObj.meego = function() { return findCheck('meego') };

        deviceObj.fxos = function() { return (findCheck('mobile') || findCheck('tablet')) && findCheck(' rv:') };
        deviceObj.fxosPhone = function() { return deviceObj.fxos() && findCheck('mobile') };
        deviceObj.fxosTablet = function() { return deviceObj.fxos() && findCheck('tablet') };

        deviceObj.blackberry = function() {return findCheck('blackberry') || findCheck('bb10') || findCheck('rim') };
        deviceObj.blackberryPhone = function() { return deviceObj.blackberry() && !findCheck('tablet') };
        deviceObj.blackberryTablet = function() { return deviceObj.blackberry() && findCheck('tablet') };

        deviceObj.windows = function() { return findCheck('windows') };
        deviceObj.windowsPhone = function() { return deviceObj.windows() && findCheck('phone') };
        deviceObj.windowsTablet = function() { return deviceObj.windows() && (findCheck('touch') && !deviceObj.windowsPhone()) };

        deviceObj.android = function() { return !deviceObj.windows() && findCheck('android') };
        deviceObj.androidPhone = function() { return deviceObj.android() && findCheck('mobile') };
        deviceObj.androidTablet = function() { return deviceObj.android() && !findCheck('mobile') };

        deviceObj.iphone = function() { return !deviceObj.windows() && findCheck('iphone') };
        deviceObj.ios = function() { return deviceObj.iphone() || deviceObj.ipod() || deviceObj.ipad() };

        deviceObj.mobile = function() {
            return (
                deviceObj.ipod() ||
                deviceObj.iphone() ||
                deviceObj.windowsPhone() ||
                deviceObj.androidPhone() ||
                deviceObj.blackberryPhone() ||
                deviceObj.fxosPhone() ||
                deviceObj.meego()
            )
        };

        deviceObj.tablet = function() {
            return (
                deviceObj.ipad() ||
                deviceObj.androidTablet() ||
                deviceObj.blackberryTablet() ||
                deviceObj.windowsTablet() ||
                deviceObj.fxosTablet()
            )
        };

        deviceObj.desktop = function() {
            return !deviceObj.tablet() && !deviceObj.mobile()
        };

        deviceObj.weChat = function() {
            var matchResult = userAgent.toLowerCase().match(/MicroMessenger/i);
            return !!matchResult && matchResult[0] === "micromessenger";
        };

        deviceObj.type = findMatch(['mobile', 'tablet', 'desktop']);
        deviceObj.os = findMatch([ 'ios', 'iphone', 'ipad', 'ipod', 'android', 'blackberry', 'windows', 'fxos', 'meego' ]);

        return deviceObj;
    }
    function isEmpty (val) {
        var v;
        if (isArray(val)) {
            for(v in val){
                return false;
            }
        }
        if (isObject(val)) {
            for(v in val){
                return false;
            }
        }
        return true;
    }
    function isUndef (val) {
        return val === null || val === undefined;
    }
    function isArray (arr) {
        return Object.prototype.toString.call(arr) === '[object Array]';
    }
    function isObject (obj) {
        return Object.prototype.toString.call(obj) === '[object Object]';
    }
    function isNumber (num) {
        return num === num && Object.prototype.toString.call(num) === '[object Number]';
    }
    function isString (str) {
        return Object.prototype.toString.call(str) === '[object String]';
    }
    function isBoolean (bool) {
        return Object.prototype.toString.call(bool) === '[object Boolean]';
    }
    function isFunction (func) {
        return Object.prototype.toString.call(func) === '[object Function]';
    }
    function inExtend (v,val) {
        var inObj;
        var inArgs;
        var isDeep;

        function extend(i, o) {
            for (var k in o) {
                var iIsArray =  isArray(i[k]);
                var oIsArray =  isArray(o[k]);
                var iIsObject = isObject(i[k]);
                var oIsObject = isObject(o[k]);
                var allIsArray = iIsArray && oIsArray;
                var allIsObject = iIsObject && oIsObject;
                if (isDeep && (allIsArray || allIsObject)) { extend(i[k], o[k]); }
                if (!isDeep || (!allIsArray && !allIsObject)) { i[k] = o[k]; }
            }
        }

        if (v === true) {
            isDeep = true;
        }

        if (!isEmpty(v)) {
            inObj = v;
            inArgs = Array.prototype.slice.call(arguments, 1);
        }

        if (!inObj) {
            inObj = val;
            inArgs = Array.prototype.slice.call(arguments, 2);
        }

        if (!inObj) {
            return inObj;
        }

        if (inObj) {
            for (var n in inArgs){
                var iIsArray =  isArray(inObj);
                var oIsArray =  isArray(inArgs[n]);
                var iIsObject = isObject(inObj);
                var oIsObject = isObject(inArgs[n]);
                if (iIsArray && oIsArray) { extend(inObj, inArgs[n]); }
                if (iIsObject && oIsObject) { extend(inObj, inArgs[n]); }
            }
        }

        return inObj;

    }

    function plugin(options) {
        return this.each(function () {
            this._flower instanceof Flower
                ? this._flower.reset(options)
                : this._flower = new Flower(this, options);
        });
    }

    function Flower(element, options){
        var that = this;
        this.$element = $(element);
        this.options = inExtend({}, options);
        this.column = isNumber(options.column)? options.column: 5;
        this.header = isString(options.header)?  options.header: '';
        this.content = isArray(options.content)?  options.content: [];
        this.evEnter = function (ev) {
            var index = $(this).index();
            var options = that.options;
            var content = options.content;
            var itemData = content[index];
            var enterIsFunc = isFunction(itemData.enterFunc);
            var leaveIsFunc = isFunction(itemData.leaveFunc);
            var eventIsOpen = isBoolean(itemData.event) && itemData.event;
            var isShowActive = eventIsOpen || enterIsFunc || leaveIsFunc;
            if (itemData && isShowActive) {
                $(this).addClass('hover');
                $(this).find('.flow-img .img').attr('src', itemData.showImg);
            }
        }
        this.evLeave = function (ev) {
            var index = $(this).index();
            var options = that.options;
            var content = options.content;
            var itemData = content[index];
            var enterIsFunc = isFunction(itemData.enterFunc);
            var leaveIsFunc = isFunction(itemData.leaveFunc);
            var eventIsOpen = isBoolean(itemData.event) && itemData.event;
            var isShowActive = eventIsOpen || enterIsFunc || leaveIsFunc;
            if (itemData && itemData.status !== 'active' && isShowActive) {
                $(this).removeClass('hover');
                $(this).find('.flow-img .img').attr('src', itemData.defImg);
            }
        }
        this.evDown = function (ev) {
            var index = $(this).index();
            var options = that.options;
            var content = options.content;
            var itemData = content[index];
            var isDesktop = device().desktop();
            var downIsFunc = isFunction(itemData.downFunc);
            var upIsFunc = isFunction(itemData.upFunc);
            var eventIsOpen = isBoolean(itemData.event) && itemData.event;
            var isShowActive = eventIsOpen || downIsFunc || upIsFunc;
            if (!isDesktop && itemData && isShowActive) {
                $(this).addClass('hover');
                $(this).find('.flow-img .img').attr('src', itemData.showImg);
            }
            if (downIsFunc) {
                itemData.downFunc();
            }
        }
        this.evUp = function (ev) {
            var index = $(this).index();
            var options = that.options;
            var content = options.content;
            var itemData = content[index];
            var isDesktop = device().desktop();
            var downIsFunc = isFunction(itemData.downFunc);
            var upIsFunc = isFunction(itemData.upFunc);
            var eventIsOpen = isBoolean(itemData.event) && itemData.event;
            var isShowActive = eventIsOpen || downIsFunc || upIsFunc;
            if (!isDesktop && itemData && itemData.status !== 'active' && isShowActive) {
                $(this).removeClass('hover');
                $(this).find('.flow-img .img').attr('src', itemData.defImg);
            }
            if (upIsFunc) {
                itemData.upFunc();
            }
        }
        this.init();
    }

    Flower.prototype.reset = function(options){
        inExtend(this.options, options);
        this.column = isNumber(this.options.column)? this.options.column: 5;
        this.header = isString(this.options.header)? this.options.header: '';
        this.content = isArray(this.options.content)? this.options.content: [];
        this.offEvent();
        this.empty();
        this.init();
    };

    Flower.prototype.init = function(){
        this.onEvent();
        this.render();
        this.style();
    }

    Flower.prototype.offEvent = function(){
        var that = this;
        var $element = that.$element;
        $element.off('touchstart', '.flow-item', this.evDown);
        $element.off('touchend',   '.flow-item', this.evUp);
        $element.off('mousedown',  '.flow-item', this.evDown);
        $element.off('mouseup',    '.flow-item', this.evUp);
        $element.off('mouseenter', '.flow-item', this.evEnter);
        $element.off('mouseleave', '.flow-item', this.evLeave);
    }

    Flower.prototype.onEvent = function(){
        var that = this;
        var $element = that.$element;
        var isDesktop = device().desktop();
        if (!isDesktop) {
            $element.on('touchstart', '.flow-item', this.evDown);
            $element.on('touchend',   '.flow-item', this.evUp);
        }
        if (isDesktop) {
            $element.on('mousedown',  '.flow-item', this.evDown);
            $element.on('mouseup',    '.flow-item', this.evUp);
            $element.on('mouseenter', '.flow-item', this.evEnter);
            $element.on('mouseleave', '.flow-item', this.evLeave);
        }
    }

    Flower.prototype.empty = function(){
        this.$element.find("[class^='flow-']").remove();
    }

    Flower.prototype.render = function(){
        var $flowHeader = $('<div class="flow-header"></div>');
        var $flowContent = $('<div class="flow-content"></div>');
        if (this.header) {
            $flowHeader.append('<span class="text">' + this.header + '</span>');
        }
        if (this.content) {
            $.each(this.content, function(index, data){
                var title = data.title || '';
                var defImg = data.defImg || '';
                var showImg = data.showImg || '';
                var describe = data.describe || '';
                var isActive = data.status === 'active';
                var flowImg = isActive && showImg? showImg: defImg;
                var $flowCode = $('<span class="flow-code"></span>');
                var $flowItem = $('<div class="flow-item ' + data.status + '"></div>');
                var $flowImg =  $('<div class="flow-img"><img class="img" src="' + flowImg + '"/></div>');
                var $flowTitle = $('<span class="flow-title"><span class="text">' + title + '</span></span>');
                var $flowDescribe = $('<span class="flow-describe"><span class="text">' + describe + '</span></span>');
                $flowItem.append($flowImg);
                $flowItem.append($flowTitle);
                $flowItem.append($flowCode);
                $flowItem.append($flowDescribe);
                $flowContent.append($flowItem);
            });
        }
        this.$element.append($flowHeader);
        this.$element.append($flowContent);
    }

    Flower.prototype.style = function(){
        var that = this;
        var column = this.column;
        var $element = this.$element;
        $element.find('.flow-content .flow-item').each(function(index){
            var options = that.options;
            var content = options.content;
            var itemData = content[index];
            var downIsFunc = isFunction(itemData.downFunc);
            var upIsFunc = isFunction(itemData.upFunc);
            if (downIsFunc || upIsFunc){
                $(this).css({
                    width: 100/column + '%',
                    cursor: 'pointer'
                });
            }
            else {
                $(this).css({
                    width: 100/column + '%'
                });
            }
        })
    }

    $.fn.flower = plugin;

}());

