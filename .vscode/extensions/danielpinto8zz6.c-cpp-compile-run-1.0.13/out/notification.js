"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Notification = void 0;
const vscode_1 = require("vscode");
const configuration_1 = require("./configuration");
const string_utils_1 = require("./utils/string-utils");
class Notification {
    static showErrorMessage(message) {
        if (!configuration_1.Configuration.shouldShowNotifications()) {
            return;
        }
        if (string_utils_1.isStringNullOrWhiteSpace(message)) {
            return;
        }
        vscode_1.window.showErrorMessage(message);
    }
    static showInformationMessage(message) {
        if (!configuration_1.Configuration.shouldShowNotifications()) {
            return;
        }
        if (string_utils_1.isStringNullOrWhiteSpace(message)) {
            return;
        }
        vscode_1.window.showInformationMessage(message);
    }
}
exports.Notification = Notification;
//# sourceMappingURL=notification.js.map