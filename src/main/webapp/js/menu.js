 $(function() {
        var selectmenuid =  $("#strMenuId").val();
    var submenuid = $("#strSubMenuId").val();
    $('#menu' + selectmenuid).removeClass('adbj' + selectmenuid);
    $('#menu' + selectmenuid).addClass('tr' + selectmenuid);
    $('#menu' + selectmenuid).addClass('iui');
    $('#divmenu' + selectmenuid).slideDown('normal');
    $('#sub' + submenuid).css({ 'color': '#ffffff', 'background': '#4e98e5' });

    var accordion_head = $('.jyuiq > ul> li > a'),
	accordion_body = $('.jyuiq > ul> li > .sub-menu');

    accordion_head.on('click', function(event) {
        event.preventDefault();
        if ($(this).attr('class').indexOf('iui') < 0) {
            accordion_head.each(function() {
                $(this).removeClass('iui');
                var cid = $(this).attr('id').replace('menu', '');
                $(this).removeClass('tr' + cid);
                $(this).addClass('adbj' + cid);
            });
            var menuid = this.id.replace('menu', '');
            accordion_body.slideUp('normal');
            $(this).next().stop(true, true).slideToggle('normal');
            $(this).removeClass('adbj' + menuid);
            $(this).addClass('tr' + menuid);
            $(this).addClass('iui');
        }
    });
});