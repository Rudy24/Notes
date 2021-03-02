//调用方法：
//1.初始化组件（参数：传入容器，回调方法，单元格样式)
//pmdLottery.init('#lottery',rewardResultFun,'.lottery-unit');
//注：每个单元格样式名称需带“-index”
//2.抽奖（参数：中奖单元格index）
// pmdLottery.rollResult(ram);
function rewardResultFun(){
  console.log('中奖');
}

pmdLottery.init('#lottery',rewardResultFun,'.lottery-unit');
$('.start').on('click', function (event) {
    var ram=Math.floor((Math.random()*7)); 
    console.log(ram);
     pmdLottery.rollResult(ram);
});
