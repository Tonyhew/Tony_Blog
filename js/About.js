layui.use(['element', 'jquery', 'form', 'layedit'], function () {

    var element = layui.element;
    var form = layui.form;
    var $ = layui.jquery;
    var layedit = layui.layedit;


    //评论和留言的编辑器
    var editIndex = layedit.build('remarkEditor', {
        height: 150,
        tool: ['face', '|', 'left', 'center', 'right', '|', 'link'],
    });
    //评论和留言的编辑器的验证
    layui.form.verify({
        content: function (value) {
            value = $.trim(layedit.getText(editIndex));
            if (value == "") return "自少得有一个字吧";
            layedit.sync(editIndex);
        }
    });

    var layid = location.hash.replace(/^#tabIndex=/, '');
    if (layid == "") {
        element.tabChange('tabAbout', 1);
    }
    element.tabChange('tabAbout', layid);
    element.on('tab(tabAbout)', function (elem) {
        location.hash = 'tabIndex=' + $(this).attr('lay-id');
    });

    //监听留言提交
    form.on('submit(formLeaveMessage)', function (data) {
        var index = layer.load(1);
        //模拟留言提交
        setTimeout(function () {
            layer.close(index);
            var content = data.field.editorContent;
            var html =
                '<li><div class="comment-parent"><img src="img/avatar/0.jpg"alt="模拟留言"/><div class="info"><span class="username">模拟留言</span></div><div class="content">' +
                content +
                '</div><p class="info info-footer"><span class="time">2017-03-18 18:09</span><a class="btn-reply"href="javascript:;" onclick="btnReplyClick(this)">回复</a></p></div><!--回复表单默认隐藏--><div class="replycontainer layui-hide"><form class="layui-form"action=""><div class="layui-form-item"><textarea name="replyContent"lay-verify="replyContent"placeholder="请输入回复内容"class="layui-textarea"style="min-height:80px;"></textarea></div><div class="layui-form-item"><button class="layui-btn layui-btn-mini"lay-submit="formReply"lay-filter="formReply">提交</button></div></form></div></li>';
            $('.blog-comment').append(html);
            $('#remarkEditor').val('');
            editIndex = layui.layedit.build('remarkEditor', {
                height: 150,
                tool: ['face', '|', 'left', 'center', 'right', '|', 'link'],
            });
            layer.msg("留言成功", {
                icon: 1
            });
        }, 500);
        return false;
    });

    //监听留言回复提交
    form.on('submit(formReply)', function (data) {
        var index = layer.load(2);
        //模拟留言回复
        setTimeout(function () {
            layer.close(index);
            var content = data.field.replyContent;
            var html =
                '<div class="comment-child"><img src="img/avatar/00.jpg" alt="Absolutely"/><div class="info"><span class="username">模拟回复</span><span>' +
                content +
                '</span></div><p class="info"><span class="time">2017-03-18 18:26</span></p></div>';
            $(data.form).find('textarea').val('');
            $(data.form).parent('.replycontainer').before(html).siblings('.comment-parent').children(
                'p').children('a').click();
            layer.msg("回复成功", {
                icon: 1
            });
        }, 500);
        return false;
    });


    DrawCanvas();
});

systemTime();

function btnReplyClick(elem) {
    var $ = layui.jquery;
    $(elem).parent('p').parent('.comment-parent').siblings('.replycontainer').toggleClass('layui-hide');
    if ($(elem).text() == '回复') {
        $(elem).text('收起')
    } else {
        $(elem).text('回复')
    }
}

function systemTime() {
    //获取系统时间。
    var dateTime = new Date();
    var year = dateTime.getFullYear();
    var month = dateTime.getMonth() + 1;
    var day = dateTime.getDate();
    var hh = dateTime.getHours();
    var mm = dateTime.getMinutes();
    var ss = dateTime.getSeconds();

    //分秒时间是一位数字，在数字前补0。
    mm = extra(mm);
    ss = extra(ss);

    //将时间显示到ID为time的位置，时间格式形如：19:18:02
    document.getElementById("time").innerHTML = year + "-" + month + "-" + day + " " + hh + ":" + mm + ":" + ss;
    //每隔1000ms执行方法systemTime()。
    setTimeout("systemTime()", 1000);
}

//补位函数。
function extra(x) {
    //如果传入数字小于10，数字前补一位0。
    if (x < 10) {
        return "0" + x;
    } else {
        return x;
    }
}



function DrawCanvas() {
    var $ = layui.jquery;
    var canvas = document.getElementById('canvas-banner');
    canvas.width = window.document.body.clientWidth; //需要重新设置canvas宽度，因为dom加载完毕后有可能没有滚动条
    var ctx = canvas.getContext('2d');

    ctx.strokeStyle = (new Color(150)).style;

    var dotCount = 20; //圆点数量
    var dotRadius = 70; //产生连线的范围
    var dotDistance = 70; //产生连线的最小距离
    var screenWidth = screen.width;
    if (screenWidth >= 768 && screenWidth < 992) {
        dotCount = 130;
        dotRadius = 100;
        dotDistance = 60;
    } else if (screenWidth >= 992 && screenWidth < 1200) {
        dotCount = 140;
        dotRadius = 140;
        dotDistance = 70;
    } else if (screenWidth >= 1200 && screenWidth < 1700) {
        dotCount = 140;
        dotRadius = 150;
        dotDistance = 80;
    } else if (screenWidth >= 1700) {
        dotCount = 200;
        dotRadius = 150;
        dotDistance = 80;
    }
    //默认鼠标位置 canvas 中间
    var mousePosition = {
        x: 50 * canvas.width / 100,
        y: 50 * canvas.height / 100
    };
    //小圆点
    var dots = {
        count: dotCount,
        distance: dotDistance,
        d_radius: dotRadius,
        array: []
    };

    function colorValue(min) {
        return Math.floor(Math.random() * 255 + min);
    }

    function createColorStyle(r, g, b) {
        return 'rgba(' + r + ',' + g + ',' + b + ', 0.8)';
    }

    function mixComponents(comp1, weight1, comp2, weight2) {
        return (comp1 * weight1 + comp2 * weight2) / (weight1 + weight2);
    }

    function averageColorStyles(dot1, dot2) {
        var color1 = dot1.color,
            color2 = dot2.color;

        var r = mixComponents(color1.r, dot1.radius, color2.r, dot2.radius),
            g = mixComponents(color1.g, dot1.radius, color2.g, dot2.radius),
            b = mixComponents(color1.b, dot1.radius, color2.b, dot2.radius);
        return createColorStyle(Math.floor(r), Math.floor(g), Math.floor(b));
    }

    function Color(min) {
        min = min || 0;
        this.r = colorValue(min);
        this.g = colorValue(min);
        this.b = colorValue(min);
        this.style = createColorStyle(this.r, this.g, this.b);
    }

    function Dot() {
        this.x = Math.random() * canvas.width;
        this.y = Math.random() * canvas.height;

        this.vx = -.5 + Math.random();
        this.vy = -.5 + Math.random();

        this.radius = Math.random() * 2;

        this.color = new Color();
    }

    Dot.prototype = {
        draw: function () {
            ctx.beginPath();
            ctx.fillStyle = "#fff";
            ctx.arc(this.x, this.y, this.radius, 0, Math.PI * 2, false);
            ctx.fill();
        }
    };

    function createDots() {
        for (i = 0; i < dots.count; i++) {
            dots.array.push(new Dot());
        }
    }

    function moveDots() {
        for (i = 0; i < dots.count; i++) {

            var dot = dots.array[i];

            if (dot.y < 0 || dot.y > canvas.height) {
                dot.vx = dot.vx;
                dot.vy = -dot.vy;
            } else if (dot.x < 0 || dot.x > canvas.width) {
                dot.vx = -dot.vx;
                dot.vy = dot.vy;
            }
            dot.x += dot.vx;
            dot.y += dot.vy;
        }
    }

    function connectDots1() {
        var pointx = mousePosition.x;
        for (i = 0; i < dots.count; i++) {
            for (j = 0; j < dots.count; j++) {
                i_dot = dots.array[i];
                j_dot = dots.array[j];

                if ((i_dot.x - j_dot.x) < dots.distance && (i_dot.y - j_dot.y) < dots.distance && (i_dot.x - j_dot.x) >
                    -dots.distance && (i_dot.y - j_dot.y) > -dots.distance) {
                    if ((i_dot.x - pointx) < dots.d_radius && (i_dot.y - mousePosition.y) < dots.d_radius && (i_dot.x -
                            pointx) > -dots.d_radius && (i_dot.y - mousePosition.y) > -dots.d_radius) {
                        ctx.beginPath();
                        ctx.strokeStyle = averageColorStyles(i_dot, j_dot);
                        ctx.moveTo(i_dot.x, i_dot.y);
                        ctx.lineTo(j_dot.x, j_dot.y);
                        ctx.stroke();
                        ctx.closePath();
                    }
                }
            }
        }
    }

    function drawDots() {
        for (i = 0; i < dots.count; i++) {
            var dot = dots.array[i];
            dot.draw();
        }
    }

    function animateDots() {
        ctx.clearRect(0, 0, canvas.width, canvas.height);
        moveDots();
        connectDots1()
        drawDots();

        requestAnimationFrame(animateDots);
    }
    //鼠标在canvas上移动
    $('canvas').on('mousemove', function (e) {
        mousePosition.x = e.pageX;
        mousePosition.y = e.pageY;
    });

    //鼠标移出canvas
    $('canvas').on('mouseleave', function (e) {
        mousePosition.x = canvas.width / 2;
        mousePosition.y = canvas.height / 2;
    });

    createDots();

    requestAnimationFrame(animateDots);
}

//监听窗口大小改变
window.addEventListener("resize", resizeCanvas, false);

//窗口大小改变时改变canvas宽度
function resizeCanvas() {
    var canvas = document.getElementById('canvas-banner');
    canvas.width = window.document.body.clientWidth;
    canvas.height = window.innerHeight * 1 / 3;
}
