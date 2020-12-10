"use strict";
var vscode = require("vscode");
function makeRange(start, end, document) {
    if (end.character === 0) {
        end = document.lineAt(end.line - 1).range.end;
    }
    if (start.line !== end.line) {
        start = start.with(start.line, 0);
        end = document.lineAt(end.line).range.end;
    }
    return new vscode.Range(start, end);
}
exports.makeRange = makeRange;
function sort(text, separator, locale) {
    var leadRegexp = new RegExp("^" + separator + "+");
    var trailRegexp = new RegExp(separator + "+$");
    var itemRegexp = new RegExp(separator + "+");
    var lead = leadRegexp.exec(text) || "";
    text = text.replace(leadRegexp, "");
    var trail = trailRegexp.exec(text) || "";
    text = text.replace(trailRegexp, "");
    var items = text.split(itemRegexp);
    if (text[text.length - 1] !== ",") {
        var test_1 = text.split(new RegExp("," + separator + "+"));
        if (test_1.length >= items.length) {
            items = test_1;
            separator = "," + separator;
        }
    }
    var sorted;
    if (locale !== "") {
        sorted = items.sort(function (a, b) { return a.localeCompare(b, locale); });
    }
    else {
        sorted = items.sort();
    }
    var sortedText = sorted.join(separator);
    if (text === sortedText) {
        sorted = sorted.reverse();
        sortedText = sorted.join(separator);
    }
    return lead + sortedText + trail;
}
exports.sort = sort;
function sorter(textEditor, edit) {
    var settings = vscode.workspace.getConfiguration("sort");
    var locale = settings.get("locale", "en");
    var start = textEditor.selection.start;
    var end = textEditor.selection.end;
    var range = makeRange(start, end, textEditor.document);
    var text = textEditor.document.getText(range);
    var eol = text.indexOf("\r\n") > 0 ? "\r\n" : "\n";
    var separator = (range.start.line === range.end.line) ? " " : eol;
    var sortedText = sort(text, separator, locale);
    edit.replace(range, sortedText);
}
exports.sorter = sorter;
//# sourceMappingURL=sorter.js.map