"use strict";
var vscode = require("vscode");
var sorter_1 = require("./sorter");
function activate(context) {
    var disposable = vscode.commands.registerTextEditorCommand("extension.sort", sorter_1.sorter);
    context.subscriptions.push(disposable);
}
exports.activate = activate;
//# sourceMappingURL=extension.js.map