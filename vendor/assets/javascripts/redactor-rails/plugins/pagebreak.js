(function ($R) {
	$R.add('plugin', 'pagebreak', {
		translations: {
			en: {
				"pagebreak": "Page Break"
			}
		},
		init: function (app) {
			this.app = app;
			this.lang = app.lang;
			this.inline = app.inline;
			this.insertion = app.insertion;
			this.toolbar = app.toolbar;
		},
		start: function () {
			// create the button data
			var buttonData = {
				title: this.lang.get('pagebreak'),
				api: 'plugin.pagebreak.toggle'
			};

			// create the button
			var $button = this.toolbar.addButton('pagebreak', buttonData);
		},
		toggle: function () {
			this.insertion.insertHtml("<div class='page-split'></div><div class='break-after hidde-text'>PAGE BREAK</div>");
		}
	});
})(Redactor);
