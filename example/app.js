/*

for tiapp.xml:

<modules>
        <module platform="iphone" version="1.0">ti.viewwrapper</module>
</modules>s

*/


var self = Ti.UI.createWindow({
	backgroundColor: 'white'
});

var splitWindow = Ti.UI.iPad.createSplitWindow();

var view = Ti.UI.createView({
	backgroundColor: 'green'
});
//self.add(view);
var ViewWrapper = require('ti.viewwrapper');
var viewWrapper = ViewWrapper.createView({
	wrap:splitWindow
});

self.add(viewWrapper);

self.open();