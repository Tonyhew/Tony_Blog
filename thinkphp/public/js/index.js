layui.use(['layer', 'element', 'form'], function () {
	var layer = layui.layer
	element = layui.element;
	var carousel = layui.carousel;
	var laypage = layui.laypage;
	var $ = layui.jquery;
	laypage.render({
		elem: 'pages',
		count: 50 //数据总数，从服务端得到
	});
	$(".child-nav span").click(function () {
		layer.msg("请切换相应的栏目");
		$(this).addClass("child-nav-btn-this").siblings().removeClass("child-nav-btn-this");
	});

});


