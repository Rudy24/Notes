 //抽奖方法
var pmdLottery = {
    onGo:false,//转盘开关，防止连续点击
    index: -1, //当前转动到哪个位置，起点位置
    count: 0, //总共有多少个位置
    timer: 0, //setTimeout的ID，用clearTimeout清除
    speed: 300, //初始转动速度
    times: 0, //转动次数
    cycle: 30, //转动基本次数：即至少需要转动多少次再进入抽奖环节
    prize: -1, //中奖记录
    result: 0, //中奖位置索引
    unit:'',//每个单元格样式名称 unit-index 组成
    callback:null,
    init: function(id,callback,unit) {
        if ($(id).find(unit).length > 0) {
            var units = $(id).find(unit);
            this.obj = $(id);
            this.count = units.length;
            this.unit=unit;
            this.callback=callback;
            if (this.index) {
                $(id).find(unit+"-" + this.index).addClass("active");
            }
        }
    },
    rollIng: function() {
        var index = this.index;
        var count = this.count;
        var lottery = this.obj;
        $(lottery).find(this.unit+"-" + index).removeClass("active");
        index += 1;
        if (index > count - 1) {
            index = 0;
        }
        $(lottery).find(this.unit+"-" + index).addClass("active");
        this.index = index;
        return false;
    },
    rollResult:function(result){
        pmdLottery.times += 1;        
        pmdLottery.rollIng();
        if(result!=undefined){
          pmdLottery.result=result;
        }
        if (pmdLottery.times > pmdLottery.cycle + 10 && pmdLottery.index == pmdLottery.result) {
          pmdLottery.onGo = false;  
          var box;
          clearTimeout(lottery.timer);
          pmdLottery.prize = -1;
          pmdLottery.times = 0;
          pmdLottery.speed = 0;
          pmdLottery.callback();
          return;
        } else {
            if (pmdLottery.times < pmdLottery.cycle) {
                pmdLottery.speed -= 10;
            } else if (pmdLottery.times == pmdLottery.cycle) {
                var index = Math.random() * (pmdLottery.count) | 0;
                pmdLottery.prize = index;
            } else {
                if (pmdLottery.times > pmdLottery.cycle + 10 && ((pmdLottery.prize == 0 && pmdLottery.index == 7) || pmdLottery.prize == pmdLottery.index + 1)) {
                    pmdLottery.speed += 80;
                } else {
                    pmdLottery.speed += 20;
                }
            }
            if (pmdLottery.speed < 80) {
                pmdLottery.speed = 80;
            }
            pmdLottery.timer = setTimeout(pmdLottery.rollResult, pmdLottery.speed);
        }
    },
    stop: function(index) {
        this.prize = index;            
        return false;
    }
}
   
